#   2.3.10.12 (L1) Ensure 'Network access: Sharing and security model for local accounts' is set to 'Classic - local users authenticate as themselves' (Scored)
$ErrorActionPreference = "stop"
Try {
 Get-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Lsa' -Name version
}
Catch [System.Management.Automation.PSArgumentException]
{
secedit /export /cfg c:\secpol.cfg > $null
$unique = '4,0'
$output = (Get-content c:\secpol.cfg | Select-String 'ForceGuest').ToString().Split('=')[1].Trim()

if ($unique -ne $output) {
	write-output "failed $output"
} else {
	write-output $output
}
rm -force c:\secpol.cfg -confirm:$false
}
Catch [System.Management.Automation.ItemNotFoundException]
{
 Write-Output ""
 }
Finally { $ErrorActionPreference = "Continue" }
