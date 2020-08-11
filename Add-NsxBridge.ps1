# Author: Bayu Wibowo
# Version: 1.0.0
# PowerNSX version: 3.0.1047, 3.0.1125
# 11 August 2020
# Purpose: Add NSX Bridge to an NSX Edge DLR
# Usage: .\Add-NsxBridge.ps1 -DLR EdgeDLRName -Bridge BridgeName -PortGroup PortGroupName -LogicalSwitch LogicalSwitchName
#   -DLR                - NSX Edge DLR name
#   -Bridge             - Vlan ID
#   -ExportPath         - Export CSV Path 

param ($DLR, $Bridge, $PortGroup, $LogicalSwitch)

Write-Host "`nRunning Add-NsxBridge.ps1 script ..." -ForegroundColor "green"

if ($null -ne $DLR -And $null -eq $Bridge -And $null -eq $PortGroup -And $null -eq $LogicalSwitch){
    $PortGroupObject = Get-VDPortgroup $PortGroup
    $Vlan = $PortGroupObject.VlanConfiguration.VlanId
    $LogicalSwitchObject = Get-NsxLogicalSwitch $LogicalSwitch

    Write-Host "`nCreating new Bridge $Bridge, bridging $PortGroup on VLAN $Vlan with $LogicalSwitch on NSX Edge DLR $DLR..." -ForegroundColor "green"
    $confirmation = Read-Host "`nAre you sure you want to proceed? [y/n]"
    while($confirmation -ne "y"){
        if ($confirmation -eq 'n') {exit}
        $confirmation = Read-Host "`nAre you sure you want to proceed? [y/n]"
    }

    Get-NsxLogicalRouter $DLR | Get-NsxLogicalRouterBridging | New-NsxLogicalRouterBridge -Name $BridgeName -PortGroup $PortGroupObject -LogicalSwitch $LogicalSwitchObject
}
else {
    Write-Host "`n"
    Write-Warning "Please provide the following mandatory parameters:
    `n -DLR EdgeDLRName -Bridge BridgeName -PortGroup PortGroupName -LogicalSwitch LogicalSwitchName"
    Write-Host "`nTo list NSX Edge DLR names, perform:
    `nGet-NsxLogicalRouter"
}
