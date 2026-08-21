#------
cls

$Desktop = [Environment]::GetFolderPath("Desktop")

$Runtime = Join-Path $Desktop "windowsdesktop-runtime-10.0.11-win-x64.exe"
$IBP     = Join-Path $Desktop "IBP_Add-in_NET10_x64.exe"

Write-Host "========================================" -ForegroundColor Cyan
Write-Host " Instalación Windows Desktop Runtime 10" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

if (-not (Test-Path $Runtime)) {
    Write-Host "ERROR: No se encontró:" -ForegroundColor Red
    Write-Host $Runtime -ForegroundColor Yellow
    exit 1
}

Write-Host "Instalando Windows Desktop Runtime..." -ForegroundColor Yellow

$Process = Start-Process -FilePath $Runtime -ArgumentList "/install", "/quiet", "/norestart" -Wait -PassThru

if ($Process.ExitCode -ne 0) {
    Write-Host "ERROR: La instalación del Runtime terminó con código $($Process.ExitCode)." -ForegroundColor Red
    exit $Process.ExitCode
}

Write-Host "Runtime instalado correctamente." -ForegroundColor Green


Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host " Instalación IBP Add-in" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

if (-not (Test-Path $IBP)) {
    Write-Host "ERROR: No se encontró:" -ForegroundColor Red
    Write-Host $IBP -ForegroundColor Yellow
    exit 1
}

Write-Host "Instalando IBP Add-in..." -ForegroundColor Yellow

$Process = Start-Process -FilePath $IBP -Wait -PassThru

if ($Process.ExitCode -ne 0) {
    Write-Host "ADVERTENCIA: IBP terminó con código $($Process.ExitCode)." -ForegroundColor Yellow
} else {
    Write-Host "IBP Add-in instalado correctamente." -ForegroundColor Green
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host " PROCESO FINALIZADO" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

Read-Host "Presiona ENTER para cerrar"
