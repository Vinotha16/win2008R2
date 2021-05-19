# 17.5.2 - (L1) Ensure 'Audit Group Membership' is set to include 'Success'
$failed = (auditpol /get /category:*   | select-string "Group Membership"  | Foreach {"$(($_ -split '\s+'))"} | ForEach-Object {$_.replace('Group Membership', '').replace('No Auditing', 'none').replace('Success and Failure', 'success, failure')} )
$unique = auditpol.exe /get /category:*   | select-string "Group Membership" |  Foreach {"$(($_ -split '\s+',4)[3])"}
$output = "Success"
if ([string]$unique -ne [string]$output) {
		write-output "failed $failed"
	} else {
		write-output $unique
	}