---------------------
2020 CFS Build script
Oct. 9, 2020
*Updated Jan. 7, 2021 by Marc B.
Made by Thomas H.
---------------------

This script is designed to run some simple tests as well as prep a system for later completion.

Main objectives:
- Join WSUS domain*
- Leave WSUS domain*
- Update windows
- Test speakers
- Test/Eject CD tray
- Clean up after itself

Pre-Conditions:
- Powershell security for LocalMachine and CurrentUser is set to Unrestricted
- Shurtcut to \\Nas is on the desktop*
- A folder in "C:\" named 'res' contains all the required scripts
- A copy of 'wupdate.bat' is placed outside the folder in "C:\" as well.
- A copy of '2020CFSBackground.png' is located in 'C:\Users\Public\Pictures\2020CFSbackground.png'
- A scheduled task named 'WDSSUPER' is set to run on login. It points to 'wupdate.bat' and runs it with administrator privileges. 

Post-Conditions:
- Windows updates are running or done
- Background is changed to the CFS one
- The 'res' folder is deleted
- 'wupdate.bat' is deleted
- The scheduled task 'WDSSUPER' is deleted
- CD tray is open (if it has one)
- End of script sanity check for DNS server and powershell execution policy*