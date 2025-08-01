<#
.SYNOPSIS
    Enables PowerShell Script Block Logging for enhanced audit and threat detection.

.DESCRIPTION
    This script ensures that the 'EnableScriptBlockLogging' value is set to 1, which allows the system to log full PowerShell script blocks to the event log. 
    This is a recommended security configuration for monitoring and forensic purposes.

.NOTES
    Author          : Lantian Xie  
    LinkedIn        : https://www.linkedin.com/in/lantian-xie/  
    GitHub          : https://github.com/LantianXie3  
    Date Created    : 2025-07-31  
    Last Modified   : 2025-07-31  
    Version         : 1.0  
    STIG ID         : WN10-CC-000215  

.TESTED ON
    Date(s) Tested  : 2025-07-31  
    Systems Tested  : Windows 10 and Windows Server 2016+  
    PowerShell Ver. : 5.1, 7.x  

.USAGE
    PS C:\> .\Enable-ScriptBlockLogging.ps1
#>

# Registry configuration
$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging"
$valueName = "EnableScriptBlockLogging"
$desiredValue = 1

# Ensure the registry path exists
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Get current value if it exists
$currentValue = Get-ItemProperty -Path $regPath -Name $valueName -ErrorAction SilentlyContinue

# Set or correct the value
if ($null -eq $currentValue -or $currentValue.$valueName -ne $desiredValue) {
    New-ItemProperty -Path $regPath -Name $valueName -Value $desiredValue -PropertyType DWord -Force | Out-Null
    Write-Output "$valueName was set to $desiredValue to enable Script Block Logging."
} else {
    Write-Output "$valueName is already set to $desiredValue. No changes needed."
}
