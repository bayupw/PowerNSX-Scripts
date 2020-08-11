# Author: Bayu Wibowo
# Version: 1.0.0
# PowerNSX version: 3.0.1047, 3.0.1125
# 08 August 2020
# Purpose: Copy NSX Security Tags from a VM to another VM
# Usage: .\Copy-NsxSecurityTag.ps1 -CopyFromVM SourceVMName -CopyToVM DestinationVMName
#   -CopyFromVM             - Source VM Name
#   -CopyToVM               - Destination VM Name

param ($CopyFromVM, $CopyToVM)

Write-Warning "Copying Security Tags from $CopyFromVM to $CopyToVM"

$confirmation = Read-Host "`nAre you sure you want to proceed? [y/n]"
while($confirmation -ne "y"){
    if ($confirmation -eq 'n') {exit}
    $confirmation = Read-Host "`nAre you sure you want to proceed? [y/n]"
}

Write-Host "`nRunning Copy-NsxSecurityTag.ps1 script ..." -ForegroundColor "green"

Write-Host "`nRetrieving Security Tags from $CopyFromVM" -ForegroundColor "green"
$Tags = Get-VM $CopyFromVM | Get-NsxSecurityTagAssignment
$Tags.SecurityTag.name

Write-Host "`n"

foreach ($Tag in $Tags.SecurityTag.name){ 
 Write-Host "Assigning Security Tag" $Tag "to $CopyToVM" -ForegroundColor "yellow"
 Get-VM $CopyToVM | New-NsxSecurityTagAssignment -ApplyTag -SecurityTag (Get-NsxSecurityTag $Tag)
}

Write-Host "`nRetrieving Security Tags from $CopyToVM" -ForegroundColor "green"
$NewVMTags = Get-VM $CopyToVM | Get-NsxSecurityTagAssignment
$NewVMTags.SecurityTag.name
