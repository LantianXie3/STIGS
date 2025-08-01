<#
.SYNOPSIS
    Enables Enhanced Anti-Spoofing for Windows Hello facial recognition.

.DESCRIPTION
    This script sets the registry value 'EnhancedAntiSpoofing' to 1 under:
    HKLM:\SOFTWARE\Policies\Microsoft\Biometrics\FacialFeatures

    This ensures that Windows Hello uses enhanced anti-spoofing technology, making facial recognition more secure.

.NOTES
    Author          : Lantian Xie  
    LinkedIn        : https://www.linkedin.com/in/lantian-xie/  
    GitHub          : https://github.com/LantianXie3  
    Date Created    : 2025-07-31  
    Last Modified   : 2025-07-31  
    Version         : 1.0  
    STIG ID         : WN10-CC-000230  

.REQUIREMENTS
    - Windows 10 version 1607 or later (not supported in v1507 LTSB)
    - Biometric hardware with facial recognition support

.USAGE
    PS C:\> .\Set-EnhancedAntiSpoofing.ps1
#>

# CONFIGURATION
$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Biometrics\FacialFeatures"
$valueName = "EnhancedAntiSpoofing"
$desiredValue = 1

# Check if system version supports this setting
$osVersion = (Get-CimInstance Win32_OperatingSystem).Version
if ($osVersion -lt "10.0.14393") {
    Write-Warning "This setting is not applicable to Windows 10 v1507 LTSB or earlier (Build < 14393)."
    return
}

# Ensure registry path exists
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Get and set value
$currentValue = Get-ItemProperty -Path $regPath -Name $valueName -ErrorAction SilentlyContinue

if ($null -eq $currentValue -or $currentValue.$valueName -ne $desiredValue) {
    New-ItemProperty -Path $regPath -Name $valueName -Value $desiredValue -PropertyType DWord -Force | Out-Null
    Write-Output "$valueName set to $desiredValue — Enhanced Anti-Spoofing is now enabled."
} else {
    Write-Output "$valueName is already correctly set to $desiredValue. No changes made."
}
