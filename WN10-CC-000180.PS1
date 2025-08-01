<#
.SYNOPSIS
    Disables AutoPlay for non-volume devices.

.DESCRIPTION
    This script configures the registry setting to prevent AutoPlay from executing for non-volume devices such as MTP devices. 
    This helps mitigate the risk of automatic execution of potentially malicious code.

.NOTES
    Author          : Lantian Xie  
    LinkedIn        : https://www.linkedin.com/in/lantian-xie/  
    GitHub          : https://github.com/LantianXie3  
    Date Created    : 2025-07-31  
    Last Modified   : 2025-07-31  
    Version         : 1.0  
    STIG ID         : WN10-CC-000020  

.TESTED ON
    Date(s) Tested  : 2025-07-31  
    Systems Tested  : Windows 10 Pro, Enterprise, LTSC  
    PowerShell Ver. : 5.1, 7.x  

.USAGE
    PS C:\> .\Remediate-NoAutoplayfornonVolume.ps1
#>

# Registry configuration
$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer"
$valueName = "NoAutoplayfornonVolume"
$desiredValue = 1

# Ensure the registry path exists
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Get current value if it exists
$currentValue = Get-ItemProperty -Path $regPath -Name $valueName -ErrorAction SilentlyContinue

# Set or correct the value
if ($null -eq $currentValue -or $currentValue.$valueName -ne $desiredValue) {
    New-ItemProperty -Path $regPath -Name $valueName -Value $desiredValue -PropertyType DWord -Force | Out-Null
    Write-Output "$valueName was set to $desiredValue to disable AutoPlay for non-volume devices."
} else {
    Write-Output "$valueName is already set to $desiredValue. No changes needed."
}
