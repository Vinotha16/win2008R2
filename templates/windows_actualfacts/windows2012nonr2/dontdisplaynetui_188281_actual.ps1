#  	18.8.28.1 (L1) - Ensure 'Do not display network selection UI' is set to 'Enabled' 

$ErrorActionPreference = "stop"
Try {
Get-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\System' -Name version
}
Catch [System.Management.Automation.PSArgumentException]
{
	$path = (Test-Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System")
	$unique = (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System" 2> $null | select-string 'DontDisplayNetworkSelectionUI' 2> $null |  Measure-Object | %{$_.Count})
	if (( $path -eq 'True' ) -And ( $unique -eq '1' )) {
		foreach ( $unique1 in (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System" | select-string 'DontDisplayNetworkSelectionUI').ToString().Split('')[12].Trim() ) {
			if ( [int]$unique1 -eq [int]'0x1' ) {
				Write-Output $unique1
			} else {
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
