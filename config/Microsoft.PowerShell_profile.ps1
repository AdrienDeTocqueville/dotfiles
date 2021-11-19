function prompt {
	$dateTime = get-date -Format "HH:mm:ss"
	$currentDirectory = $(Get-Location)
	write-host "[$dateTime] " -NoNewline -ForegroundColor Green
	write-host "$(Convert-Path $currentDirectory)>" -NoNewline -ForegroundColor Blue
	return " "
}
