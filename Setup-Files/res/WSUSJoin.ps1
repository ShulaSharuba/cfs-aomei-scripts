function Reset-DNS {
    foreach ($c in Get-NetAdapter){Set-DnsClientServerAddress -InterfaceAlias $c.name -ResetServerAddresses}
    }
function Set-DNS {
    foreach ($c in Get-NetAdapter){Set-DnsClientServerAddress -InterfaceAlias $c.name -ServerAddresses "192.168.1.9"}
    }

if ((gwmi win32_computersystem).partofdomain -eq $true) {
    Write-Host -fore green "Fetching updates from WSUS server..."
    start ms-settings:windowsupdate
    start ms-settings:windowsupdate-action
    Write-Host -fore green "Leave WSUS domain? Run this step once the computer is up to date."
    pause
    Write-Host -fore yellow "Leaving WSUS domain"
    Write-Host -fore red "DO NOT CLOSE THIS PROMPT. THE COMPUTER MUST LEAVE THE DOMAIN BEFORE PROCEEDING"
    Write-Host -fore red "If the prompt is closed before completion YOU MUST RESTART THE COMPUTER or run C:\wupdate.bat"
    Write-Host -fore yellow "Please enter Wifi password when prompted"
    write-host -fore yellow "Computer will automatically restart on success"
    Set-DNS
    while(1)
    {
        Remove-Computer -UnjoinDomainCredential CFS\WSUSUser -erroraction continue -PassThru
        if ((gwmi win32_computersystem).partofdomain -eq $true) {
            Write-Host -fore Red "FAILED TO LEAVE DOMAIN!!! Try again"
            pause
        } else {
            while(1)
            {
                Reset-DNS
                if ((ipconfig /all | Select-String -Pattern '192.168.1.254' -quiet) -eq $true)
                    {
                        break
                    }
            }
            Remove-Item C:\wupdate.bat
            Move-Item C:\res\wupdate2.bat C:\wupdate.bat
            Restart-Computer -Force
        }
    }
} else {
    Write-Host -fore green "Joining WSUS domain"
    Write-Host -fore green "Please enter Wifi password when prompted"
    Write-host -fore red "-> regnCFS55"
    write-host -fore green "Computer will automatically restart on success"
    Set-DNS
    while(1)
    {
        Add-Computer -DomainName CFS -Credential CFS\WSUSUser -erroraction continue -PassThru -restart
        pause
    }
}