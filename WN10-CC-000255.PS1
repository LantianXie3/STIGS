<#
.SYNOPSIS
    Enforces the use of a TPM for Windows Hello for Business key storage.

.DESCRIPTION
    This script ensures that the 'RequireSecurityDevice' registry value is set to 1 under PassportForWork policy,
    requiring that cryptographic keys be stored in a hardware-based Trusted Platform Module (TPM) where available.

.NOTES
    Author          : Lantian Xie  
    LinkedIn        : https://www.linkedin.com/in/lantian-xie/  
    GitHub          : https://github.com/LantianXie3  
    Date Created    : 2025-07-31  
    Last Modified   : 2025-07-31  
    Version         : 1.0  
    STIG ID         : WN10-CC-000305  

.TESTED ON
    Date(s) Tested  : 2025-07-31  
    Systems Tested  : Windows 10, Windows 11, Windows Server 2019+  
    PowerShell Ver. : 5.1, 7.x  

.USAGE
    PS C:\> .\Enable-TPMRequirement.ps1
#>

# Registry configuration
$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\PassportForWork"
$valueName = "RequireSecurityDevice"
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
    Write-Output "$valueName was set to $desiredValue to enforce TPM-backed Hello for Business keys."
} else {
    Write-Output "$valueName is already correctly set to $desiredValue. No changes needed."
}
