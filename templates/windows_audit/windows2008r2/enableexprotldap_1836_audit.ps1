
#   18.3.6 (L1) Ensure 'Extended Protection for LDAP Authentication (Domain Controllers only)' is set to 'Enabled: Enabled, always (recommended)' (DC Only)


$ErrorActionPreference = "stop"
Try {
 Get-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\NTDS\Parameters' -Name version
}
Catch [System.Management.Automation.PSArgumentException]
{
	$path = (Test-Path "Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NTDS\Parameters")
	$unique = (REG QUERY "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NTDS\Parameters" 2> $null | select-string 'LdapEnforceChannelBinding' 2> $null |  Measure-Object | %{$_.Count})
	if (( $path -eq 'True' ) -And ( $unique -eq '1' )) {
		foreach ( $unique1 in (REG QUERY "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NTDS\Parameters" | select-string 'LdapEnforceChannelBinding').ToString().Split('')[12].Trim() ) {
			if ( [int]$unique1 -eq [int]'0x1' ) {
				Write-Output "PASSED"
			} else {
   Write-Output "FAILED"
				}
							}
	}else {
   Write-Output "FAILED"
	}
  }
Catch [System.Management.Automation.ItemNotFoundException]
{
   Write-Output "FAILED"
 }
Finally { $ErrorActionPreference = "Continue" }


