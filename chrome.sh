#!/bin/bash

/usr/bin/osascript << END
tell application "Google Chrome"
    activate
    set index of window 1 to 1
    set index of window 2 to 1
end tell
END
