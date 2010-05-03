(*
	New THL Task
	Nic Fletcher
	7 May 2009
	V 1.0
	
	Some thoughts and ideas were inspired by other scripts, but the LaunchBar text input was very much based on	Ted Wise's script (http://tedwise.com/category/mac/), although I simplified it a little by removing some functionality.
	
	**********************************************************************

	This script can be launched generically a number of ways:
	
	A) LaunchBar, Butler (free) or QuickSilver (free), etc. Just type your shortcut and enter.
	
	B) Using Spark, QuickSilver or Butler (using both only as a shortcut manager), or any other keyboard shortcut manager.
	
	C) You can use the standard OS X AppleScript Icon on the menu bar (if you are a mousey person)
	
	D) You can use the text input and file input from LaunchBar as well. Over the last few months I have moved away from Quicksilver to LaunchBar. Yes, even though LaunchBar is not free! But I have found it much more intuitive, and more flexible in terms of scripting, with a very light overhead. So, apart from using it as a launcher, this script does not support Quicksilver.
	 
	The script creates a New THL Task based on a number of scenarios. THL does not need to be running (if it is not, it will launched as hidden). I also strongly recommend using Growl. The script will check that you have Growl installed and running, so it should not cause any errors if you do NOT use growl. But, this is what gives me the confidence to know that my task is now in THL.

	**********************************************************************
	
	Here are the current scenarios:
		
	1) Safari: While Safari is the foreground application, launch the script (see above) and a new task will be created in THL, with the title of the webpage as the task name. The URL for the page will appear in the notes. Also, if any text is selected, it will also appear in the notes.
	
	2) Apple Mail - Interactive: While Mail is the foreground application, launch the script (see above) and a new task will be created in THL for each email currently selected. An error message will appear if no task is selected. This script can also be run by Mail Act-On (www.indev.ca/MailActOn.html - version 1, which is sufficient, is free), which will also allow you to set other actions in Mail's rules (such as move the mail item to a different folder after adding to THL - OS X will remember where the mail is).
	
	3) Apple Mail - Background Rule: If you set up a mail rule in preferences, with one of the options to run this script, then when a new eMail arrives with the condition of your rule set, then the script will automatically be launched by Mail. You can also choose additional actions for the email as well (such as moving to a different mail box). Most mail servers accept the "myname+something@mydomain.com" syntax, which means you simply add, say, "+thl" after your name and before the "@" sign. This is an easy rule to setup (although you can choose title, as well).
	
	4) Finder: While Finder is the foreground application, launch the script (see above) and a new task will be created in THL for each Finder Item selected, with the shortcut in the notes.

	5) Dropped Files: Although this script is not compiled as an application, it is possible for utilities like LaunchBar  to "send" files to the script, which will then act as if files were dropped on it. It is easier to use a shortcut key to run the script when in finder, but sometimes in LaunchBar and Quicksilver one searches for a file and then wants to send it to the script without opening Finder.

		NOTE:  The routine for 4 & 5 above can be configured (see properties below) to use AppleScript to create the task, but this does not create a user-friendly shortcut in THL and will only reveal the file in Finder (not open it). By default, I rather open the file(s) with THL because it creates a nicer shortcut in the notes field. But this also means the task can only EVER go to the Inbox and will always appear at the top of the list and will also not have a start date. You can change this option in the properties below.
	
	6) Launchbar: This script can also be used to create a new THL task using LaunchBar. Simply type your shortcut for the script into LaunchBar, and when the script appears type a space, at which point a text field will open. You can then type the name of your task. ALSO... if you put the "%" sign followed by a List name, the script will place the task into that list (if it exists, otherwise it will prompt if you want to cancel or add to the Inbox). 

	**********************************************************************
	
	Installation: 
	
	1) Place the script into your mail personal Scripts folder, which will usually be something like:
		"Macintosh HD:Users:myusernamne:Library:Scripts"

	2) Modify any of the properties at the start of the script to modify the way the script runs.		

	3) Configure any add-on applications that you will use with this, such as Mail Act-on, LaunchBar, QuickSilver, Butler, Spark, Apple Mail rules, etc.

	Note: For Spark, I have found it is better not to run the script directly from Spark, but rather execute a script to launch this scipt. The following is the script I use in Spark. This might also help with other shortcut managers:
		
		set scriptAlias to "Macintosh HD:Users:myusernamne:Library:Scripts:New THL Task.scpt" as alias
		run script scriptAlias
	 
	**********************************************************************	
*)


--Set properties to define default behaviours. 

--Choose if you want task added to beginning or end of list (make sure one of the following is NOT commented out)
--property thePosition : "Beginning"
property thePosition : "End"
property useStartDate : true

--Set the text for the Growl messages 
property scriptName : "New Task to THL"
property notifySuccess : "Success Notification"
property notifyFail : "Failed Notification"
property titleSuccess : "New task added to THL"
property titleFail : "Task to THL FAILED"
property txtSuccess : " added to THL successfully" --the app name will be added in the script
property txtFail : " to THL FAILED to add successfully" --the app name will be added in the script
property txtIcon : "The Hit List" --name of the app whose icon Growl will use

--Include email text in the notes field of the task as well as the hyperlink
property mailBody : false

--Set the default List for adding tasks to
property theList : "Inbox"

--Set how Files should be sent to THL
--true creates a nice shortcut, but no option for list or date)
--false allows manipulation of the list, position in the list, and a start date, but is not a user-friendly link
property niceShortCut : true

--Do not change the following properties
property appName : ""
property currDate : ""
property GrowlRun : false
property groupList : {}


# The default action when the script is run. It could be called from a shortcut (Spark, QuickSilver, Butler, etc.)
# or from the scripts menu or just from finder. It is run without any parameters, as the information for the 
# new THL task is selected in the frontmost application when the script was launched.
on run
	NewTHLTask(null, null)
end run


# The default action when the script is opened by sending files to it.
# This is usually done via LaunchBar or Quicksilver
on open (theFiles)
	NewTHLTask(theFiles, "DroppedFiles")
end open


# Run when called from LaunchBar with supplied text (but not if only using LaunchBar
# as a launcher, in which case the "run" handler above is used)
on handle_string(theTask)
	NewTHLTask(theTask, "LaunchBarTxt")
end handle_string


# Run when called by Apple Mail from a mail rule (including form Mail Act-on, although Mail Act-on could still work
# using the "appMail" handler further below, since the messages are always "selected" when using Mail Act-on)
on perform_mail_action(theData)
	tell application "Mail" to set theMessages to |SelectedMessages| of theData --Extract the messages from the rule
	NewTHLTask(theMessages, "MailRule") --Call the main New THL Task handler
end perform_mail_action


# This is the main New THL Task Handler. Essentially, it checks which application has called the script and
# launches the appropriate processing handler. Additionally: it checks to see if Growl is running on this machine
# and, if so, configures it for this script; and it acts as the main Error Handler for the whole script.
on NewTHLTask(theData, appName)
	try
		--Check if growl is running and set the property to true or false for later processing
		tell application "System Events" to set GrowlRun to (count of (every process whose name is "GrowlHelperApp")) > 0
		
		--Setup Growl - only need to run this section once, but has little overhead, so is easier to run each time
		if GrowlRun then tell application "GrowlHelperApp" to register as application scriptName all notifications {notifySuccess, notifyFail} default notifications {notifySuccess, notifyFail} icon of application txtIcon
		
		--Set the date variable to be used as Start Date (if set). Email processing overrides this date and uses the date the email was received.
		set currDate to current date
		
		--Find out which application called this script (unless we already know from a separate launch handler)
		if appName is null then tell application "System Events" to set appName to (name of first process whose frontmost is true) as text
		
		--Launch the appropriate handler depending on the application that called the script
		if appName is "LaunchBarTxt" then
			appLaunchBar(theData) -- If called by the handle_string handler (which is called by LaunchBar)			
		else if appName is "MailRule" then -- If called by the perform_mail_action handler (which is called by an Apple Mail rule)
			appMail(theData)
		else if appName is "Mail" then --If Mail was the frontmost application when the script was called
			appMail(null)
		else if appName is "Safari" then --If Safari was the frontmost application when the script was called
			appSafari()
		else if appName is "Finder" then --If Finder was the frontmost application when the script was called
			appFinder(null)
		else if appName is "DroppedFiles" then
			appFinder(theData)
		else
			display alert "THL New Task - Error" message "This script was called from an unsupported application (" & appName & "). Check that a supported application is the frontmost window and execute the script again."
		end if
		
		--This is the main error handling for the whole script
	on error errMsg number errNum
		my GrowlFail(appName)
		if errNum is -128 then
			display alert "User Canceled" message "This script has been canceled and no new task has been created"
			return
		end if
		display dialog "Error: " & the errNum & ". " & the errMsg buttons {"OK"} default button 1
	end try
end NewTHLTask


# Called when Apple Mail is the frontmost application or by an Apple Mail rule.
# It will cycle through the selected messages and create a task from the email subject and 
on appMail(theMessages)
	tell application "Mail"
		--An Apple Mail rule will pass the messages as a variable, otherwise we need to use the currently selected messages
		if theMessages is null then set theMessages to the selection
		if the length of theMessages is less than 1 then error "One or more messages must be selected"
		repeat with theMessage in theMessages
			set theSubject to subject of theMessage
			set currDate to date received of theMessage
			set messageURL to "Created from message:%3c" & (message id of theMessage) & "%3e"
			set theBody to messageURL
			if mailBody then set theBody to theBody & return & return & the content of theMessage
			my addTask(theSubject, theBody, theList) --Create the task
			my GrowlSuccess("Mail item: " & theSubject)
		end repeat
	end tell
end appMail


# Called when Safari is the frontmost application.
# It will create a THL task with the title of the current URL, create a URL shortcut in the notes
# and if any any text is selected in the Safari window, this will also appear in the notes of the task.
# The routine now "trims" various non-printing characters from the title, which made the list in THL ugly for some sites
on appSafari()
	tell application "Safari"
		set theTitle to my trim((do JavaScript "document.title" in document 1))
		set theURL to (get URL of document 1)
		set selectedText to (do JavaScript "(getSelection())" in document 1)
		if selectedText is not "" then set theURL to theURL & return & return & selectedText
		my addTask(theTitle, theURL, theList)
		my GrowlSuccess("Safari item: " & theTitle)
	end tell
end appSafari


# Called when Finder is the frontmost application or when files are dropped on or set to the script.
# If Finder was used, it will check to see if any files are selected. In both cases it will create a THL task for each file.
# There is also an option in the properties above on how to add the file / task to THL. One way creates a nice icon
# that will open the relative application, but it can ONLY go to the Inbox and only at the top and will have not date.
# The other option creates a hyperlink, and can include dates and use the default list, but will only "reveal" in finder.
on appFinder(theFiles)
	tell application "Finder"
		if theFiles is null then
			if (count of (selection as list)) is not greater than 0 then
				display alert "No Files Selected" message "A new task cannot be added to The Hit List because there are no items selected in the current finder window or desktop. Please select one of more items and execute this script again."
				return
				my GrowlFail("Finder item")
			else
				set theFiles to selection as alias list
			end if
		end if
		
		repeat with theFile in theFiles
			if niceShortCut then --See property setting at top of script
				tell application "The Hit List" to open theFile
			else
				-- Convert the spaces to %20's so the URL will create properly
				set tid to AppleScript's text item delimiters
				set AppleScript's text item delimiters to " "
				set tmpPath to every text item of the POSIX path of theFile
				set AppleScript's text item delimiters to "%20"
				set thePath to tmpPath as string
				set AppleScript's text item delimiters to tid
				-- Create the path and send to THL
				set thePath to "file://" & thePath
				my addTask(name of theFile as text, thePath, theList) --Create the task
			end if
			my GrowlSuccess("Finder item: " & name of theFile & return)
		end repeat
	end tell
end appFinder


# This is the LaunchBar handler when used with text.
# It will create a task using the text supplied by LaunchBar. It will also check to see if and then use a 
# specific List if it has been defined in Launchbar (by adding "%ListName" at the end of the task).
on appLaunchBar(theTask)
	set theParsedTask to my parse_task(theTask)
	--The result of parsing is: item 1 is the task text and item item 2 is the list name or null if a list wasn't specified
	set theTask to item 1 of theParsedTask
	--Use a custom list if defined by LaunchBar (if not, the standard list defined in properties will be used)
	if not (item 2 of theParsedTask is null) then set theList to item 2 of theParsedTask
	my addTask(theTask, "Added from LaunchBar", theList)
	GrowlSuccess("LB text: " & theTask)
end appLaunchBar


# This is the main handler that creates the task. It calls one other handler to collect all valid list
# names in THL, and checks that the specified list exists. It then  
on addTask(theTitle, theNotes, theList)
	
	--First, determine, verify, and set the appropriate List (group)
	if theList = "Inbox" then
		tell application "The Hit List" to set theList to inbox -- Need to coerce theList from text to the inbox group in THL
	else --We need to get a list of all Lists (groups) & check the specified list exists
		tell application "The Hit List"
			my recurseGroups("Initial") --Get list of all Lists (which are technically groups in the THL Applescript dictionary)
			
			-- Check that the specified list exists 
			repeat with theGroup in groupList
				if name of theGroup = theList then
					set theList to theGroup --Also need to reset theList from text to the actual object of theGroup
					exit repeat --No need to continue in loop if we've already found a match
				end if
			end repeat
		end tell --We end the "Tell" statement here, so the following alert dialog is not behind a bouncing dock THL (but rather the original app that called the script)
		
		--Not the most elegant way, but if there was not a match above, then the class will not be a proper THL List
		if class of theList is not equal to list then
			--Ask the user if he/she wants to use the Inbox instead or to Cancel adding the task
			set alertResult to display alert theList & " cannot be found" message "The specified list: \"" & theList & "\" cannot be found in The Hit List group of lists. You can either use the Inbox or cancel the new task" buttons {"Cancel", "Use Inbox"} default button "Use Inbox" cancel button "Cancel"
			if button returned of alertResult is "Use Inbox" then tell application "The Hit List" to set theList to inbox
		end if
	end if
	
	--Now finally create the task
	tell application "The Hit List"
		set propList to {title:theTitle, notes:theNotes}
		if useStartDate then set propList to propList & {start date:currDate}
		
		tell theList to set myResult to make new task with properties propList
		try
			if thePosition = "Beginning" then tell theList to move myResult to beginning of tasks
			if thePosition = "End" then tell theList to move myResult to end of tasks
		on error number -2753 -- If "thePosition" variable does not exist, then ignore the error
		end try
	end tell
	return myResult
end addTask


# This handler searches THL and returns a list of all Lists
# Note there is a bug that if a list (i.e. not a folder or smartfolder) is the very first entry in the 
# Folders section of THL, then this list does not get returend, but ONLY if the script was launched from the
# script icon menu (which with Spark, QuickSilver, LaunchBar, Butler, etc. would never be used anyway)
on recurseGroups(recGroups)
	-- When this is run for the first time (before recursively calling), then must set recGroups to "Initial"
	tell application "The Hit List"
		if recGroups = "Initial" then
			set recGroups to groups of folders group
			set groupList to {}
		end if
		repeat with subGroup in recGroups
			if class of subGroup as rich text = "list" then
				set end of groupList to the subGroup
			end if
			try
				my recurseGroups(groups of subGroup)
			on error number -1728 --Ignore the error thrown when there is nothing more to recurse
			end try
		end repeat
		-- DEBUG#########################################DEBUG	
		-- set tmpMsg to ""
		-- repeat with nic in groupList
		--	  set tmpMsg to (tmpMsg & name of nic as rich text) & return
		-- end repeat
		-- end tell
		-- display alert "List of Lists (to check if first one is missing)" message tmpMsg
		-- tell application "The Hit List"
		-- DEBUG########################################DEBUG			
	end tell
end recurseGroups


# Parse the task text looking for a group name
# returns a two-part list, item 1 is the task text w/ the group name
# item 2 is the group name or null if no group was specified
# Taken from Ted Wise (http://tedwise.com/category/mac/)
on parse_task(theTask)
	set theParsedTask to {}
	set tid to AppleScript's text item delimiters
	set AppleScript's text item delimiters to "%"
	set tokens to text items of theTask
	if (count of tokens) is equal to 1 then
		set theParsedTask to {theTask, null}
	else
		set theShortTask to items 1 thru -2 of tokens as text
		set theParsedTask to {theShortTask, last item of tokens}
	end if
	set AppleScript's text item delimiters to tid
	return theParsedTask
end parse_task


# Handler to get Growl to display a success message using the Success notification
on GrowlSuccess(theMessage)
	if GrowlRun then tell application "GrowlHelperApp" to notify with name notifySuccess title titleSuccess description theMessage & txtSuccess application name scriptName
end GrowlSuccess


# Handler to get Growl to display an error or failure message using the Fail notification
on GrowlFail(theMessage)
	if GrowlRun then tell application "GrowlHelperApp" to notify with name notifyFail title titleFail description theMessage & txtFail application name scriptName
end GrowlFail


# Handler to remove spaces from beginning and end of Web Page titles 
on trim(someText)
	set charsToRemove to {" ", tab, return, ASCII character 0, ASCII character 10} -- 0 = Null, 10 = line feed
	
	repeat until first character of someText is not in charsToRemove
		set someText to text 2 thru -1 of someText
	end repeat
	
	repeat until last character of someText is not in charsToRemove
		set someText to text 1 thru -2 of someText
	end repeat
	
	return someText
end trim