<#
.SYNOPSIS
    Enables FIPS-compliant algorithms for encryption, hashing, and signing.

.DESCRIPTION
    This script sets the 'Enabled' value under the FIPSAlgorithmPolicy registry key to 1, 
    which enforces the use of FIPS 140-2 approved algorithms for cryptographic operations.

.NOTES
    Author          : Lantian Xie  
    LinkedIn        : https://www.linkedin.com/in/lantian-xie/  
    GitHub          : https://github.com/LantianXie3  
    Date Created    : 2025-07-31  
    Last Modified   : 2025-07-31  
    Version         : 1.0  
    STIG ID         : WN10-CC-000030  

.WARNING
    Enabling FIPS mode may cause compatibility issues with software or services that 
    use non-FIPS-compliant cryptographic algorithms. Ensure all systems communicating 
    with this machine support TLS and FIPS-approved algorithms.

.TESTED ON
    Date(s) Tested  : 2025-07-31  
    Systems Tested  : Windows 10 Enterprise LTSC 2019 / Pro 22H2  
    PowerShell Ver. : 5.1, 7.x  

.USAGE
    PS C:\> .\Remediate-FIPSAlgorithmPolicy.ps1
#>

# Define the registry path and target value
$regPath = "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa\FIPSAlgorithmPolicy"
$valueName = "Enabled"
$desiredValue = 1

# Create the registry key if it doesn't exist
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Get the current value
$currentValue = Get-ItemProperty -Path $regPath -Name $valueName -ErrorAction SilentlyContinue

# Apply the correct value if needed
if ($null -eq $currentValue -or $currentValue.$valueName -ne $desiredValue) {
    New-ItemProperty -Path $regPath -Name $valueName -Value $desiredValue -PropertyType DWord -Force | Out-Null
    Write-Output "FIPS mode has been enabled. [$valueName set to $desiredValue]"
} else {
    Write-Output "FIPS mode is already enabled. [$valueName is $desiredValue]"
}
