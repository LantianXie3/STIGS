<#
.SYNOPSIS
    Configures the system to allow local account logon by setting MSAOptional to 1.

.DESCRIPTION
    The MSAOptional setting allows users to log on with local accounts even when a Microsoft Account (MSA) is configured.
    This setting is not applicable to Windows 10 LTSC/B versions where Microsoft Store and modern apps are unsupported.

.NOTES
    Author          : Lantian Xie  
    LinkedIn        : https://www.linkedin.com/in/lantian-xie/  
    GitHub          : https://github.com/LantianXie3  
    Date Created    : 2025-07-31  
    Last Modified   : 2025-07-31  
    Version         : 1.0  
    STIG ID         : WN10-CC-000455  

.TESTED ON
    Date(s) Tested  : 2025-07-31  
    Systems Tested  : Windows 10 Pro 22H2, Enterprise, LTSC 2019  
    PowerShell Ver. : 5.1, 7.x  

.USAGE
    PS C:\> .\Remediate-MSAOptional.ps1
#>

# Determine OS edition and version to exclude LTSC/B variants
$edition = (Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion").EditionID
$release = (Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion").ReleaseId

if ($edition -like "*LTSC*" -or $edition -eq "EnterpriseS" -or $release -eq "1507" -or $release -eq "1607") {
    Write-Output "This setting is Not Applicable to Windows 10 LTSC/B (Edition: $edition, Version: $release). Skipping..."
    return
}

# Registry remediation
$regPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"
$valueName = "MSAOptional"
$desiredValue = 1

# Ensure registry key exists
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Get current value
$currentValue = Get-ItemProperty -Path $regPath -Name $valueName -ErrorAction SilentlyContinue

# Apply if missing or incorrect
if ($null -eq $currentValue -or $currentValue.$valueName -ne $desiredValue) {
    New-ItemProperty -Path $regPath -Name $valueName -Value $desiredValue -PropertyType DWord -Force | Out-Null
    Write-Output "$valueName was missing or incorrect. Set to $desiredValue."
} else {
    Write-Output "$valueName is already correctly set to $desiredValue."
}
