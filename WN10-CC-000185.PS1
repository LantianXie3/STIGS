<#
.SYNOPSIS
    Allowing autorun commands to execute may introduce malicious code to a system. Configuring this setting prevents autorun commands from executing.

.NOTES
    Author          : Lantian Xie
    LinkedIn        : https://www.linkedin.com/in/lantian-xie/
    GitHub          : https://github.com/LantianXie3
    Date Created    : 2025-07-30
    Last Modified   : 2025-07-30
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AU-000500

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\Remediate-WN10-AU-000500.ps1
#>

# Define registry path and value details
$regPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer"
$valueName = "NoAutorun"
$desiredValue = 1

# Create the registry key if it doesn't exist
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force
}

# Check current value
$currentValue = Get-ItemProperty -Path $regPath -Name $valueName -ErrorAction SilentlyContinue

if ($null -eq $currentValue -or $currentValue.$valueName -ne $desiredValue) {
    # Set the value if it doesn't exist or is not configured correctly
    New-ItemProperty -Path $regPath -Name $valueName -Value $desiredValue -PropertyType DWord -Force
    Write-Output "NoAutorun was missing or incorrect. Value set to $desiredValue."
} else {
    Write-Output "NoAutorun is already set correctly to $desiredValue."
}
