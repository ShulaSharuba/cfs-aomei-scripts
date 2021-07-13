function Reset-DNS {
    foreach ($c in Get-NetAdapter){Set-DnsClientServerAddress -InterfaceAlias $c.name -ResetServerAddresses}
    }
function Set-DNS {
    foreach ($c in Get-NetAdapter){Set-DnsClientServerAddress -InterfaceAlias $c.name -ServerAddresses "192.168.1.9"}
    }

Write-Host "Please view the README for more detailed instructions"
if ((gwmi win32_computersystem).partofdomain -eq $true) {
    write-host -fore green "Leaving WSUS domain"
    Write-Host -fore green "Please enter Wifi password when prompted"
    write-host -fore green "Computer will automatically restart on success"
    while(1)
    {
        remove-computer -UnjoinDomainCredential CFS\WSUSUser -erroraction continue -PassThru
        if ((gwmi win32_computersystem).partofdomain -eq $true) {
            write-host -fore Red "FAILED TO LEAVE DOMAIN!!! Try again"
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
            Restart-Computer -Force
        }
    }
} else {
    write-host -fore green "Joining WSUS domain"
    Write-Host -fore green "Please enter Wifi password when prompted"
    write-host -fore green "Computer will automatically restart on success"
    Set-DNS
    while(1)
    {
        add-computer -DomainName CFS -Credential CFS\WSUSUser -erroraction continue -PassThru -restart
        pause
    }
}