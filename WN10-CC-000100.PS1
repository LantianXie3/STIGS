<#
.SYNOPSIS
    Disables Web-based Point and Print (WebPnP) driver downloads.

.DESCRIPTION
    This script sets the registry value 'DisableWebPnPDownload' to 1 under the path:
    HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Printers\

    This prevents the automatic download and installation of printer drivers via WebPnP.

.NOTES
    Author          : Lantian Xie  
    LinkedIn        : https://www.linkedin.com/in/lantian-xie/  
    GitHub          : https://github.com/LantianXie3  
    Date Created    : 2025-07-31  
    Last Modified   : 2025-07-31  
    Version         : 1.0  
    STIG ID         : WN10-PR-000150  

.TESTED ON
    Date(s) Tested  : 2025-07-31  
    Systems Tested  : Windows 10, Windows 11  
    PowerShell Ver. : 5.1, 7.x  

.USAGE
    PS C:\> .\Set-DisableWebPnPDownload.ps1
#>

# CONFIGURATION
$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Printers"
$valueName = "DisableWebPnPDownload"
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
    Write-Output "$valueName set to $desiredValue — WebPnP download is now disabled."
} else {
    Write-Output "$valueName is already correctly set to $desiredValue. No changes made."
}
