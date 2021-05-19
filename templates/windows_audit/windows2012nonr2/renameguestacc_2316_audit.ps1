#   2.3.1.6 (L1) - Configure 'Accounts: Rename guest account' (Scored)

secedit /export /cfg c:\secpol.cfg > $null
$output = '"Guest"'
$unique = (Get-content c:\secpol.cfg | select-string 'NewGuestName').ToString().Split('=')[1].Trim()
if ($output -ne $unique) {
	Write-Output "FAILED"
} else {
	Write-Output "PASSED"
}
rm -force c:\secpol.cfg -confirm:$false 
