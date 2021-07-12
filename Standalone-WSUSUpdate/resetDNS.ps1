function Reset-DNS {
    foreach ($c in Get-NetAdapter){Set-DnsClientServerAddress -InterfaceAlias $c.name -ResetServerAddresses}
    }

Reset-DNS
    if ((ipconfig /all | Select-String -Pattern '192.168.1.254' -quiet) -eq $true)
        {
            break
        }
Restart-Computer -Force