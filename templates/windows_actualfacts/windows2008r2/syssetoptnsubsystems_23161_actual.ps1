#  2.3.16.1 (L1) Ensure 'System settings: Optional subsystems' is set to 'Defined: (blank)' (Scored)

$ErrorActionPreference = "stop"
Try {
Get-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\SubSystems' -Name version
}
Catch [System.Management.Automation.PSArgumentException]
{
$path = (Test-Path "Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\SubSystems")
$unique = (REG QUERY "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\SubSystems" | select-string 'Optional' 2> $null |  Measure-Object | %{$_.Count})

if (( $path -eq 'True' ) -And ( $unique -eq '1' )) {
   foreach ( $unique1 in (REG QUERY "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\SubSystems" | select-string 'Optional' 2> $null |  Measure-Object | %{$_.Count})) { 
	if ( $unique1 -eq 1 ) {
             Write-Output "$unique1"
	} else {
	     Write-Output ""
	}
	}
}else {
	Write-Output ""
}
}
Catch [System.Management.Automation.ItemNotFoundException]
{
Write-Output ""
}
Finally { $ErrorActionPreference = "Continue" }