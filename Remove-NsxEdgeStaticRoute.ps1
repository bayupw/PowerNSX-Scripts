# Author: Bayu Wibowo
# Version: 1.0.0
# PowerNSX version: 3.0.1047, 3.0.1125
# 11 August 2020
# Purpose: Remove a Static Route from an NSX Edge
# Usage: .\Remove-NsxEdgeStaticRoute.ps1 -Edge NSXEdgeName -Network x.x.x.x/y
#   -Edge               - NSX Edge name
#   -Network            - Network/Subnet mask x.x.x.x/y

param ($Edge, $Network, $NextHop, $Description)

Write-Host "`nRunning Remove-NsxEdgeStaticRoute.ps1 script ..." -ForegroundColor "green"

if ($null -ne $Edge -And $null -ne $Network -And $null -ne $NextHop){
    Write-Host "`nChecking existing route for $Network on NSX Edge $Edge ..." -ForegroundColor "green"
    $Route = Get-NsxEdge $Edge | Get-NsxEdgeRouting | Get-NsxEdgeStaticRoute | Where-Object { $_.network -eq $Network }
    if ($Route.network.count -ne 0) {
        Write-Host "`nExisting route for $Network on NSX Edge $Edge ..."
        Get-NsxEdge $Edge | Get-NsxEdgeRouting | Get-NsxEdgeStaticRoute | Where-Object { $_.network -eq $Network } | Format-Table

        Write-Host "`nRemoving route for $Network on NSX Edge $Edge ..."
        Get-NsxEdge $Edge | Get-NsxEdgeRouting | Get-NsxEdgeStaticRoute | Where-Object { $_.network -eq $Network } | Remove-NsxEdgeStaticRoute
    }
    if ($Route.network.count -eq 0) {
        Write-Host "`nRoute for $Network does not exist on NSX Edge $Edge..."
    }
}
else {
    Write-Host "`n"
    Write-Warning "Please provide the following mandatory parameters:
    `n -Edge NSXEdgeName -Network x.x.x.x/y"
    Write-Host "`nTo list NSX Edge names, perform:
    `nGet-NsxEdge | Select-Object id, name"
}
