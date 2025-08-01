<#
.SYNOPSIS
    Disables user control of Windows Installer features.

.DESCRIPTION
    This script sets the 'EnableUserControl' registry value to 0 under the Windows Installer policy key.
    This prevents users from changing installation options that may bypass security features.

.NOTES
    Author          : Lantian Xie  
    LinkedIn        : https://www.linkedin.com/in/lantian-xie/  
    GitHub          : https://github.com/LantianXie3  
    Date Created    : 2025-07-31  
    Last Modified   : 2025-07-31  
    Version         : 1.0  
    STIG ID         : WN10-CC-000215  

.TESTED ON
    Date(s) Tested  : 2025-07-31  
    Systems Tested  : Windows 10 Pro, Enterprise, LTSC  
    PowerShell Ver. : 5.1, 7.x  

.USAGE
    PS C:\> .\Remediate-EnableUserControl.ps1
#>

# Registry details
$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Installer"
$valueName = "EnableUserControl"
$desiredValue = 0

# Ensure key exists
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Get current value
$currentValue = Get-ItemProperty -Path $regPath -Name $valueName -ErrorAction SilentlyContinue

# Set the value if missing or incorrect
if ($null -eq $currentValue -or $currentValue.$valueName -ne $desiredValue) {
    New-ItemProperty -Path $regPath -Name $valueName -Value $desiredValue -PropertyType DWord -Force | Out-Null
    Write-Output "$valueName was missing or incorrect. Set to $desiredValue."
} else {
    Write-Output "$valueName is already correctly set to $desiredValue."
}
