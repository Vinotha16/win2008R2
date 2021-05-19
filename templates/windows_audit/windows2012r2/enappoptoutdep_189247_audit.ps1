#   18.9.24.7 (L1) Ensure 'System DEP' is set to 'Enabled: Application OptOut' (Scored)


$ErrorActionPreference = "stop"
Try {
 Get-ItemProperty -Path HKLM:\SOFTWARE\Policies\Microsoft\EMET\SysSettings -Name version
}
Catch [System.Management.Automation.PSArgumentException]
{

	$path = (Test-Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\EMET\SysSettings")
	$unique = (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\EMET\SysSettings" 2> $null | select-string 'DEP' 2> $null |  Measure-Object | %{$_.Count})
	if (( $path -eq 'True' ) -And ( $unique -eq '1' )) {
		foreach ( $unique1 in (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\EMET\SysSettings" | select-string 'DEP').ToString().Split('')[12].Trim() ) {
			if ( [int]$unique1 -eq [int]'0x2' ) {
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