$ErrorActionPreference = "stop"
Try {
 Get-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services' -Name version
}
Catch [System.Management.Automation.PSArgumentException]
{
#  	18.8.36.2 (L1) - Ensure 'Configure Solicited Remote Assistance' is set to 'Disabled' (Scored)

	$path = (Test-Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services")
	$unique = (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" 2> $null | select-string 'fAllowToGetHelp' 2> $null |  Measure-Object | %{$_.Count})
	if (( $path -eq 'True' ) -And ( $unique -eq '1' )) {
		foreach ( $unique1 in (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" | select-string 'fAllowToGetHelp').ToString().Split('')[12].Trim() ) {
			if ( [int]$unique1 -eq [int]'0x0' ) {
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
