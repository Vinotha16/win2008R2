# 17.3.1 (L1) Ensure 'Audit Process Creation' is set to include 'Success' (Scored)

$unique =  auditpol.exe /get /category:*   | select-string "Process Creation" |  Foreach {"$(($_ -split '\s+',4)[3])"}
$output = "Success"

if ([string]$unique -ne [string]$output) {
	write-output "FAILED"
} else {
	write-output "PASSED"
}
