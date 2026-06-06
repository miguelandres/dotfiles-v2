#!/bin/zsh

# Configure Option keys to send +Esc (value 2) in the Default Profile (index 0)
plutil -replace "New Bookmarks.0.Option Key Sends" -integer 2 ~/Library/Preferences/com.googlecode.iterm2.plist
plutil -replace "New Bookmarks.0.Right Option Key Sends" -integer 2 ~/Library/Preferences/com.googlecode.iterm2.plist

# Map Command + Left Arrow (0xf702...0x7b) -> Send Hex 0x01 (Ctrl+A -> beginning-of-line)
plutil -replace "New Bookmarks.0.Keyboard Map.0xf702-0x300000-0x7b" -json '{"Action":11,"Text":"0x01"}' ~/Library/Preferences/com.googlecode.iterm2.plist

# Map Command + Right Arrow (0xf703...0x7c) -> Send Hex 0x05 (Ctrl+E -> end-of-line)
plutil -replace "New Bookmarks.0.Keyboard Map.0xf703-0x300000-0x7c" -json '{"Action":11,"Text":"0x05"}' ~/Library/Preferences/com.googlecode.iterm2.plist

# Map Option + Left Arrow -> Send Escape + b (backward-word)
plutil -replace "New Bookmarks.0.Keyboard Map.0xf702-0x280000-0x7b" -json '{"Action":10,"Text":"b"}' ~/Library/Preferences/com.googlecode.iterm2.plist

# Map Option + Right Arrow -> Send Escape + f (forward-word)
plutil -replace "New Bookmarks.0.Keyboard Map.0xf703-0x280000-0x7c" -json '{"Action":10,"Text":"f"}' ~/Library/Preferences/com.googlecode.iterm2.plist

# Refresh the macOS defaults caching system (cfprefsd) to apply the changes
defaults read com.googlecode.iterm2 >/dev/null
