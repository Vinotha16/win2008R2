#   2.3.10.9 (L1) - Configure 'Network access: Remotely accessible registry paths and sub-paths' (Scored)

secedit /export /cfg c:\secpol.cfg > $null
$unique = '7,System\CurrentControlSet\Control\Print\Printers,System\CurrentControlSet\Services\Eventlog,Software\Microsoft\OLAP Server,Software\Microsoft\Windows NT\CurrentVersion\Print,Software\Microsoft\Windows NT\CurrentVersion\WindowsSystem\CurrentControlSet\Control\ContentIndex,System\CurrentControlSet\Control\Terminal Server,System\CurrentControlSet\Control\Terminal Server\UserConfig,System\CurrentControlSet\Control\Terminal Server\DefaultUserConfiguration,Software\Microsoft\Windows NT\CurrentVersion\Perflib,System\CurrentControlSet\Services\SysmonLog,System\CurrentControlSet\Services\WINS'
$output = (Get-content c:\secpol.cfg | Select-String 'AllowedPaths.*Machine').ToString().Split('=')[1].Trim()

if ($unique -ne $output) {
	write-output "failed $output"
} else {
	write-output "$output"
}
rm -force c:\secpol.cfg -confirm:$false
