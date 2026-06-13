on run argv
    if (count of argv) is 0 then
        log "Usage: set_terminal_font.applescript <font_name> [font_size]"
        return
    end if

    set fontName to item 1 of argv
    set fontSize to 12
    if (count of argv) is greater than 1 then
        try
            set fontSize to (item 2 of argv) as integer
        end try
    end if

    tell application "Terminal"
        repeat with profileName in (get name of every settings set)
            try
                tell settings set profileName
                    set font name to fontName
                    set font size to fontSize
                end tell
            end try
        end repeat
    end tell
end run
