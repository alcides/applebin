tell application "Finder"
	try
		get mount volume "smb://10.0.0.2/Storage (E)"
	on error my_error
		beep
		display dialog my_error
		return
	end try
end tell