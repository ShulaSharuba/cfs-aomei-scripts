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

echo [33mDeleting Setup folder and Edge shortcut:[0m
DEL /F /Q /A "C:\Users\Public\Desktop\Setup - Shortcut.lnk"
DEL /F /Q /A "C:\Users\Admin\Desktop\Microsoft Edge.lnk"

echo [33mEmpty the Recycle bin:[0m
rd /s /q %systemdrive%\$Recycle.bin

echo [33mCleaning Downloads folder:[0m
DEL /F /Q /A "C:\Users\Admin\Downloads\*.*"

echo [31mDNS SANITY CHECK!!! The DNS server MUST NOT be 192.168.1.8:[0m
ipconfig /all | findstr "DNS Servers"

echo [31mSECURITY SANITY CHECK!!! The execution policy must be either RESTRICTED or UNDEFINED:[0m
powershell.exe get-executionpolicy -scope localmachine
powershell.exe get-executionpolicy -scope currentuser

pause