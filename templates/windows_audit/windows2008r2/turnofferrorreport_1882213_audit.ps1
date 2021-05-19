#  	18.8.22.1.3 (L2) - Ensure 'Turn off handwriting recognition error reporting' is set to 'Enabled'
$ErrorActionPreference = "stop"
Try {
 Get-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\HandwritingErrorReports' -Name version
}
Catch [System.Management.Automation.PSArgumentException]
{
$path = (Test-Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\HandwritingErrorReports")
$unique = (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\HandwritingErrorReports" 2> $null | select-string 'PreventHandwritingErrorReports' 2> $null |  Measure-Object | %{$_.Count})

if (( $path -eq 'True' ) -And ( $unique -eq '1' )) {
	foreach ( $unique1 in (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\HandwritingErrorReports" | select-string 'PreventHandwritingErrorReports').ToString().Split('')[12].Trim() ) {
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


