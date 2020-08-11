# Author: Bayu Wibowo
# Version: 1.0.0
# PowerNSX version: 3.0.1047, 3.0.1125
# 11 August 2020
# Purpose: Remove NSX Bridge to an NSX Edge DLR
# Usage: .\Remove-NsxBridge.ps1 -DLR EdgeDLRName -Bridge BridgeName
#   -DLR                - NSX Edge DLR name
#   -Bridge             - Bridge Name

param ($DLR, $Bridge)

Write-Host "`nRunning Remove-NsxBridge.ps1 script ..." -ForegroundColor "green"

if ($null -ne $DLR -And $null -eq $Bridge){
    Get-NsxLogicalRouter $DLR | Get-NsxLogicalRouterBridging | Get-NSxLogicalRouterBridge -Name $Bridge
}
else {
    Write-Host "`n"
    Write-Warning "Please provide the following mandatory parameters:
    `n -DLR EdgeDLRName -Bridge BridgeName"
    Write-Host "`nTo list NSX Edge DLR names, perform:
    `nGet-NsxLogicalRouter"
}
