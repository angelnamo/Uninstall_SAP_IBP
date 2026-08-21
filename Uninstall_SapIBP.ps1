#----

cls

$apps = @(
    Get-ItemProperty "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*" -ErrorAction SilentlyContinue
    Get-ItemProperty "HKLM:\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*" -ErrorAction SilentlyContinue
) | Where-Object {
    $_.DisplayName -eq "SAP IBP, add-in for Microsoft Excel"
}

if ($apps) {
    foreach ($app in $apps) {
        Write-Host "Desinstalando: $($app.DisplayName) - versión $($app.DisplayVersion)"

        $command = if ($app.QuietUninstallString) {
            $app.QuietUninstallString
        } else {
            $app.UninstallString
        }

        Start-Process "cmd.exe" -ArgumentList "/c $command" -Wait

        Write-Host "Desinstalación finalizada." -ForegroundColor Green
    }
}
else {
    Write-Host "SAP IBP, add-in for Microsoft Excel no está instalado." -ForegroundColor Yellow
}
