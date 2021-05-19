$ErrorActionPreference = "stop"
Try {
 Get-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\GPExtensions\{D76B9641-3288-4f75-942D087DE603E3EA}' -Name version
}
Catch [System.Management.Automation.PSArgumentException]
{

#   18.2.1 (L1) - Ensure LAPS AdmPwd GPO Extension / CSE is installed (MS only) 

$path = (Test-Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\GPExtensions\{D76B9641-3288-4f75-942D087DE603E3EA}")
$unique = (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\GPExtensions\{D76B9641-3288-4f75-942D087DE603E3EA}" 2> $null | select-string 'DllName' 2> $null |  Measure-Object | %{$_.Count})

if (( $path -eq 'True' ) -And ( $unique -eq '1' )) {
	Write-Output $unique
}else {
	Write-Output "1q2"
}

}

Catch [System.Management.Automation.ItemNotFoundException]
{
 
  Write-Output "222"
 }
Finally { $ErrorActionPreference = "Continue" }
