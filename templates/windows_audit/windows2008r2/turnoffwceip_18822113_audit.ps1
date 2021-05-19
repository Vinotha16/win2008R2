$ErrorActionPreference = "stop"
Try {
 Get-ItemProperty -Path HKLM:\SOFTWARE\Policies\Microsoft\SQMClient\Windows -Name version
}
Catch [System.Management.Automation.PSArgumentException]
{


#  	18.8.22.1.13 (L2) - Ensure 'Turn off Windows Customer Experience Improvement Program' is set to 'Enabled' (Scored)

	$path = (Test-Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\SQMClient\Windows")
	$unique = (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\SQMClient\Windows" 2> $null | select-string 'CEIPEnable' 2> $null |  Measure-Object | %{$_.Count})
	if (( $path -eq 'True' ) -And ( $unique -eq '1' )) {
		foreach ( $unique1 in (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\SQMClient\Windows" | select-string 'CEIPEnable').ToString().Split('')[12].Trim() ) {
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
