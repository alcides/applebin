set CR to ASCII character of 13
tell application "System Events"
    tell application "Adium" to activate
   keystroke "j" using {command down, shift down}
    keystroke "ninjas"
    keystroke CR
end tell