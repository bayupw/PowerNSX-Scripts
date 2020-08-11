# Author: Bayu Wibowo
# Version: 1.0.0
# PowerNSX version: 3.0.1047, 3.0.1125
# 11 August 2020
# Purpose: Add Static Routes from NSX Edge(s)
# Usage: .\Add-NsxEdgeStaticRoute.ps1 -Edge NSXEdgeName -Network x.x.x.x/y -NextHop x.x.x.x -Description 'Description of the Static Route'
#   -Edge               - NSX Edge name
#   -Network            - Network/Subnet mask x.x.x.x/y
#   -NextHop            - Next hop IP Address
#   -Description        - (Optional) Static Routes Description

param ($Edge, $Network, $NextHop, $Description)

Write-Host "`nRunning Add-NsxEdgeStaticRoute.ps1 script ..." -ForegroundColor "green"

if ($null -ne $Edge -And $null -ne $Network -And $null -ne $NextHop){
    Write-Host "`nChecking existing route for $Network on NSX Edge $Edge ..." -ForegroundColor "green"
    $Route = Get-NsxEdge $Edge | Get-NsxEdgeRouting | Get-NsxEdgeStaticRoute | Where-Object { $_.network -eq $Network }
    if ($Route.network.count -eq 0) {
        Write-Host "`nRoute does not exist ... Adding route for $Network on NSX Edge $Edge ..."
        Get-NsxEdge $Edge | Get-NsxEdgeRouting | New-NsxEdgeStaticRoute -Network $Network -NextHop $NextHop -Description $Description
    }
}
else {
    Write-Host "`n"
    Write-Warning "Please provide the following mandatory parameters:
    `n -Edge NSXEdgeName -Network x.x.x.x/y -NextHop x.x.x.x"
}
