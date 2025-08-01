<#
.SYNOPSIS
    Disables RSS feed attachment downloads to improve security.

.DESCRIPTION
    Sets the registry key 'DisableEnclosureDownload' to prevent potentially unsafe attachments
    from being downloaded automatically through RSS feeds in Internet Explorer.

.NOTES
    Author          : Lantian Xie  
    LinkedIn        : https://www.linkedin.com/in/lantian-xie/  
    GitHub          : https://github.com/LantianXie3  
    Date Created    : 2025-07-31  
    Last Modified   : 2025-07-31  
    Version         : 1.0  
    STIG ID         : WN10-CC-000320  

.TESTED ON
    Date(s) Tested  : 2025-07-31  
    Systems Tested  : Windows 10, Windows 11  
    PowerShell Ver. : 5.1, 7.x  

.USAGE
    PS C:\> .\Set-DisableRSSAttachmentDownload.ps1
#>

# CONFIGURATION
$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Internet Explorer\Feeds"
$valueName = "DisableEnclosureDownload"
$desiredValue = 1

# Ensure the registry path exists
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Get current value
$currentValue = Get-ItemProperty -Path $regPath -Name $valueName -ErrorAction SilentlyContinue

# Set or update the value
if ($null -eq $currentValue -or $currentValue.$valueName -ne $desiredValue) {
    New-ItemProperty -Path $regPath -Name $valueName -Value $desiredValue -PropertyType DWord -Force | Out-Null
    Write-Output "$valueName set to $desiredValue — RSS feed attachments will not be downloaded."
} else {
    Write-Output "$valueName is already set correctly to $desiredValue. No changes made."
}
