# Author: Bayu Wibowo
# Version: 1.0.0
# PowerNSX version: 3.0.1047, 3.0.1125
# 11 August 2020
# Purpose: Get Static Routes from NSX Edge(s)
# Usage: .\Get-NsxEdgeStaticRoute.ps1 -VM VMname
#   -Edge               - NSX Edge name
#   -Network            - Network/Subnet mask x.x.x.x/y
#   -ExportPath         - Export CSV Path 

param ($Edge, $Network, $ExportPath)

Write-Host "`nRunning Get-NsxEdgeStaticRoute.ps1 script ..." -ForegroundColor "green"

if ($null -eq $Edge -And $null -eq $Network){
    if ($null -ne $ExportPath){
        Write-Host "`nRetrieving routes on the following NSX Edges and exporting to $ExportPath ..." -ForegroundColor "green"
        Get-NsxEdge | Select-Object id, name
        Get-NsxEdge | Get-NsxEdgeRouting | Get-NsxEdgeStaticRoute | Format-Table | Export-csv $ExportPath
    }
    else{ 
        Write-Host "`nRetrieving routes on the following NSX Edges ..." -ForegroundColor "green"
        Get-NsxEdge | Select-Object id, name
        Get-NsxEdge | Get-NsxEdgeRouting | Get-NsxEdgeStaticRoute | Format-Table
    }
}
elseif ($null -ne $Edge -And $null -eq $Network){
    if ($null -ne $ExportPath){
        Write-Host "`nRetrieving routes on NSX Edge $Edge and exporting to $ExportPath ..." -ForegroundColor "green"
        Get-NsxEdge $Edge | Get-NsxEdgeRouting | Get-NsxEdgeStaticRoute | Format-Table | Export-csv $ExportPath
    }
    else{ 
        Write-Host "`nRetrieving routes on NSX Edge $Edge ..." -ForegroundColor "green"
        Get-NsxEdge $Edge | Get-NsxEdgeRouting | Get-NsxEdgeStaticRoute | Format-Table
    }
}
elseif ($null -eq $Edge -And $null -ne $Network){
    if ($null -ne $ExportPath){
        Write-Host "`nRetrieving route for $Network on the following NSX Edges and exporting to $ExportPath ..." -ForegroundColor "green"
        Get-NsxEdge | Select-Object id, name
        Get-NsxEdge | Get-NsxEdgeRouting | Get-NsxEdgeStaticRoute | Where-Object { $_.network -eq $Network } | Format-Table | Export-csv $ExportPath
    }
    else{ 
        Write-Host "`nRetrieving route for $Network on the following NSX Edges ..." -ForegroundColor "green"
        Get-NsxEdge | Select-Object id, name
        Get-NsxEdge | Get-NsxEdgeRouting | Get-NsxEdgeStaticRoute | Where-Object { $_.network -eq $Network } | Format-Table
    }
}elseif ($null -ne $Edge -And $null -ne $Network){
    if ($null -ne $ExportPath){
        Write-Host "`nRetrieving route for $Network on NSX Edge $Edge and exporting to $ExportPath ..." -ForegroundColor "green"
        Get-NsxEdge $Edge | Get-NsxEdgeRouting | Get-NsxEdgeStaticRoute | Where-Object { $_.network -eq $Network } | Format-Table | Export-csv $ExportPath
    }
    else{ 
        Write-Host "`nRetrieving route for $Network on NSX Edge $Edge ..." -ForegroundColor "green"
        Get-NsxEdge $Edge | Get-NsxEdgeRouting | Get-NsxEdgeStaticRoute | Where-Object { $_.network -eq $Network } | Format-Table
    }
}
