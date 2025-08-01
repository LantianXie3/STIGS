<#
.SYNOPSIS
    Disables Microsoft Consumer Experiences on Windows 10.

.DESCRIPTION
    This script sets the 'DisableWindowsConsumerFeatures' registry value to 1.
    This prevents Windows from installing suggested consumer apps and features.

.NOTES
    Author          : Lantian Xie  
    LinkedIn        : https://www.linkedin.com/in/lantian-xie/  
    GitHub          : https://github.com/LantianXie3  
    Date Created    : 2025-07-31  
    Last Modified   : 2025-07-31  
    Version         : 1.0  
    STIG ID         : WN10-CC-000430  

.TESTED ON
    Date(s) Tested  : 2025-07-31  
    Systems Tested  : Windows 10 Pro, Enterprise, Education  
    PowerShell Ver. : 5.1, 7.x  

.USAGE
    PS C:\> .\Remediate-DisableConsumerFeatures.ps1
#>

# Registry info
$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent"
$valueName = "DisableWindowsConsumerFeatures"
$desiredValue = 1

# Ensure the key exists
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Check and set value
$currentValue = Get-ItemProperty -Path $regPath -Name $valueName -ErrorAction SilentlyContinue

if ($null -eq $currentValue -or $currentValue.$valueName -ne $desiredValue) {
    New-ItemProperty -Path $regPath -Name $valueName -Value $desiredValue -PropertyType DWord -Force | Out-Null
    Write-Output "$valueName was missing or incorrect. Set to $desiredValue."
} else {
    Write-Output "$valueName is already correctly set to $desiredValue."
}
