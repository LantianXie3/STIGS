<#
.SYNOPSIS
    Disables the GameDVR feature in Windows 10 by setting the AllowGameDVR registry value to 0.

.DESCRIPTION
    GameDVR can record system audio and screen activity, potentially exposing sensitive information.
    This script ensures the feature is disabled via Group Policy.
    Not applicable to Windows 10 LTSC/B versions 1507 and 1607.

.NOTES
    Author          : Lantian Xie  
    LinkedIn        : https://www.linkedin.com/in/lantian-xie/  
    GitHub          : https://github.com/LantianXie3  
    Date Created    : 2025-07-31  
    Last Modified   : 2025-07-31  
    Version         : 1.0  
    CVEs            : N/A  
    Plugin IDs      : N/A  
    STIG-ID         : WN10-CC-000210  

.TESTED ON
    Date(s) Tested  : 2025-07-31  
    Tested By       : Lantian Xie  
    Systems Tested  : Windows 10 Pro 22H2 (x64)  
    PowerShell Ver. : 5.1, 7.4  

.USAGE
    PS C:\> .\Remediate-WN10-CC-000210.ps1
#>

# Skip remediation for Windows 10 LTSC/B versions 1507 and 1607
$osVersion = (Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion").ReleaseId
if ($osVersion -eq "1507" -or $osVersion -eq "1607") {
    Write-Output "This setting is not applicable to Windows 10 LTSC/B versions 1507 or 1607."
    return
}

# Define registry path and expected value
$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\GameDVR"
$valueName = "AllowGameDVR"
$desiredValue = 0

# Create registry path if it does not exist
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Check current value
$currentValue = Get-ItemProperty -Path $regPath -Name $valueName -ErrorAction SilentlyContinue

# Remediate if necessary
if ($null -eq $currentValue -or $currentValue.$valueName -ne $desiredValue) {
    New-ItemProperty -Path $regPath -Name $valueName -Value $desiredValue -PropertyType DWord -Force | Out-Null
    Write-Output "$valueName was missing or misconfigured. Value set to $desiredValue."
} else {
    Write-Output "$valueName is already correctly set to $desiredValue."
}
