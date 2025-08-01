<#
.SYNOPSIS
    Configures Kernel DMA Protection to prevent unauthorized Direct Memory Access (DMA) via Thunderbolt 3 ports.

.DESCRIPTION
    This script sets the 'DeviceEnumerationPolicy' registry value to 0 to enforce Kernel DMA Protection, 
    reducing the risk of DMA-based attacks such as bypassing the lock screen or injecting malware.

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
    Systems Tested  : Windows 10 v1803 and later  
    PowerShell Ver. : 5.1, 7.x  

.USAGE
    PS C:\> .\Remediate-KernelDMAPolicy.ps1
#>

# Registry configuration
$regPath = "HKLM:\Software\Policies\Microsoft\Windows\Kernel DMA Protection"
$valueName = "DeviceEnumerationPolicy"
$desiredValue = 0

# Ensure the registry path exists
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Get current value if it exists
$currentValue = Get-ItemProperty -Path $regPath -Name $valueName -ErrorAction SilentlyContinue

# Set or correct the value
if ($null -eq $currentValue -or $currentValue.$valueName -ne $desiredValue) {
    New-ItemProperty -Path $regPath -Name $valueName -Value $desiredValue -PropertyType DWord -Force | Out-Null
    Write-Output "$valueName was set to $desiredValue to enforce Kernel DMA Protection."
} else {
    Write-Output "$valueName is already set to $desiredValue. No changes needed."
}
