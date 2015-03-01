set msg to ""set FBold to ""set cmd to "network en0"set ItemDelimiter to ""--Networkif cmd contains "network" then	if cmd's last word is "network" then		return "/debug Error. You need to input the interface name (en0 for ethernet or en1 for wifi usually) aka /si network en1 (for wifi stats)"	end if	set adapter to cmd's last word	set InitialTraffic to do shell script "netstat -b -I " & adapter & " | tail -n1 | awk {'print $(NF-1),$(NF-4)'}"	set AppleScript's text item delimiters to space	set InitialUploadedBytes to (text item 1 of InitialTraffic) / 1048576	set InitialDownloadedBytes to (text item 2 of InitialTraffic) / 1048576	set AppleScript's text item delimiters to ""	delay 1	set FinalTraffic to do shell script "netstat -b -I " & adapter & " | tail -n1 | awk {'print $(NF-1),$(NF-4)'}"	set AppleScript's text item delimiters to space	set FinalUploadedBytes to (text item 1 of FinalTraffic) / 1048576	set FinalDownloadedBytes to (text item 2 of FinalTraffic) / 1048576	set AppleScript's text item delimiters to ""	set DownloadedTraffic to roundThis(FinalDownloadedBytes / 1024, 3)	set UploadedTraffic to roundThis(FinalUploadedBytes / 1024, 3)	if DownloadedTraffic > 1 then		set DownloadedTrafficUnit to "GB"		set DownloadedTraffic to roundThis(DownloadedTraffic, 2) & DownloadedTrafficUnit	else		set DownloadedTrafficUnit to "MB"		set DownloadedTraffic to (DownloadedTraffic * 1000 as integer) & DownloadedTrafficUnit	end if	if UploadedTraffic > 1 then		set UploadedTrafficUnit to "GB"		set UploadedTraffic to roundThis(UploadedTraffic, 2) & UploadedTrafficUnit	else		set UploadedTrafficUnit to "MB"		set UploadedTraffic to (UploadedTraffic * 1000 as integer) & UploadedTrafficUnit	end if	set DifferenceBetweenUploadedBytes to (FinalUploadedBytes - InitialUploadedBytes)	set DifferenceBetweenDownloadedBytes to (FinalDownloadedBytes - InitialDownloadedBytes)	set DownloadSpeed to roundThis(DifferenceBetweenDownloadedBytes, 3)	set UploadSpeed to roundThis(DifferenceBetweenUploadedBytes, 3)	if DownloadSpeed > 1 then		set DownloadSpeedUnit to "MB/s"		set DownloadSpeed to roundThis(DownloadSpeed, 2)		set DownloadSpeed to DownloadSpeed & DownloadSpeedUnit	else		set DownloadSpeedUnit to "KB/s"		set DownloadSpeed to DownloadSpeed * 1000 as integer		set DownloadSpeed to DownloadSpeed & DownloadSpeedUnit	end if	if UploadSpeed > 1 then		set UploadedSpeedUnit to "MB/s"		set UploadSpeed to roundThis(UploadSpeed, 2)		set UploadSpeed to UploadSpeed & UploadedSpeedUnit	else		set UploadedSpeedUnit to "KB/s"		set UploadSpeed to UploadSpeed * 1000 as integer		set UploadSpeed to UploadSpeed & UploadedSpeedUnit	end if	set msg to FBold & "Net:" & FBold & " [" & adapter & "] D:" & DownloadSpeed & " [" & DownloadedTraffic & "] - U:" & UploadSpeed & " [" & UploadedTraffic & "]" & ItemDelimiter	return msgend ifon roundThis(n, numDecimals)	set x to 10 ^ numDecimals	(((n * x) + 0.5) div 1) / xend roundThis