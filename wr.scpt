# wr - A Weather Information Script for Textual# Coded by Xeon3D with contributions from phracker# | SCRIPT START | # |Properties| property scriptname : "wr"property ScriptDescription : "A Weather Report Script for Textual"property ScriptHomepage : "https://github.com/xeon3d/textual5-scripts"property ScriptAuthor : "Xeon3D"property ScriptAuthorHomepage : "https://github.com/xeon3d"property ScriptContributors : "phracker"property CurrentVersion : "0.2.0"property CodeName : "I Want a Textual 6 License!"property SupportChannel : "irc://irc.freenode.org/#textual"#  Colorsproperty CBlack : (ASCII character 3) & "01"property CNBlue : (ASCII character 3) & "02"property CGreen : (ASCII character 3) & "03"property CRed : (ASCII character 3) & "04"property CBrown : (ASCII character 3) & "05"property CPurple : (ASCII character 3) & "06"property COrange : (ASCII character 3) & "07"property CYellow : (ASCII character 3) & "08"property CLGreen : (ASCII character 3) & "09"property CTeal : (ASCII character 3) & "10"property CCyan : (ASCII character 3) & "11"property CBlue : (ASCII character 3) & "12"property CPink : (ASCII character 3) & "13"property CGrey : (ASCII character 3) & "14"property CLGrey : (ASCII character 3) & "15"property CWhite : (ASCII character 3)property NoColor : (ASCII character 3) & "00"on textualcmd(cmd, channel)#- Formattingset FBold to (ASCII character 2)set FItalic to (ASCII character 1)set NewLine to (ASCII character 10)set Simple to falseif cmd is "" then	set msg to "/debug Usage: `/wr <location> <units>` | Location can be a zip code, the name of a city, etc. Units (which is optional, it'll default to C) can be 'Celsius' or 'Fahrenheit'"	return msgend ifif cmd contains "Celsius" then	set units to "c"	set AppleScript's text item delimiters to "Celsius"	set cmd to text item 1 of cmd & text item 2 of cmd	set AppleScript's text item delimiters to ""else if cmd contains "Fahrenheit" then	set units to "f"	set AppleScript's text item delimiters to "Fahrenheit"	set cmd to text item 1 of cmd & text item 2 of cmd	set AppleScript's text item delimiters to ""else	set units to "c"end ifif cmd is "about" then	set msg to scriptname & " " & CurrentVersion & " (Codename: '" & CodeName & "') - " & ScriptDescription & ". Coded by " & ScriptAuthor & " with contributions from " & ScriptContributors & ". Get the latest version @ " & ScriptHomepage	return msgend ifif cmd contains "simple" then	set UsedColor to ""	set FreeColor to ""	set SeparatorColor to ""	set CWhite to ""	set FBold to ""	set FItalic to ""	set Simple to true	set AppleScript's text item delimiters to "simple"	set cmd to text item 1 of cmd & text item 2 of cmdend ifif cmd contains "  " then	set AppleScript's text item delimiters to "  "	set cmd to text item 1 of cmd & " " & text item 2 of cmdend ifif cmd contains "," then	set AppleScript's text item delimiters to ","	set City to text item 1 of cmd	set Country to text item 2 of cmdelse	set City to cmd	set Country to ""end ifif City contains " " then	set AppleScript's text item delimiters to " "	set City to text item 1 of City & "%20" & text item 2 of Cityend ifif Country contains " " then	set AppleScript's text item delimiters to " "	set Country to text item 1 of Country & "%20" & text item 2 of Countryend ifset FindWOEID to do shell script "curl http://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20geo.places%20where%20text=%22" & City & "%20" & Country & "%22"set AppleScript's text item delimiters to "<woeid>"set WOEID to text item 2 of FindWOEIDset AppleScript's text item delimiters to "</woeid>"set WOEID to text item 1 of WOEID--	return WOEIDset Weather to do shell script "curl " & quote & "http://weather.yahooapis.com/forecastrss?w=" & WOEID & "&u=" & units & "&" & quote & " | grep '^<yweather'" as textset aLocation to Weather's first paragraph as textset aUnits to Weather's second paragraphset aWind to Weather's third paragraphset aAtmosphere to Weather's fourth paragraphset aAstronomy to Weather's fifth paragraphset aCondition to Weather's sixth paragraphset aForecast1 to Weather's 7th paragraphset aForecast2 to Weather's eighth paragraphset aForecast3 to Weather's ninth paragraphset aForecast4 to Weather's tenth paragraphset aForecast5 to Weather's 11th paragraphset AppleScript's text item delimiters to "\""set aCity to aLocation's text item 2set aCountry to aLocation's text item 6set aTempUnit to aUnits's text item 2set aDistUnit to aUnits's text item 4set aPressUnit to aUnits's text item 6set aSpeedUnit to aUnits's text item 8set aWindDirection to aWind's text item 4 as numberset aWindSpeed to aWind's text item 6set aHumidity to aAtmosphere's text item 2set aVisibility to aAtmosphere's text item 4set aPressure to aAtmosphere's text item 6set aSunrise to aAstronomy's text item 2set aSunset to aAstronomy's text item 4set aState to aCondition's text item 2set aTemperature to aCondition's text item 6if aWindDirection is greater than 337.5 or aWindDirection is less than 22.5 then	set aWWindDirection to "↓"else if aWindDirection is greater than 22.5 and aWindDirection is less than 67.5 then	set aWWindDirection to "↙︎"else if aWindDirection is greater than 67.5 and aWindDirection is less than 112.5 then	set aWWindDirection to "←"else if aWindDirection is greater than 112.5 and aWindDirection is less than 157.5 then	set aWWindDirection to "↖︎"else if aWindDirection is greater than 157.5 and aWindDirection is less than 202.5 then	set aWWindDirection to "↑"else if aWindDirection is greater than 202.5 and aWindDirection is less than 247.5 then	set aWWindDirection to "↗︎"else if aWindDirection is greater than 247.5 and aWindDirection is less than 292.5 then	set aWWindDirection to "→"else if aWindDirection is greater than 292.5 and aWindDirection is less than 337.5 then	set aWWindDirection to "↘︎"end ifset aCurrentWeather to FBold & aCity & ", " & aCountry & FBold & ": " & aState & ", " & aTemperature & "º" & aTempUnit & ", Wind: " & aWWindDirection & " @ " & aWindSpeed & " " & aSpeedUnit & ", Humidity: " & aHumidity & "%, Visibility: " & aVisibility & " " & aDistUnitset aForecast to aForecast1's text item 2 & ": " & aForecast1's text item 10 & " (" & aForecast1's text item 6 & "º" & aTempUnit & "/" & aForecast1's text item 8 & "º" & aTempUnit & "), " & aForecast2's text item 2 & ": " & aForecast2's text item 10 & " (" & aForecast2's text item 6 & "º" & aTempUnit & "/" & aForecast2's text item 8 & "º" & aTempUnit & "), " & aForecast3's text item 2 & ": " & aForecast3's text item 10 & " (" & aForecast3's text item 6 & "º" & aTempUnit & "/" & aForecast3's text item 8 & "º" & aTempUnit & "), " & aForecast4's text item 2 & ": " & aForecast4's text item 10 & " (" & aForecast4's text item 6 & "º" & aTempUnit & "/" & aForecast4's text item 8 & "º" & aTempUnit & "), " & aForecast5's text item 2 & ": " & aForecast5's text item 10 & " (" & aForecast5's text item 6 & "º" & aTempUnit & "/" & aForecast5's text item 8 & "º" & aTempUnit & ")"return aCurrentWeather & NewLine & "Forecast: " & aForecastend textualcmd