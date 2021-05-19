$ErrorActionPreference = "stop"
Try {
 Get-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Services\AdmPwd' -Name version
}
Catch [System.Management.Automation.PSArgumentException]
{

#   18.2.2 (L1) - Ensure 'Do not allow password expiration time longer than required by policy' is set to 'Enabled' (MS only) (Scored)

$path = (Test-Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Services\AdmPwd")
$unique = (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Services\AdmPwd" 2> $null | select-string 'PwdExpirationProtectionEnabled' 2> $null |  Measure-Object | %{$_.Count})

if (( $path -eq 'True' ) -And ( $unique -eq '1' )) {
	foreach ( $unique1 in (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Services\AdmPwd" | select-string 'PwdExpirationProtectionEnabled').ToString().Split('')[12].Trim() ) {
	if ( [int]$unique1 -eq [int]'0x1' ) {
		Write-Output $unique1
		} else {
		Write-Output "DELETE"
		}
	}
}else {
	Write-Output "DELETE"
}

}

Catch [System.Management.Automation.ItemNotFoundException]
{
 
  Write-Output "DELETE"
 }
Finally { $ErrorActionPreference = "Continue" }
