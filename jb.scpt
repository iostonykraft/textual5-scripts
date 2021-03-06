-- jb - A Jailbreaking Information Script for Textual 5
-- Coded by Xeon3D on request by hack (#hbqa)

-- 1 step Installation:
-- Right click file and choose Open With -> Textual 5 to install the script.



-- | SCRIPT START | --
-- |Properties| --
property scriptname : "jb"
property ScriptDescription : "A Jailbreak Information Script for Textual 5"
property ScriptHomepage : "https://raw.githubusercontent.com/Xeon3D/textual5-scripts/master/jb.scpt"
property ScriptAuthor : "Xeon3D"
property ScriptContributors : ""
property ScriptAuthorHomepage : "http://www.github.com/Xeon3D/"
property CurrentVersion : "0.0.2"
property CodeName : "The Proper Version"
property SupportChannel : "irc://irc.freenode.org/#textual"

---  Colors
property CBlack : (ASCII character 3) & "01"
property CNBlue : (ASCII character 3) & "02"
property CGreen : (ASCII character 3) & "03"
property CRed : (ASCII character 3) & "04"
property CBrown : (ASCII character 3) & "05"
property CPurple : (ASCII character 3) & "06"
property COrange : (ASCII character 3) & "07"
property CYellow : (ASCII character 3) & "08"
property CLGreen : (ASCII character 3) & "09"
property CTeal : (ASCII character 3) & "10"
property CCyan : (ASCII character 3) & "11"
property CBlue : (ASCII character 3) & "12"
property CPink : (ASCII character 3) & "13"
property CGrey : (ASCII character 3) & "14"
property CLGrey : (ASCII character 3) & "15"
property CWhite : (ASCII character 3)
property NoColor : (ASCII character 0)



on textualcmd(cmd)	
-- DEBUG CODE--set cmd to "iPhone2,1"-- If parameter supplied is a system model ID (only those contain commas)	if cmd contains "," then
		-- Gets list of all signed firmwares.
		set getfirmwares to the paragraphs of (do shell script "curl http://api.ipsw.me/v2.1/firmwares.json | grep '		\"signed\": true,' -B8 | tr -d \" 	\" | awk '/version|sha1sum|url/'")		set AppleScript's text item delimiters to ":"		set urls to ""		set shasums to ""		set versions to ""		set responseurls to ""		set responseversions to ""		set responseshasums to ""		set numberofitems to ""
		-- sorts results into groups of 3 items (sha5sum, url and version)		repeat with n from 1 to (count of items of getfirmwares)			if item n of getfirmwares begins with "\"sha" then				set shasums to shasums & (item n of getfirmwares) as list			else if item n of getfirmwares begins with "\"url" then				set urls to urls & (item n of getfirmwares) as list			else if item n of getfirmwares begins with "\"version" then				set versions to versions & (item n of getfirmwares) as list			end if		end repeat		set amodel to cmd		repeat with n from 1 to count of items of urls			if item n of urls contains amodel then				set responseurls to responseurls & ((item n's text item 2 of urls & ":" & item n's text item 3 of urls) as text) as list				set numberofitems to numberofitems & n & "," as text				set responseversions to responseversions & text item 2 of item n of versions as list				set responseshasums to responseshasums & text item 2 of item n of shasums as list			end if		end repeat		set msg2 to "Signed Firmwares for " & amodel & ": "		repeat with n from 1 to count of items of responseurls			set msg2 to msg2 & "Version: " & item n of responseversions & " Link: " & item n of responseurls & " SHA1SUM: " & item n of responseshasums & (ASCII character 10)		end repeat		set msg to msg2		return msg
		-- else if parameter is an IOS version.	else if cmd contains "." then		set getfirmwares to the paragraphs of (do shell script "curl http://api.ipsw.me/v2.1/firmwares.json | grep '		\"signed\": true,' -B8 -A1 | tr -d \" 	\" | awk '/version|file/' | awk -F'_' '{print $1}' | tr -d '\"' | sed 's/,$//' | awk -F':' {'print $2'}")		set filenames to ""		set filenamesok to ""		set versions to ""		set responsemodels to ""		set responseversions to ""		set numberofitems to ""		repeat with n from 1 to (count of items of getfirmwares)			if item n of getfirmwares contains "," then				set filenames to filenames & getfirmwares's item n as list			else				set versions to versions & getfirmwares's item n as list			end if		end repeat				set aversion to cmd				repeat with n from 1 to count of items of versions			if item n of versions is equal to aversion then				set numberofitems to numberofitems & n & "," as text				set responseversions to responseversions & versions's item n as list				set responsemodels to responsemodels & filenames's item n as list			end if		end repeat				set msg2 to "Devices that Apple is signing " & aversion & " for: "		repeat with n from 1 to count of items of responsemodels			set msg2 to msg2 & item n of responsemodels & " "		end repeat		set msg to msg2		return msg	end ifend textualcmd