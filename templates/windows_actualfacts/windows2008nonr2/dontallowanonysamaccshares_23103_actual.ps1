#   2.3.10.3 (L1) Ensure 'Network access: Do not allow anonymous enumeration of SAM accounts and shares' is set to 'Enabled' (MS only) (Scored)

secedit /export /cfg c:\secpol.cfg  > $null
$unique = '4,1'
$output = (Get-content c:\secpol.cfg | Select-String 'RestrictAnonymous=').ToString().Split('=')[1].Trim()

if ($unique -ne $output) {
	write-output "failed $output"
} else {
	write-output $output
}
rm -force c:\secpol.cfg -confirm:$false

