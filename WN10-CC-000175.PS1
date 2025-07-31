<#
.SYNOPSIS
    Disables the Program Inventory feature by setting DisableInventory to 1.

.DESCRIPTION
    Disabling Program Inventory prevents potentially sensitive system data from being collected and transmitted to Microsoft.
    This setting helps protect enterprise environments from unintended data disclosures or uncontrolled feature updates.

.NOTES
    Author          : Lantian Xie  
    LinkedIn        : https://www.linkedin.com/in/lantian-xie/  
    GitHub          : https://github.com/LantianXie3  
    Date Created    : 2025-07-31  
    Last Modified   : 2025-07-31  
    Version         : 1.0  
    CVEs            : N/A  
    Plugin IDs      : N/A  
    STIG-ID         : WN10-CC-000185  

.TESTED ON
    Date(s) Tested  : 2025-07-31  
    Tested By       : Lantian Xie  
    Systems Tested  : Windows 10 Pro 22H2 (x64)  
    PowerShell Ver. : 5.1, 7.4  

.USAGE
    PS C:\> .\Remediate-WN10-CC-000185.ps1
#>

# Define registry path and expected value
$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppCompat"
$valueName = "DisableInventory"
$desiredValue = 1

# Create registry path if it does not exist
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Get current value (if exists)
$currentValue = Get-ItemProperty -Path $regPath -Name $valueName -ErrorAction SilentlyContinue

# Remediate if necessary
if ($null -eq $currentValue -or $currentValue.$valueName -ne $desiredValue) {
    New-ItemProperty -Path $regPath -Name $valueName -Value $desiredValue -PropertyType DWord -Force | Out-Null
    Write-Output "$valueName was missing or misconfigured. Value set to $desiredValue."
} else {
    Write-Output "$valueName is already correctly set to $desiredValue."
}
