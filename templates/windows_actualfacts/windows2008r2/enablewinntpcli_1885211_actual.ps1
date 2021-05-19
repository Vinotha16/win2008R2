$ErrorActionPreference = "stop"
Try {
 Get-ItemProperty -Path HKLM:\SOFTWARE\Policies\Microsoft\W32Time\TimeProviders\NtpClient -Name version
}
Catch [System.Management.Automation.PSArgumentException]
{


#  	18.8.49.1.1 (L2) - Ensure 'Enable Windows NTP Client' is set to 'Enabled' (Scored)

	$path = (Test-Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\W32Time\TimeProviders\NtpClient")
	$unique = (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\W32Time\TimeProviders\NtpClient" 2> $null | select-string 'Enabled' 2> $null |  Measure-Object | %{$_.Count})
	if (( $path -eq 'True' ) -And ( $unique -eq '1' )) {
		foreach ( $unique1 in (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\W32Time\TimeProviders\NtpClient" | select-string 'Enabled').ToString().Split('')[12].Trim() ) {
			if ( [int]$unique1 -eq [int]'0x1' ) {
				Write-Output $unique1
			} else {
				$unique1 = $unique1 -replace '0x',''
		Write-Output $unique1
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
