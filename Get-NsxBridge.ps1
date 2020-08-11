# Author: Bayu Wibowo
# Version: 1.0.0
# PowerNSX version: 3.0.1047, 3.0.1125
# 11 August 2020
# Purpose: Get Static Routes from NSX Edge(s)
# Usage: .\Get-NsxBridge.ps1 -DLR EdgeDLRName -Vlan VLANID -ExportPath ExportFilePath
#   -DLR                - NSX Edge DLR name
#   -Vlan               - Vlan ID
#   -ExportPath         - Export CSV Path 

param ($DLR, $Vlan, $ExportPath)

Write-Host "`nRunning Get-NsxEdgeStaticRoute.ps1 script ..." -ForegroundColor "green"

if ($null -eq $DLR -And $null -eq $Vlan){
    if ($null -ne $ExportPath){
        Write-Host "`nRetrieving Bridges on the following NSX Edge DLRs and exporting to $ExportPath ..." -ForegroundColor "green"
        Get-NsxLogicalRouter | Select-Object id, name
        Get-NsxLogicalRouter | Get-NsxEdgeRouting | Get-NsxEdgeStaticRoute | Format-Table | Export-csv $ExportPath
    }
    else{ 
        Write-Host "`nRetrieving Bridges on the following NSX Edge DLRs ..." -ForegroundColor "green"
        Get-NsxLogicalRouter | Select-Object id, name
        Get-NsxLogicalRouter | Get-NsxLogicalRouterBridging | Get-NSxLogicalRouterBridge | Format-Table
    }
}
elseif ($null -ne $DLR -And $null -eq $Vlan){
    if ($null -ne $ExportPath){
        Write-Host "`nRetrieving Bridges on NSX Edge DLR $DLR and exporting to $ExportPath ..." -ForegroundColor "green"
        Get-NsxLogicalRouter $DLR | Get-NsxLogicalRouterBridging | Get-NSxLogicalRouterBridge | Format-Table | Export-csv $ExportPath
    }
    else{ 
        Write-Host "`nRetrieving Bridges on NSX Edge DLR $DLR ..." -ForegroundColor "green"
        Get-NsxLogicalRouter $DLR | Get-NsxLogicalRouterBridging | Get-NSxLogicalRouterBridge | Format-Table
    }
}
elseif ($null -eq $DLR -And $null -ne $Vlan){
    $VlanPortGroup = Get-VDPortgroup | Where-Object { $_.VlanConfiguration.VlanId -eq $Vlan }

    if ($null -ne $ExportPath){
        Write-Host "`nRetrieving Bridge of VLAN $Vlan on the following NSX Edge DLRs and exporting to $ExportPath ..." -ForegroundColor "green"
        Get-NsxLogicalRouter | Select-Object id, name
        Get-NsxLogicalRouter | Get-NsxEdgeRouting | Get-NsxEdgeStaticRoute | Where-Object { $_.dvportGroupName -eq $VlanPortGroup } | Format-Table | Export-csv $ExportPath
    }
    else{ 
        Write-Host "`nRetrieving Bridge of VLAN $Vlan on the following NSX Edge DLRs ..." -ForegroundColor "green"
        Get-NsxLogicalRouter | Select-Object id, name
        Get-NsxLogicalRouter | Get-NsxEdgeRouting | Get-NsxEdgeStaticRoute | Where-Object { $_.dvportGroupName -eq $VlanPortGroup } | Format-Table
    }
}
elseif ($null -ne $DLR -And $null -ne $Vlan){
    $VlanPortGroup = Get-VDPortgroup | Where-Object { $_.VlanConfiguration.VlanId -eq $Vlan }

    if ($null -ne $ExportPath){
        Write-Host "`nRetrieving Bridge of VLAN $Vlan on NSX Edge DLR $DLR and exporting to $ExportPath ..." -ForegroundColor "green"
        Get-NsxLogicalRouter $DLR | Get-NsxEdgeRouting | Get-NsxEdgeStaticRoute | Where-Object { $_.dvportGroupName -eq $VlanPortGroup } | Format-Table | Export-csv $ExportPath
    }
    else{ 
        Write-Host "`nRetrieving Bridge of VLAN $Vlan on NSX Edge DLR $DLR ..." -ForegroundColor "green"
        Get-NsxLogicalRouter $DLR | Get-NsxEdgeRouting | Get-NsxEdgeStaticRoute | Where-Object { $_.dvportGroupName -eq $VlanPortGroup } | Format-Table
    }
}
