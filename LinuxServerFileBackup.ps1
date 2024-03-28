# PowerShell Script for Linux Server File Backup
# Author: Aviad Ofek
# Description: This script copies files from a Linux server to a Windows machine
# and stores them in a folder named with the current date.

# Get the current date in the format 'dd-MMM-yyyy'
$timestamp = Get-Date -Format "dd-MMM-yyyy"

# Create a directory with the current date as the folder name
$backupFolder = Join-Path -Path "C:\LX\Data\web_backup" -ChildPath $timestamp

# Create the backup folder if it doesn't exist
if (-not (Test-Path -Path $backupFolder)) {
    New-Item -Path $backupFolder -ItemType Directory
}

# Sample placeholder data
$sampleUsername = "sample_user"
$samplePassword = "sample_password"
$sampleIPAddress = "192.168.1.100"
$sampleFilePaths = @(
    "/var/www/html/ips.txt",
    "/var/www/html/dns.txt",
    "/var/www/html/images/core-logo-w.png"
)

# Backup files from Linux server to the backup folder
foreach ($filePath in $sampleFilePaths) {
    & 'C:\Program Files\PuTTY\pscp.exe' -pw $samplePassword "$sampleUsername@$sampleIPAddress:$filePath" "$backupFolder\$(Split-Path $filePath -Leaf)"
}

# Inform the user that the backup process is complete
Write-Host "Backup complete. Files are stored in folder: $backupFolder"
