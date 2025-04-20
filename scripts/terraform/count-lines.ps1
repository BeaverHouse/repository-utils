# Script for counting lines of all .tf files in the current directory and subdirectories
# This is PowerShell script, see count_lines.sh for the Bash version.
# Written by Austin Lee.

$totalLines = 0
$fileCount = 0

Write-Host "Calculating Terraform file line count..." -ForegroundColor Green

# Find all .tf files recursively and process them
Get-ChildItem -Path . -Filter *.tf -Recurse | ForEach-Object {
    $lines = (Get-Content $_.FullName -Encoding UTF8).Count
    $totalLines += $lines
    $fileCount++
    
    # Print information about each file
    Write-Host "$($_.FullName): $lines lines" -ForegroundColor Yellow
}

# Print final result
Write-Host "`nFinal result" -ForegroundColor Green
Write-Host "Total file count: $fileCount" -ForegroundColor Cyan
Write-Host "Total line count: $totalLines" -ForegroundColor Cyan 