# Extend drive C partition
# https://docs.microsoft.com/en-us/windows-server/storage/disk-management/extend-a-basic-volume
$drive_letter = "C"
$size = (Get-PartitionSupportedSize -DriveLetter $drive_letter)
Resize-Partition -DriveLetter $drive_letter -Size $size.SizeMax