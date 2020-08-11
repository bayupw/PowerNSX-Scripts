# Author: Bayu Wibowo
# Version: 1.0.0
# PowerNSX version: 3.0.1047, 3.0.1125
# 08 August 2020
# Purpose: Retrieve NSX Security Tags from a VM
# Usage: .\Get-VMNsxSecurityTag.ps1 -VM VMname
#   -VM                     - VM name to be checked for its NSX Security Tags

param ($VM)

Write-Host "`nRunning Get-VMNsxSecurityTag.ps1 script ..." -ForegroundColor "green"

#Export VMs and their Security Tags to CSV
Write-Host "`nRetrieving Security Tags from $VM" -ForegroundColor "green"
$Tags = Get-VM $VM | Get-NsxSecurityTagAssignment
$Tags.SecurityTag.name
