on handle_string(my_status)
  if (my_status is not "") then
    tell application "Adium" to go available with message my_status
  end if
end handle_string

tell application "Adium" to go available with message "%_itunes"