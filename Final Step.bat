:: BatchGotAdmin
::-------------------------------------
REM  --> Check for permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params = %*:"="
    echo UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
::--------------------------------------
@echo off

echo [31mReady to clean up?[0m
pause

echo [33mCleaning desktop...[0m
rd /s /q C:\Users\Admin\Desktop\RenameComputer

DEL /F /S /Q /A C:\Users\Admin\Desktop\*.exe

echo [33mEmpty the Recycle bin[0m
rd /s /q %systemdrive%\$Recycle.bin

DEL /F /S /Q /A C:\Users\Admin\Desktop\*.bat