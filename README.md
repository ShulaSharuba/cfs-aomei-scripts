# CFS Regina WDS and Aomei System Image Deployment Scripts

***

## WDS Stage

Before uploading the image to Aomei, please make sure to do the following:

* Copy contents of "Copy-Contents-To-Desktop" to the desktop #okwegetit
* Copy the bios update to the desktop
* Open command prompt as administrator and run `sfc /scannow`
* Run disk cleanup to remove excess Windows update files
* Open "Device Manager" and check for any missing drivers
* Test the webcam (if required)

### Setup-Files + RunLast-WDS-Final-Step.bat

The Setup-Files dir contents need to be copied to the root of the C:\ drive on WDS captured systems. It contains:

#### Folder Contents

> **1st stage Task Scheduler script**
> 
> wupdate.bat

> **res folder**
>
> > **Desktop Wallpaper**
> >
> > 2020CFSbackground.png
> 
> > **2nd stage Task Scheduler script**
> > 
> > wupdate2.bat
> 
> > **Readme for the res folder**
> > 
> > README.txt
> 
> > **WSUS Join scripts**
> > 
> > WSUSJoin.ps1
> > 
> > WSUSVerify.ps1
> 
> > **Wallpaper script**
> >
> > wallpaper.ps1
> 
> > **Post setup powershell security reset**
> > 
> > reset_powershell_security.ps1
> 
> > **Task scheduler WDSSUPER deletion script**
> >
> > deletetask.ps1

The following file is excluded from the Setup-Files directory. This is because it is not required to be copied to the host machine. Copying this file to the host will require you to delete the file manually afterwards, however it can be run from the NAS without problem.

> **Final step script. This script can be run from the NAS and is the last script that should be run BEFORE you upload the system image to Aomei. You do not need to copy this script to the C:\ drive**
> 
> RunLast-WDS-Final-Step.bat

***

## Aomei Stage

### Copy-Contents-To-Desktop

As the folder name suggests, the contents need to be copied to and run from the desktop. RunMe.bat will only work if the username is "Admin". The contents of this folder need to be copied over to the desktop after the WDS deployment, however the scripts should only be run after the Aomei deployment. 

#### Folder Contents

> **Run 2nd folder**
> 
> > **RunMe script used to run the scripts within the "Scripts" folder**
> >
> > RunMe.bat
> 
> > **Scripts folder**
> > 
> > > **HDD SMART test script (checks for any failed critical values)**
> > > 
> > > smarttest.ps1
> > 
> > > **Extend disk partition script**
> > > 
> > > extend.ps1
> > 
> > > **Eject CD tray script**
> > >
> > > ejectcd.ps1
> >
> > > **Computer random name generator**
> > >
> > > rename.ps1

> **Cleanup script. Only run after the bios update and Run 2nd scripts**
>
> Final Step.bat

***

## Updating Old Aomei Images Using WSUS

Sometimes it can be quicker and more efficient to update Aomei deployed systems using WSUS instead of re-imaging the system. This is only useful if:

* The system has an SSD
* The system does not have several cumulative updates to install
* The system does not have a dinosaur CPU

### Standalone-WSUSUpdate

1. Copy the "Standalone-WSUSUpdate" folder to the desktop.
2. Run the "RunMe.bat" script to join the domain.
3. After the computer reboots, check for updates, reboot and rinse repeat until the system says there are no updates remaining.
4. Run "RunMe.bat" again to leave the WSUS domain.
5. It is good practice to run `sfc /scannow` from CMD after leaving the domain. This should be done if you notice problems with Windows updates after leaving the WSUS domain.

#### Troubleshooting (WSUS sucks and everyone knows it)

1. Windows takes a long time to check for updates and spits out an error.
   
        This is usually because WSUS is in the process of downloading new updates for the system. You can either wait until the download is finished or if time sensitive you can leave the domain and fetch some updates the old fashion way.

2. I know that there are more updates but the server says everything is downloaded.

        Run the reportnow script: "RunMe - ReportNow.bat". This does not always fix the issue.

#### Folder Contents

> **Main script needed to join and leave the domain**
> 
> RunMe.bat

> **Troubleshooting script for when it appears the system is not getting the updates it needs**
> 
> RunMe - ReportNow.bat

> **Script called by RunMe.bat to join the system to the WSUS domain**
> 
> WSUSJoin.ps1

> **Script called once you leave the domain to reset factory defaults to DNS servers**
> 
> resetDNS.ps1

> **Script called by "RunMe - ReportNow.bat"**
> 
> ReportNow.ps1

***

## Answer Files

The answer files are required for WDS to function as a zero touch automated deployment that is compatible with all systems regardless of hardware (until something newer comes out TM).

> **PE stage answerfile for legacy bios systems. The drive is configured to be formatted with a master boot record (MBR)**
> 
> ClientUnattend1909Win10ProAutoInstall_04-15-2020.xml

> **PE stage answerfile for UEFI bios systems. The drive is configured to be formatted with GPT**
> 
> UEFIClientUnattend_10-01-2020 (Change MODIFY PART).xml

> **OOBE stage answerfile used to skip all of the setup popups. Creates new user "Admin", sets blank password to never expire and sets the region to CA.**
> 
> OOBEUnattend20H2Win10ProAutoInstall_02-24-2021.xml