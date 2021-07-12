@echo off
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
    echo Set UAC = CreateObject^("Shell.Application"^) > "getadmin.vbs"
    set params = %*:"="
    echo UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 1 >> "getadmin.vbs"

    "getadmin.vbs"
    del "getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
::--------------------------------------
echo [33mChecking SMART status of C:\ drive... Replace drive if PredictFailure = True[0m

Powershell.exe -executionpolicy remotesigned -File  "C:\Users\Admin\Desktop\Run 2nd\Scripts\smarttest.ps1"

pause


echo [33mExtending C partition... An error indicates the partition is already extended. Don't panic...[0m

Powershell.exe -executionpolicy remotesigned -File  "C:\Users\Admin\Desktop\Run 2nd\Scripts\extend.ps1"


echo [33mEjecting CD tray... An error may indicate that there is no CD tray available. Please manually eject the tray and remove any media should it fail to automatically eject.[0m

Powershell.exe -executionpolicy remotesigned -File  "C:\Users\Admin\Desktop\Run 2nd\Scripts\ejectcd.ps1"

pause


echo [33mRenaming computer...[0m

echo [31mREAD INSTRUCTIONS CAREFULLY:[0m

echo [33mPress Enter for first prompt:[0m

echo [33mSelect A then press Enter for second prompt:[0m

echo [33mPress Enter for third prompt:[0m

echo [33mAfter computer restarts, run the bios update and then CLEANUP. There should only be the Google Chrome shortcut left, delete anything else left behind. Then you're done!:[0m

Powershell.exe -executionpolicy remotesigned -File  "C:\Users\Admin\Desktop\Run 2nd\Scripts\rename.ps1"

echo Done! Restart?
pause

echo Restarting...
shutdown /r /t 5
