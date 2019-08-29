#!/bin/bash
 osascript -e "
 tell application \"Xcode\"
     activate
     open \"$1$2\"
     set workspaceDocument to workspace document \"$2\"
     -- Wait for the workspace document to load with a 60 second timeout
     repeat 120 times
         if loaded of workspaceDocument is true then
             exit repeat
         end if
         delay 0.5
     end repeat
     if loaded of workspaceDocument is false then
         return
     end if
 end tell
"  > /dev/null
#xed -l $3 doesn't seem to scroll
xed $4
 osascript -e "
tell application \"System Events\"
    tell process \"Xcode\"
        -- got to line
        keystroke \"l\" using command down
        keystroke \"$3\"
        keystroke return
    end tell
end tell
"  > /dev/null
