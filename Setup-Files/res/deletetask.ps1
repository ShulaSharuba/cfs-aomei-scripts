if ($(Get-ScheduledTask -TaskName "WDSSUPER" -ErrorAction SilentlyContinue).TaskName -eq "WDSSUPER") {
    Unregister-ScheduledTask -TaskName "WDSSUPER" -Confirm:$False
}
