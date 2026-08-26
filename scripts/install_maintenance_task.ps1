$ErrorActionPreference = 'Stop'
$php = 'C:\xampp\php\php.exe'
$script = 'C:\xampp\htdocs\geospatial\scripts\maintenance_cleanup.php'

if (-not (Test-Path -LiteralPath $php) -or -not (Test-Path -LiteralPath $script)) {
    throw 'PHP or the maintenance script was not found.'
}

$action = New-ScheduledTaskAction -Execute $php -Argument ('"' + $script + '"') -WorkingDirectory 'C:\xampp\htdocs\geospatial'
$trigger = New-ScheduledTaskTrigger -Daily -At '2:15 AM'
$settings = New-ScheduledTaskSettingsSet -StartWhenAvailable -ExecutionTimeLimit (New-TimeSpan -Minutes 10)
Register-ScheduledTask -TaskName 'Geospatial System Maintenance' -Action $action -Trigger $trigger -Settings $settings -Description 'Removes expired login throttling rows and superseded custom logos.' -Force

Write-Output 'Scheduled task installed: Geospatial System Maintenance (daily at 2:15 AM).'
