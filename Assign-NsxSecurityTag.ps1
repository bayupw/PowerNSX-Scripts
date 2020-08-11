# Author: Bayu Wibowo
# Version: 1.0.0
# PowerNSX version: 3.0.1047, 3.0.1125
# 09 August 2020
# Purpose: Assign an NSX Security Tag to VMs
# Usage 1: .\Assign-NsxSecurityTag.ps1 -Tag SecurityTagName -VM VMName
# Usage 2: .\Assign-NsxSecurityTag.ps1 -Tag SecurityTagName -VMInputFile VMInputFilePath
# Usage 3: .\Assign-NsxSecurityTag.ps1 -TagInputFile TagInputFilePath -VM VMName
# Usage 4: .\Assign-NsxSecurityTag.ps1 -TagInputFile TagInputFilePath -VMInputFile VMInputFilePath
#   -Tag            - NSX Security Tag Name
#   -VM             - Source VM Name
#   -TagInputFile   - Path to an Input File of NSX Security Tag list
#   -VMInputFile    - Path to an Input File of VM list

param ($Tag, $VM, $TagInputFile, $VMInputFile)

Write-Host "`nRunning Assign-NsxSecurityTag.ps1 script ..." -ForegroundColor "green"

if ($null -ne $Tag -And $null -ne $VM){
    Write-Host "`nThis script will add $Tag to $VM" -ForegroundColor "green"

    $confirmation = Read-Host "`nAre you sure you want to proceed? [y/n]"
    while($confirmation -ne "y"){
        if ($confirmation -eq 'n') {exit}
        $confirmation = Read-Host "`nAre you sure you want to proceed? [y/n]"
    }

    Write-Host "Assigning Security Tag" $Tag "to $VM" -ForegroundColor "yellow"
    Get-VM $VM | New-NsxSecurityTagAssignment -ApplyTag -SecurityTag (Get-NsxSecurityTag $Tag)
}
elseif ($null -ne $Tag -And $null -ne $VMInputFile) {
    $VMList = Get-Content $VMInputFile
    Write-Host "`nThis script will add $Tag to the following VMs" -ForegroundColor "green"
    $VMList

    $confirmation = Read-Host "`nAre you sure you want to proceed? [y/n]"
    while($confirmation -ne "y"){
        if ($confirmation -eq 'n') {exit}
        $confirmation = Read-Host "`nAre you sure you want to proceed? [y/n]"
    }

    $VMs = Get-VM $VMList
    foreach ($VM in $VMs){ 
            Write-Host "Assigning Security Tag" $Tag "to $VM" -ForegroundColor "yellow"
            Get-VM $VM | New-NsxSecurityTagAssignment -ApplyTag -SecurityTag (Get-NsxSecurityTag $Tag)
        }
}
elseif ($null -ne $TagInputFile -And $null -ne $VM){
    $Tags = Get-Content $TagInputFile
    Write-Host "`nThis script will add the following Security Tags to $VM" -ForegroundColor "green"
    $Tags

    $confirmation = Read-Host "`nAre you sure you want to proceed? [y/n]"
    while($confirmation -ne "y"){
        if ($confirmation -eq 'n') {exit}
        $confirmation = Read-Host "`nAre you sure you want to proceed? [y/n]"
    }

    foreach ($Tag in $Tags){ 
        Write-Host "Assigning Security Tag" $Tag "to $VM" -ForegroundColor "yellow"
        Get-VM $VM | New-NsxSecurityTagAssignment -ApplyTag -SecurityTag (Get-NsxSecurityTag $Tag)
    }
}
elseif ($null -ne $TagInputFile -And $null -ne $VMInputFile) {
    $Tags = Get-Content $TagInputFile
    $VMList = Get-Content $VMInputFile
    Write-Host "`nThis script will add the following Security Tags" -ForegroundColor "green"
    $Tags
    Write-Host "`nto the following VMs" -ForegroundColor "green"
    $VMList

    $confirmation = Read-Host "`nAre you sure you want to proceed? [y/n]"
    while($confirmation -ne "y"){
        if ($confirmation -eq 'n') {exit}
        $confirmation = Read-Host "`nAre you sure you want to proceed? [y/n]"
    }

    $VMs = Get-VM $VMList

    foreach ($Tag in $Tags){ 
        foreach ($VM in $VMs){ 
            Write-Host "Assigning Security Tag" $Tag "to $VM" -ForegroundColor "yellow"
            Get-VM $VM | New-NsxSecurityTagAssignment -ApplyTag -SecurityTag (Get-NsxSecurityTag $Tag)
        }
    }   
}
else {
    Write-Host "`n"
    Write-Warning "Please provide one of the following parameters:
    `n -Tag & -VM
    `n -Tag & -VMInputFile
    `n -TagInputFile & -VM
    `n -TagInputFile & -VMInputFile
    "
}
