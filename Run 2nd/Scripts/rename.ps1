# Rename computer
Install-Module NameIT -Scope CurrentUser
$name = invoke-generate("CFS-[guid 0]")
rename-computer -newname $name