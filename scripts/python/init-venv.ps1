Write-Host "Initializing venv"

Set-Location -Path "app"
uv sync
Set-Location -Path ".."

Write-Host "Venv initialized" 