<#
.SYNOPSIS
    Disables the use of domain PIN logon by setting AllowDomainPINLogon to 0.

.DESCRIPTION
    Domain PIN logon allows users to authenticate using a PIN in a domain environment.
    This setting disables that option to reduce potential attack vectors.

.NOTES
    Author          : Lantian Xie  
    LinkedIn        : https://www.linkedin.com/in/lantian-xie/  
    GitHub          : https://github.com/LantianXie3  
    Date Created    : 2025-07-31  
    Last Modified   : 2025-07-31  
    Version         : 1.0  
    CVEs            : N/A  
    Plugin IDs      : N/A  
    STIG-ID         : WN10-CC-000450

.TESTED ON
    Date(s) Tested  : 2025-07-31  
    Tested By       : Lantian Xie  
    Systems Tested  : Windows 10 Pro 22H2 (x64)  
    PowerShell Ver. : 5.1, 7.4

.USAGE
    Run this script with elevated privileges (as Administrator).

    Example:
    PS C:\> .\Remediate-WN10-CC-000450.ps1
#>

# Define registry path and expected value
$regPath = "HKLM:\Software\Policies\Microsoft\Windows\System"
$valueName = "AllowDomainPINLogon"
$desiredValue = 0

# Create registry path if missing
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Get current registry value
$currentValue = Get-ItemProperty -Path $regPath -Name $valueName -ErrorAction SilentlyContinue

# Remediate if value is missing or incorrect
if ($null -eq $currentValue -or $currentValue.$valueName -ne $desiredValue) {
    New-ItemProperty -Path $regPath -Name $valueName -Value $desiredValue -PropertyType DWord -Force | Out-Null
    Write-Output "$valueName was missing or misconfigured. Value set to $desiredValue."
} else {
    Write-Output "$valueName is already correctly set to $desiredValue."
}
