#  	18.9.95.2 (L1) - Ensure 'Turn on PowerShell Transcription' is set to 'Disabled'
$ErrorActionPreference = "stop"
Try {
 Get-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell\Transcription'  -Name version
}
Catch [System.Management.Automation.PSArgumentException]
{
$path = (Test-Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\PowerShell\Transcription")
$unique = (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\PowerShell\Transcription" 2> $null | select-string 'EnableTranscripting' 2> $null |  Measure-Object | %{$_.Count})

if (( $path -eq 'True' ) -And ( $unique -eq '1' )) {
	foreach ( $unique1 in (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\PowerShell\Transcription" | select-string 'EnableTranscripting').ToString().Split('')[12].Trim() ) {
	if ( [int]$unique1 -eq [int]'0x0' ) {
		Write-Output $unique1
	} else {
                $unique1 = $unique1 -replace '0x',''
                Write-Output $unique1
		}
}
}else {
	Write-Output "DELETE"
}

}
Catch [System.Management.Automation.ItemNotFoundException]
{
 Write-Output "DELETE"
 }
Finally { $ErrorActionPreference = "Continue" }
