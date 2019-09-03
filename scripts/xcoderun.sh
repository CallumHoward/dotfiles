#!/bin/bash
osascript -e "
if application \"XCode\" is running then
    -- check if the application is running but not visible in the dock
    tell application \"System Events\"
        if visible of process \"Xcode\" is false then
            -- activate xcode and reactivate the previous app
            tell application \"System Events\"
                set activeApp to name of first application process whose frontmost is true
            end tell
            tell application \"Xcode\" to activate
            activate application activeApp
        end if
    end tell
end if
tell application \"Xcode\"
    open \"$1$2\"
    set workspaceDocument to workspace document \"$2\"
    -- Wait for the workspace document to load with a 60 second timeout
    repeat 120 times
        if loaded of workspaceDocument is true then
            exit repeat
        end if
        delay 0.5
    end repeat
    if loaded of workspaceDocument is true then
        set actionResult to build workspaceDocument
        repeat
            if completed of actionResult is true then
                if status of actionResult is succeeded then
                    set actionResult to run workspaceDocument
                else
                    activate
                end if
                exit repeat
            end if
            delay 0.5
        end repeat
    end if
end tell
" > /dev/null
