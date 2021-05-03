# Check SMART status of C
# https://stackoverflow.com/questions/58453447/smart-hard-drive-info-powershell
Get-WmiObject -namespace root\wmi -class MSStorageDriver_FailurePredictStatus -ErrorAction Silentlycontinue | Select InstanceName, PredictFailure, Reason