#   2.2.32 (L1) - Ensure 'Impersonate a client after authentication' is set to 'Administrators, LOCAL SERVICE, NETWORK SERVICE, SERVICE' and (when the Web Server (IIS) Role with Web Services Role Service is installed) 'IIS_IUSRS' (MS only) (Scored)
secedit /export /cfg c:\secpol.cfg > $null
$unique = '*S-1-5-19,*S-1-5-20,*S-1-5-32-544,*S-1-5-6'
$output = (Get-content c:\secpol.cfg | select-string 'SeImpersonatePrivilege').ToString().Split('=')[1].Trim()
$failed = (Get-content c:\secpol.cfg | select-string 'SeImpersonatePrivilege').ToString().Split('=')[1].Trim().replace('*', '')
if ($unique -ne $output) {
   write-output "failed $failed"
} else {
        write-output $output
}
rm -force c:\secpol.cfg -confirm:$false