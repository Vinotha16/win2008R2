#   2.3.1.3 (L1) - Ensure 'Accounts: Guest account status' is set to 'Disabled' (MS only) (Scored)
$sid= (Get-WmiObject win32_useraccount | ForEach-Object {$_.SID}) -match "$(-501 )"
$accname = [wmi]"Win32_SID.SID='$sid'" | Select-Object AccountName | where-object -filter {$_.AccountName} | Foreach {$_.AccountName}
$output = 'No'
$unique=(invoke-expression "net user $accname" | select-string 'Account active').ToString().Split(' ')[16].Trim()
if ($output -ne $unique) {
        $unique = $unique -replace 'Yes','1'
        Write-Output "failed $unique"
} else {
        Write-Output $unique
}
