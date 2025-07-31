<#
.SYNOPSIS
    Disables HTTP printing to comply with STIG requirements.

.DESCRIPTION
    Sets the registry value 'DisableHTTPPrinting' to 1 under 
    HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Printers\, 
    which disables HTTP-based printing to reduce attack surface.

.NOTES
    Author          : Lantian Xie  
    LinkedIn        : https://www.linkedin.com/in/lantian-xie/  
    GitHub          : https://github.com/LantianXie3  
    Date Created    : 2025-07-31  
    Last Modified   : 2025-07-31  
    Version         : 1.0  
    STIG ID         : WN10-PR-000005  

.TESTED ON
    Date(s) Tested  : 2025-07-31  
    Systems Tested  : Windows 10 Enterprise LTSC 2019 / Pro 22H2  
    PowerShell Ver. : 5.1, 7.x  

.USAGE
    PS C:\> .\Remediate-DisableHTTPPrinting.ps1
#>

# Define the registry path and required value
$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Printers"
$valueName = "DisableHTTPPrinting"
$desiredValue = 1

# Ensure the registry path exists
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Check current value
$currentValue = Get-ItemProperty -Path $regPath -Name $valueName -ErrorAction SilentlyContinue

# Set the value if missing or incorrect
if ($null -eq $currentValue -or $currentValue.$valueName -ne $desiredValue) {
    New-ItemProperty -Path $regPath -Name $valueName -Value $desiredValue -PropertyType DWord -Force | Out-Null
    Write-Output "HTTP Printing has been disabled. [$valueName set to $desiredValue]"
} else {
    Write-Output "HTTP Printing is already disabled. [$valueName is $desiredValue]"
}
