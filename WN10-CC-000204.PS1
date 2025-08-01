<#
.SYNOPSIS
    Configures telemetry settings to limit enhanced diagnostic data for Windows Analytics.

.DESCRIPTION
    This script sets the registry key 'LimitEnhancedDiagnosticDataWindowsAnalytics' to 1
    to restrict the amount of enhanced diagnostic data sent, when telemetry is set to 'Enhanced'.

.NOTES
    Author          : Lantian Xie  
    LinkedIn        : https://www.linkedin.com/in/lantian-xie/  
    GitHub          : https://github.com/LantianXie3  
    Date Created    : 2025-07-31  
    Last Modified   : 2025-07-31  
    Version         : 1.0  
    STIG ID         : WN10-CC-000323  

.TESTED ON
    Date(s) Tested  : 2025-07-31  
    Systems Tested  : Windows 10 v1709+, Windows 11  
    PowerShell Ver. : 5.1, 7.x  

.USAGE
    PS C:\> .\Set-LimitEnhancedTelemetry.ps1
#>

# CONFIGURATION
$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection"
$valueName = "LimitEnhancedDiagnosticDataWindowsAnalytics"
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
    Write-Output "$valueName set to $desiredValue — Enhanced diagnostic data is now limited for Windows Analytics."
} else {
    Write-Output "$valueName is already correctly set to $desiredValue. No changes made."
}
