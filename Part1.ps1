# Define the path to save power settings
$tempFolder = "C:\TempPowerSettings"
$powerSettingsFile = "$tempFolder\PowerSettingsBackup.json"

# Create the temp folder if it doesn't exist
if (!(Test-Path -Path $tempFolder)) {
    New-Item -ItemType Directory -Path $tempFolder | Out-Null
}

# Get current power settings and save them to a file
$powerScheme = powercfg -query
$powerScheme | Out-File -FilePath $powerSettingsFile

# Set power settings to "never off" for both plugged-in and battery modes
powercfg -change -monitor-timeout-ac 0   # Never turn off display when plugged in
powercfg -change -monitor-timeout-dc 0   # Never turn off display on battery
powercfg -change -disk-timeout-ac 0      # Never turn off hard disk when plugged in
powercfg -change -disk-timeout-dc 0      # Never turn off hard disk on battery
powercfg -change -standby-timeout-ac 0   # Never sleep when plugged in
powercfg -change -standby-timeout-dc 0   # Never sleep on battery
powercfg -change -hibernate-timeout-ac 0 # Never hibernate when plugged in
powercfg -change -hibernate-timeout-dc 0 # Never hibernate on battery

Write-Output "Current power settings have been saved to $powerSettingsFile and set to 'never off'."
