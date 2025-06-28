<#
.SYNOPSIS
    Build multiple export formats (CSV, JSON, YAML) from a master device lookup list.
.DESCRIPTION
    Reads the canonical source CSV and emits formatted files into an exports folder.
    Works whether run as a script or interactively in PowerShell.
    Requires PowerShell 7.0+ for ConvertTo-Yaml. Adjust paths as needed.
#>

# Locate script directory; PSScriptRoot works when executed as script
$scriptDir = if ($PSScriptRoot) { $PSScriptRoot } else { (Get-Location).Path }

# Define paths using simple relative references
$sourceCsv = Resolve-Path "$scriptDir/../source/source.csv"
$exportDir = "$scriptDir/../exports"

# # Define source and export directories
# $sourceCsv = Join-Path -Path $baseDir -ChildPath 'source\source.csv'
# $exportDir = Join-Path -Path $baseDir -ChildPath 'exports'

# Ensure exports directory exists
if (-Not (Test-Path -Path $exportDir)) {
    New-Item -ItemType Directory -Path $exportDir | Out-Null
}

# Import the master CSV
Write-Host "Loading source file: $sourceCsv"
$records = Import-Csv -Path $sourceCsv

# Filter records that don't have a 'DeviceManufacturerPattern' or 'DeviceModelPattern'
$filteredRecords = $records | Where-Object {
    -not [string]::IsNullOrWhiteSpace($_.DeviceManufacturerPattern) -and
    -not [string]::IsNullOrWhiteSpace($_.DeviceModelPattern)
}

# 1) CSV export (copy)
$csvOut = Join-Path -Path $exportDir -ChildPath 'ChromeOSFlex-CML.csv'
$filteredRecords | Export-Csv -Path $csvOut -NoTypeInformation -Encoding UTF8 -Force
Write-Host "Exported CSV: $csvOut"

# 2) JSON export
$jsonOut = Join-Path -Path $exportDir -ChildPath 'ChromeOSFlex-CML.json'
$filteredRecords | ConvertTo-Json -Depth 5 | Out-File -FilePath $jsonOut -Encoding UTF8 -Force
Write-Host "Exported JSON: $jsonOut"