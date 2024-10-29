# Define the path to the saved power settings
$tempFolder = "C:\TempPowerSettings"
$powerSettingsFile = "$tempFolder\PowerSettingsBackup.json"

# Check if the backup file exists
if (Test-Path -Path $powerSettingsFile) {
    # Restore power settings from the saved backup file
    $powerScheme = Get-Content -Path $powerSettingsFile
    foreach ($line in $powerScheme) {
        # Execute each power setting command from the backup
        Invoke-Expression $line
    }
    Write-Output "Power settings have been restored from $powerSettingsFile."
} else {
    Write-Output "Backup file not found at $powerSettingsFile. Cannot restore power settings."
}
