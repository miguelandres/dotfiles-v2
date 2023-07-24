#!/bin/bash

# ~/.macos — https://mths.be/macos

SCRIPT=$(readlink -f $0)
read -t 10 -p "Run ${SCRIPT} ? This may screw up your System Settings app until restart. Skipping in 10 secs [y/n] " yn
if [[ $? -gt 128 ]] ; then
  echo "Timed out. Skipping this script."
  exit
else
  case $yn in
      [Yy]* ) break;;
      [Nn]* ) echo "Not running the script"; exit;;
      * ) echo "Not running the script"; exit;;
  esac
fi
echo "Running ${SCRIPT}"

# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
osascript -e 'tell application "System Settings" to quit'

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.macos` has finished
while true; do
  sudo -n true
  sleep 60
  kill -0 "$$" || exit
done 2>/dev/null &

###############################################################################
# Trackpad, mouse, keyboard, Bluetooth accessories, and input                 #
###############################################################################

# Enable “natural” (Lion-style) scrolling
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool true

###############################################################################
# Screen                                                                      #
###############################################################################

# Disable shadow in screenshots
defaults write com.apple.screencapture disable-shadow -bool true

# Enable subpixel font rendering on non-Apple LCDs
# Reference: https://github.com/kevinSuttle/macOS-Defaults/issues/17#issuecomment-266633501
defaults write NSGlobalDomain AppleFontSmoothing -int 1

###############################################################################
# Finder                                                                      #
###############################################################################

# Finder: show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Use list view in all Finder windows by default
# Four-letter codes for view modes: Icon `icnv`, Column `clmv`, Gallery `glyv`, List "Nlsv"
defaults write com.apple.finder FXPreferredViewStyle -string "clmv"

# Show the ~/Library folder
chflags nohidden ~/Library && xattr -d com.apple.FinderInfo ~/Library

###############################################################################
# Dock, Dashboard, and hot corners                                            #
###############################################################################

# Hot corners
# Possible values:
#  0: no-op
#  2: Mission Control
#  3: Show application windows
#  4: Desktop
#  5: Start screen saver
#  6: Disable screen saver
#  7: Dashboard
# 10: Put display to sleep
# 11: Launchpad
# 12: Notification Center
# 13: Lock Screen
# Top left screen corner → Start Screen Saver
defaults write com.apple.dock wvous-tl-corner -int 5
defaults write com.apple.dock wvous-tl-modifier -int 0
# Top right screen corner → Mission Control
defaults write com.apple.dock wvous-tr-corner -int 2
defaults write com.apple.dock wvous-tr-modifier -int 0
# Bottom left screen corner → Show Application Windows
defaults write com.apple.dock wvous-bl-corner -int 3
defaults write com.apple.dock wvous-bl-modifier -int 0
# Bottom right screen corner → Desktop
defaults write com.apple.dock wvous-br-corner -int 4
defaults write com.apple.dock wvous-br-modifier -int 0

# Uncomment when https://github.com/kcrawford/dockutil/issues/146 is fixed

# dockutil --remove all --no-restart
# dockutil --add "/Applications/Safari.app" --no-restart
# dockutil --add "/Applications/Google Chrome.app" --no-restart
# dockutil --add "/Applications/Adobe Lightroom CC/Adobe Lightroom.app" --no-restart
# dockutil --add "/System/Applications/Messages.app" --no-restart
# dockutil --add "/Applications/Dashlane.app" --no-restart
# dockutil --add "/Applications/Visual Studio Code.app" --no-restart
# dockutil --add "/Applications/iTerm.app" --no-restart
# dockutil --add "/Applications/Parcel.app" --no-restart
# dockutil --add "/Applications/Things3.app" --no-restart
# dockutil --add "/System/Applications/Notes.app" --no-restart
# dockutil --add "/System/Applications/Music.app" --no-restart
# dockutil --add "/Applications/Discord.app" --no-restart
# dockutil --add "/Applications/Signal.app" --no-restart
# dockutil --add "/Applications/WhatsApp.app" --no-restart
# dockutil --add "/Applications/NetNewsWire.app" --no-restart
# dockutil --add "/System/Applications/App Store.app" --no-restart

###############################################################################
# Spotlight                                                                   #
###############################################################################

# Hide Spotlight tray-icon (and subsequent helper)
#sudo chmod 600 /System/Library/CoreServices/Search.bundle/Contents/MacOS/Search

# Change indexing order and disable some search results
# Yosemite-specific search results (remove them if you are using macOS 10.9 or older):
#   MENU_DEFINITION
#   MENU_CONVERSION
#   MENU_EXPRESSION
#   MENU_SPOTLIGHT_SUGGESTIONS (send search queries to Apple)
#   MENU_WEBSEARCH             (send search queries to Apple)
#   MENU_OTHER
defaults write com.apple.spotlight orderedItems -array \
  '{"enabled" = 1;"name" = "APPLICATIONS";}' \
  '{"enabled" = 1;"name" = "SYSTEM_PREFS";}' \
  '{"enabled" = 1;"name" = "DIRECTORIES";}' \
  '{"enabled" = 1;"name" = "PDF";}' \
  '{"enabled" = 1;"name" = "FONTS";}' \
  '{"enabled" = 1;"name" = "DOCUMENTS";}' \
  '{"enabled" = 1;"name" = "MESSAGES";}' \
  '{"enabled" = 1;"name" = "CONTACT";}' \
  '{"enabled" = 1;"name" = "EVENT_TODO";}' \
  '{"enabled" = 1;"name" = "IMAGES";}' \
  '{"enabled" = 1;"name" = "BOOKMARKS";}' \
  '{"enabled" = 1;"name" = "MUSIC";}' \
  '{"enabled" = 1;"name" = "MOVIES";}' \
  '{"enabled" = 1;"name" = "PRESENTATIONS";}' \
  '{"enabled" = 1;"name" = "SPREADSHEETS";}' \
  '{"enabled" = 1;"name" = "SOURCE";}'

# Load new settings before rebuilding the index
killall mds >/dev/null 2>&1
# Make sure indexing is enabled for the main volume
sudo mdutil -i on / >/dev/null
# Rebuild the index from scratch
sudo mdutil -E / >/dev/null

echo "Done. Note that some of these changes require a logout/restart to take effect."
