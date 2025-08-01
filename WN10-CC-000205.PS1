<#
.SYNOPSIS
    Configures Windows telemetry settings for compliance.

.DESCRIPTION
    Sets the 'AllowTelemetry' value in the registry to either:
    - 0 (Security)
    - 1 (Basic)
    - 2 (Enhanced) [if Windows Analytics is in use and V-220833 is addressed]

.NOTES
    Author          : Lantian Xie  
    LinkedIn        : https://www.linkedin.com/in/lantian-xie/  
    GitHub          : https://github.com/LantianXie3  
    Date Created    : 2025-07-31  
    Last Modified   : 2025-07-31  
    Version         : 1.0  
    STIG ID         : WN10-CC-000315  

.TESTED ON
    Date(s) Tested  : 2025-07-31  
    Systems Tested  : Windows 10 v1709+, Windows 11  
    PowerShell Ver. : 5.1, 7.x  

.USAGE
    PS C:\> .\Set-AllowTelemetry.ps1
#>

# CONFIGURATION
$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection"
$valueName = "AllowTelemetry"

# Choose the desired telemetry level
# 0 = Security (Enterprise & Education only), 1 = Basic, 2 = Enhanced (only if justified)
$desiredValue = 1  # Change to 0 or 2 based on organizational policy

# Ensure the registry path exists
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Get current value if present
$currentValue = Get-ItemProperty -Path $regPath -Name $valueName -ErrorAction SilentlyContinue

# Set or update the value
if ($null -eq $currentValue -or $currentValue.$valueName -ne $desiredValue) {
    New-ItemProperty -Path $regPath -Name $valueName -Value $desiredValue -PropertyType DWord -Force | Out-Null
    Write-Output "$valueName was set to $desiredValue (Telemetry level)."
} else {
    Write-Output "$valueName is already set correctly to $desiredValue. No action needed."
}
