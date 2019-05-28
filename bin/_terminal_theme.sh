#!/bin/bash
osascript <<EOD
set profile to "Readable"

tell application "Terminal" to quit

delay 30

do shell script ("
 defaults write com.apple.terminal 'Default Window Settings' -string '" & profile & "';
 defaults write com.apple.terminal 'Startup Window Settings' -string '" & profile & "';
")

tell application "Terminal"
    activate
    delay 0.2
    tell application "System Events"
        tell application process "Terminal"
            set frontmost to true
        end tell
    end tell
end tell
EOD


