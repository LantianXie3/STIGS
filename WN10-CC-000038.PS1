<#
.SYNOPSIS
    Disables WDigest credential caching to comply with Windows 10 STIG requirements.

.DESCRIPTION
    Ensures the registry value 'UseLogonCredential' under 
    HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\Wdigest\ 
    is set to 0, which prevents storing plaintext credentials in memory.

.NOTES
    Author          : Lantian Xie  
    LinkedIn        : https://www.linkedin.com/in/lantian-xie/  
    GitHub          : https://github.com/LantianXie3  
    Date Created    : 2025-07-31  
    Last Modified   : 2025-07-31  
    Version         : 1.0  
    STIG ID         : WN10-SO-000120  

.TESTED ON
    Date(s) Tested  : 2025-07-31  
    Systems Tested  : Windows 10 Enterprise LTSC 2019 / Pro 22H2  
    PowerShell Ver. : 5.1, 7.x  

.USAGE
    PS C:\> .\Remediate-WDigestCredentialCaching.ps1
#>

# Define the registry path and expected value
$regPath = "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\Wdigest"
$valueName = "UseLogonCredential"
$desiredValue = 0

# Ensure the registry key exists
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Get the current value
$currentValue = Get-ItemProperty -Path $regPath -Name $valueName -ErrorAction SilentlyContinue

# Set or correct the value
if ($null -eq $currentValue -or $currentValue.$valueName -ne $desiredValue) {
    New-ItemProperty -Path $regPath -Name $valueName -Value $desiredValue -PropertyType DWord -Force | Out-Null
    Write-Output "WDigest credential caching has been disabled. [$valueName set to $desiredValue]"
} else {
    Write-Output "WDigest credential caching already disabled. [$valueName is $desiredValue]"
}
