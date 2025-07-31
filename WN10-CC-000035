<#
.SYNOPSIS
    This PowerShell script ensures that the maximum size of the Windows Application event log is at least 32768 KB (32 MB).

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
$regPath = "HKLM:\SYSTEM\CurrentControlSet\Services\Netbt\Parameters"

# Create the registry key if it doesn't exist
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force
}

# Set the NoNameReleaseOnDemand DWORD value to 1
New-ItemProperty -Path $regPath -Name "NoNameReleaseOnDemand" -Value 1 -PropertyType DWord -Force
