<#
.SYNOPSIS
   Authentication must always be required when accessing a system. This setting ensures the user is prompted for a password on resume from sleep (on battery).

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
    PS C:\> .\__remediation_template(STIG-ID-WN10-AU-000500).ps1 
#>

# Define the registry path
$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Power\PowerSettings\0e796bdb-100d-47d6-a2d5-f7d2daa51f51"

# Create the registry key if it doesn't exist
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force
}

# Set the DCSettingIndex DWORD value to 1
New-ItemProperty -Path $regPath -Name "DCSettingIndex" -Value 1 -PropertyType DWord -Force
