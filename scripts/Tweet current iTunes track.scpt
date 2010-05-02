tell application "System Events"
  if exists process "iTunes" then
    tell application "iTunes"
      if player state is playing then
        set current_song to (name of current track) as Unicode text
        set current_artist to (artist of current track) as Unicode text
        if current_artist is equal to "" then set current_artist to "Unknown"
        set music_playing to "♫ " & current_song & " - " & current_artist
      end if
    end tell
  else
    if button returned of (display dialog "iTunes isn't running" & return & "" buttons {"Wait", "Quit"}) is "Quit" then quit
  end if
end tell


set the_status to quoted form of ("status=" & music_playing)
try
  do shell script "curl -n -d " & the_status & " https://twitter.com/statuses/update.xml --insecure"
on error
  open location "x-launchbar:large-type?string=There+was+an+error+sending+your+tweet.+Please+try+again."
end try