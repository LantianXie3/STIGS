<#
.SYNOPSIS
    Enables PowerShell Transcription logging by setting EnableTranscripting to 1.

.DESCRIPTION
    PowerShell transcription captures detailed logs of command and script execution,
    which is essential for analyzing compromises, troubleshooting, and detecting
    suspicious activity. This setting helps ensure an auditable trail exists when
    PowerShell is used, including by attackers or malware.

.NOTES
    Author          : Lantian Xie
    LinkedIn        : https://www.linkedin.com/in/lantian-xie/
    GitHub          : https://github.com/LantianXie3
    Date Created    : 2025-07-31
    Last Modified   : 2025-07-31
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000310

.TESTED ON
    Date(s) Tested  : 2025-07-31
    Tested By       : Lantian Xie
    Systems Tested  : Windows 10 Pro 22H2 (x64)
    PowerShell Ver. : 5.1, 7.4

.USAGE
    Run this script with elevated privileges (as Administrator).

    Example:
    PS C:\> .\Remediate-WN10-CC-000310.ps1
#>

# Define registry path and desired value
$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell\Transcription"
$valueName = "EnableTranscripting"
$desiredValue = 1

# Create the registry key if it does not exist
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Get the current value if it exists
$currentValue = Get-ItemProperty -Path $regPath -Name $valueName -ErrorAction SilentlyContinue

# Remediate if the value is missing or incorrect
if ($null -eq $currentValue -or $currentValue.$valueName -ne $desiredValue) {
    New-ItemProperty -Path $regPath -Name $valueName -Value $desiredValue -PropertyType DWord -Force | Out-Null
    Write-Output "$valueName was missing or misconfigured. Value set to $desiredValue."
} else {
    Write-Output "$valueName is already correctly set to $desiredValue."
}
