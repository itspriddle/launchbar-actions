-- via: http://forums.obdev.at/viewtopic.php?f=24&t=3724&sid=f482af68ae6d1bd3d8c312dac51307ab
-- used via launchbar
-- im_text: contact_name: message

on handle_string(im_text)
   if application "Adium" is running then
      repeat with im_delimiter_position from 1 to (length of im_text)
         if character im_delimiter_position of im_text = ":" then exit repeat
      end repeat
      -- get contact name
      set im_contact_name to characters 1 thru (im_delimiter_position - 1) of im_text as string

      if im_delimiter_position is not equal to length of im_text then
         -- get message
         set im_message to characters (im_delimiter_position + 2) thru (length of im_text) of im_text as string
      end if

      tell application "Adium"
         -- get user
         try -- first try to get online contact
            set user to first contact whose status type is not offline and (display name starts with im_contact_name or name starts with im_contact_name)
         on error -- if not possible, get offline contact
            set user to first contact whose display name starts with im_contact_name or name starts with im_contact_name
         end try

         if not (exists (chats whose contacts contains user)) then
            set the_window to get every chat window
            if the_window = {} then -- now chat window exists
               tell account of user to (make new chat with contacts {user} with new chat window)
            else -- chat window already exists, make new tab
               tell account of user to (make new chat with contacts {user} without new chat window)
            end if
         end if

         if im_delimiter_position is not equal to length of im_text then
            -- send message
            send (first chat whose contacts contains user) message im_message
         end if
      end tell
      return nothing
   end if
end handle_string
