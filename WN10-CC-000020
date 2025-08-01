<#
.SYNOPSIS
    Disables IPv6 source routing to protect against spoofing attacks.

.DESCRIPTION
    Sets the 'DisableIpSourceRouting' registry value under Tcpip6\Parameters to 2,
    which disables all IPv6 source routing to enhance security.

.NOTES
    Author          : Lantian Xie  
    LinkedIn        : https://www.linkedin.com/in/lantian-xie/  
    GitHub          : https://github.com/LantianXie3  
    Date Created    : 2025-07-31  
    Last Modified   : 2025-07-31  
    Version         : 1.0  
    STIG ID         : WN10-CC-000105  

.TESTED ON
    Date(s) Tested  : 2025-07-31  
    Systems Tested  : Windows 10, Windows 11, Windows Server 2019+  
    PowerShell Ver. : 5.1, 7.x  

.USAGE
    PS C:\> .\Disable-IPv6SourceRouting.ps1
#>

# Registry configuration
$regPath = "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters"
$valueName = "DisableIpSourceRouting"
$desiredValue = 2

# Ensure the registry path exists
if (-not (Test-Path $regPath)) {
    Write-Warning "The registry path does not exist: $regPath"
    return
}

# Get current value if it exists
$currentValue = Get-ItemProperty -Path $regPath -Name $valueName -ErrorAction SilentlyContinue

# Set or correct the value
if ($null -eq $currentValue -or $currentValue.$valueName -ne $desiredValue) {
    New-ItemProperty -Path $regPath -Name $valueName -Value $desiredValue -PropertyType DWord -Force | Out-Null
    Write-Output "$valueName was set to $desiredValue to disable IPv6 source routing."
} else {
    Write-Output "$valueName is already correctly set to $desiredValue. No changes needed."
}
