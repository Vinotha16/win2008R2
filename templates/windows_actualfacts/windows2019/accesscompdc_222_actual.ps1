#   2.2.2 (L1) - Ensure 'Access this computer from the network' is set to 'Administrators, Authenticated Users, ENTERPRISE DOMAIN CONTROLLERS' (DC only) (Scored)

secedit /export /cfg c:\secpol.cfg > $null
$unique = '*S-1-5-9,*S-1-5-11,*S-1-5-32-544'
$unique1 = '*S-1-5-11,*S-1-5-32-544,*S-1-5-9'
$output = (Get-content c:/secpol.cfg | select-string 'SeNetworkLogonRight').ToString().Split('=')[1].Trim()

if ($unique -eq $output) {
        write-output $output
} elseif ($unique1 -eq $output) {
        write-output $output
} else {
    $failed = (Get-content c:/secpol.cfg | select-string 'SeNetworkLogonRight').ToString().Split('=')[1].Trim().replace('*', '')
    write-output "failed $failed"
}
rm -force c:\secpol.cfg -confirm:$false

