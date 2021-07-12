# Eject CD tray
function Eject-CD
{
  $drives = Get-WmiObject Win32_Volume -Filter "DriveType=5"
  if ($drives -eq $null)
  {
    Write-Warning "Your computer has no CD drives to eject."
    return
  } 
  $drives | ForEach-Object {
    (New-Object -ComObject Shell.Application).Namespace(17).ParseName($_.Name).InvokeVerb("Eject")
  }
}
Eject-CD