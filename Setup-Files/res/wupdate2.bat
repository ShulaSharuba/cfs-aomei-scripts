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
echo [33mVerifying domain status[0m
Powershell.exe C:\res\WSUSVerify.ps1

echo [31mThe computer is not domain bound and you can proceed with the scripts safely...[0m
pause

echo [33mUpdating Windows...[0m
start ms-settings:windowsupdate
ping 127.0.0.1 -n 6 > nul
start ms-settings:windowsupdate-action

echo [33mSetting wallpaper[0m
Powershell.exe C:\res\wallpaper.ps1

echo [33mPress any key to finish and cleanup...[0m
pause 

echo [33mEmpty the Recycle bin[0m
rd /s /q %systemdrive%\$Recycle.bin

echo [33mDelete scheduled task[0m
Powershell.exe C:\res\deletetask.ps1

echo [31mRestoring Powershell Policies[0m
Powershell.exe C:\res\reset_powershell_security.ps1

echo [33mDelete res folder[0m
rd /s /q C:\res

echo [33mDelete batch file[0m
DEL /F /Q /A "C:\wupdate.bat"
