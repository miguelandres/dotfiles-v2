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

# Determine the best available font (Berkeley Mono Nerd Font with fallback to MesloLG Nerd Font)
FONT_NAME="BerkeleyMonoNerdFontComplete-Regular"

if ! (fc-list : family | grep -i "Berkeley" >/dev/null 2>&1 || \
      find "$HOME/Library/Fonts" "/Library/Fonts" -name "*Berkeley*Nerd*" -o -name "*BerkeleyMono*" >/dev/null 2>&1); then
  # Fallback to MesloLG Nerd Font
  FONT_NAME="MesloLGSNFM-Regular"
  if ! (fc-list : family | grep -i "MesloLGS" >/dev/null 2>&1 || \
        find "$HOME/Library/Fonts" "/Library/Fonts" -name "*MesloLGS*" >/dev/null 2>&1); then
    if fc-list : family | grep -i "MesloLGL" >/dev/null 2>&1 || \
       find "$HOME/Library/Fonts" "/Library/Fonts" -name "*MesloLGL*" >/dev/null 2>&1; then
      FONT_NAME="MesloLGLNFM-Regular"
    fi
  fi
fi

# Apply font to iTerm2 (all profiles)
if command -v python3 >/dev/null 2>&1; then
  python3 "$(dirname "$0")/set_iterm_font.py" "$FONT_NAME"
else
  plutil -replace "New Bookmarks.0.Normal Font" -string "${FONT_NAME} 12" ~/Library/Preferences/com.googlecode.iterm2.plist
fi

# Apply font to Terminal.app (all profiles)
osascript "$(dirname "$0")/set_terminal_font.applescript" "$FONT_NAME"

# Refresh the macOS defaults caching system (cfprefsd) to apply the changes
defaults read com.googlecode.iterm2 >/dev/null
