#  	18.9.97.1.1 (L1) - Ensure 'Allow Basic authentication' is set to 'Disabled' 

$ErrorActionPreference = "stop"
Try {
 Get-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WinRM\Client' -Name version
}
Catch [System.Management.Automation.PSArgumentException]
{

$path = (Test-Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WinRM\Client")
$unique = (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WinRM\Client" 2> $null | select-string 'AllowBasic' 2> $null |  Measure-Object | %{$_.Count})

if (( $path -eq 'True' ) -And ( $unique -eq '1' )) {
	foreach ( $unique1 in (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WinRM\Client" | select-string 'AllowBasic').ToString().Split('')[12].Trim() ) {
	if ( [int]$unique1 -eq [int]'0x0' ) {
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