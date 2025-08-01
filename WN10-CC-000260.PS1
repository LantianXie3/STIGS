<#
.SYNOPSIS
    Configures minimum PIN length for Windows Hello for Business.

.DESCRIPTION
    This script ensures that the MinimumPINLength registry value is set to 6 or greater.
    Longer PINs increase security by expanding the number of possible combinations.

.NOTES
    Author          : Lantian Xie  
    LinkedIn        : https://www.linkedin.com/in/lantian-xie/  
    GitHub          : https://github.com/LantianXie3  
    Date Created    : 2025-07-31  
    Last Modified   : 2025-07-31  
    Version         : 1.0  
    STIG ID         : WN10-CC-000445  

.TESTED ON
    Date(s) Tested  : 2025-07-31  
    Systems Tested  : Windows 10 Pro, Enterprise, LTSC  
    PowerShell Ver. : 5.1, 7.x  

.USAGE
    PS C:\> .\Remediate-MinimumPINLength.ps1
#>

# Registry configuration
$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\PassportForWork\PINComplexity"
$valueName = "MinimumPINLength"
$minimumValue = 6

# Ensure the registry path exists
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Get current value if it exists
$currentValue = Get-ItemProperty -Path $regPath -Name $valueName -ErrorAction SilentlyContinue

# Set or correct the value
if ($null -eq $currentValue -or $currentValue.$valueName -lt $minimumValue) {
    New-ItemProperty -Path $regPath -Name $valueName -Value $minimumValue -PropertyType DWord -Force | Out-Null
    Write-Output "$valueName was missing or too low. Set to $minimumValue."
} else {
    Write-Output "$valueName is already $($currentValue.$valueName), which meets or exceeds the requirement."
}
