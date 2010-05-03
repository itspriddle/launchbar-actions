-- via: http://forums.obdev.at/viewtopic.php?f=24&t=3448
-- Removed URL shortening (JP: 5/3/2010)
--Two changes to be made before you use this script
--1. Find this line in the script below and change it to the path to your Dropbox Public folder.
--Change ifolder to the path of your dropbox public folder (ex. /Users/John/Dropbox/Public/)
--2. Observe one of your Dropbox URLs and you will notice that there are some numbers in those URLs. That is your Dropbox id.
--Find this line in the script below and change it to your Dropbox id instead of 123456
--set dropboxID to 123456
-------------------------------------------------------------------
--How to use?
--Bring this script in LaunchBar, press space and type the name that you would like to give to that screenshot and press return
--e.g. myname
--This will generate screenshot named myname in png format in your Dropbox folder

--you can also enter the format of the image
--e.g. myname, jpg
--note that the syntax is <name><comma><space><format>
-------------------------------------------------------------------
--What will happen after you run this script?
--you will see a cross-hair, you can start selecting the region that you want a screenshot of or you can press "space" key and take a screenshot of a window
--once you have done that, Dropbox will upload the image. The public url will be shortened and copied to your clipboard and it will also be sent to LaunchBar in case you wanted to check if the image has been uploaded properly. Be patient before checking it. Observe the Dropbox icon in your menu bar to make sure that the upload has finished. Otherwise you will get 404 error.
--Let me know if you found this script useful or not. This will help me understand whether I must spend time writing instructions and posting such scripts or not........aristidesfl


--ATTENTION ATTENTION ATTENTION ATTENTION ATTENTION ATTENTION ATTENTION ATTENTION
--*******************************************************************************
property dropboxID : 123456 --> Replace this number with your dropbox ID
property ifolder : "/Users/priddle/Dropbox/Public/" --> Replace this path with your dropbox public folder path
--*****************************************************************************
--ATTENTION ATTENTION ATTENTION ATTENTION ATTENTION ATTENTION ATTENTION ATTENTION



on run

	set {year:y, month:m, day:d, hours:h, minutes:m, seconds:s} to (current date)
	set theDate to ("Screen shot " & y & "-" & m * 1 & "-" & d & " at " & h & "h" & m & "m" & s & "s")
	--set {year:y, month:m, day:d, time string:t} to (current date)
	--set theDate to ("Screen shot " & y & "-" & m * 1 & "-" & d & " at " & t)

	set theformat to "png"
	set thename to theDate & "." & theformat
	set thecmd to my dupcheck(thename, ifolder, theformat, dropboxID)
end run

on handle_string(thetext)
	try
		if application "Dropbox" is not running then launch application "Dropbox"
		tell application "LaunchBar" to hide

		set AppleScript's text item delimiters to ","
		set thename to first text item of thetext
		set theformat to false
		try
			set theformat to text 2 thru -1 of second text item of thetext
		end try
		if theformat is false then set theformat to "png"
		set AppleScript's text item delimiters to ""
		set thename to thename & "." & theformat as text
		set thecmd to my dupcheck(thename, ifolder, theformat, dropboxID)
	on error e
		tell me to activate
		display dialog e
	end try
end handle_string


-------------------------------------------------------------------
--Handlers
-------------------------------------------------------------------


on dupcheck(thename, ifolder, theformat, dropboxID)
	set thedupcheck to ifolder & thename

	--Changed Lines*********************************************************
	--set fileExistsFlag to false
	--try
	--   set fileExistsFlag to alias thedupcheck
	--end try
	--if fileExistsFlag = false then
	tell application "Finder" to if not (exists thedupcheck as POSIX file) then
		--Changed Lines******************************************************
		set thedecision to my processitem(thename, ifolder, theformat, dropboxID)
	else
		tell me to activate
		set thedisplay to display dialog "An item with the name \"" & thename & "\" already exists in the destination" buttons {"Replace", "Rename", "Cancel"} default button "Replace"
		if button returned of thedisplay is "Replace" then
			my processreplace(thename, ifolder, theformat, dropboxID)
		else
			if button returned of thedisplay is "Rename" then
				my processrename(thename, ifolder, theformat, dropboxID)
			end if
		end if
	end if
end dupcheck

on processitem(thename, ifolder, theformat, dropboxID)
	set ifile to ifolder & thename
	set qifile to quoted form of (POSIX path of ifile)
	set thecmd to "screencapture -i -t " & theformat & " " & qifile
	do shell script thecmd
	my processurl(thename, dropboxID)
end processitem

on processreplace(thename, ifolder, theformat, dropboxID)
	set ifile to ifolder & thename
	set qifile to quoted form of (POSIX path of ifile)
	do shell script "rm -r " & qifile
	set qifolder to quoted form of (POSIX path of ifolder)
	my processitem(thename, ifolder, theformat, dropboxID)
end processreplace

on processrename(thename, ifolder, theformat, dropboxID)
	repeat
		set AppleScript's text item delimiters to "."
		set theonlyname to text items 1 thru -2 of thename
		set thenameextension to last text item of thename
		set AppleScript's text item delimiters to ""
		tell me to activate
		set thename to text returned of (display dialog "Enter the new name: (This dialog box will reappear if an item with the new name you specified also exists in the destination folder)" default answer theonlyname)
		set thename to thename & "." & thenameextension
		set thenewcheck to ifolder & thename
		set fileExistsFlag to false
		try
			set fileExistsFlag to alias thenewcheck
		end try
		if fileExistsFlag = false then
			my processitem(thename, ifolder, theformat, dropboxID)
			exit repeat
		end if
	end repeat
end processrename
on processurl(thename, dropboxID)
	try
		set AppleScript's text item delimiters to " "
		set thename to text items of thename
		set AppleScript's text item delimiters to "%20"
		set thename to thename as string
		set AppleScript's text item delimiters to ""
	end try
	set theurl to "http://dl.getdropbox.com/u/" & dropboxID & "/" & thename
	set the clipboard to theurl
	tell application "LaunchBar"
		set selection as text to theurl
		activate
	end tell
end processurl