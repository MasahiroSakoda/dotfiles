#!/usr/bin/env Bash

# Keyboard
defaults write -g KeyRepeat -int 1
defaults write -g InitialKeyRepeat -int 12

# Trackpad / Mouse
defaults write -g com.apple.mouse.tapBehavior -int 1
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag -bool true && \
  defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool true

defaults write -g NSAutomaticWindowAnimationsEnabled -bool false
defaults write -g NSWindowResizeTime 0.001
defaults write -g com.apple.springing.delay -float 0
defaults write -g com.apple.springing.enabled -bool true

# Finder
## Display Configurations
### Show directory first
defaults write com.apple.finder _FXSortFoldersFirst -bool true
### Show full path
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
### Show hidden files
defaults write com.apple.finder AppleShowAllFiles -bool true
### Show extensions
defaults write -g AppleShowAllExtensions -bool true
### Show status bar
defaults write com.apple.finder ShowStatusBar -bool true
### Show path bar
defaults write com.apple.finder ShowPathbar -bool false
### Hide all kind of drives
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool false
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
### Recent Tag
defaults write com.apple.finder ShowRecentTags -bool false

# Set default path for new windows.
# Computer     : `PfCm`
# Volume       : `PfVo`
# $HOME        : `PfHm`
# Desktop      : `PfDe`
# Documents    : `PfDo`
# All My Files : `PfAF`
# Other…       : `PfLo`
defaults write com.apple.finder NewWindowTarget PfHm

## Quick Look
defaults write com.apple.finder QLEnableTextSelection -bool true

chflags nohidden ~/Library
sudo chflags nohidden /Volumes
sudo nvram SystemAudioVolume=" "
killall Finder

# Desktop services
# .DS_Store on network storages
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
# defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Dock Configurations
## 2D / 3D Dock
defaults write com.apple.dock no-glass -bool true
## Autohide
defaults write com.apple.dock autohide -bool true
## Recent opened app
defaults write com.apple.dock show-recents -bool false
## Launch Delay
defaults write com.apple.dock autohide-delay -float 0
## Launch Animation
defaults write com.apple.dock launchanim -bool false
## Bouncing animation
defaults write com.apple.dock no-bouncing -bool true
## Hidden Apps
defaults write com.apple.dock showhidden -bool true
killall Dock

# SystemUIServer
## Date format
defaults write com.apple.menuextra.clock DateFormat -string 'd HH:mm'
## Show battery percentage
defaults write com.apple.menuextra.battery ShowPercent -string "YES"
## Disable drop shadow on screenshot
defaults write com.apple.screencapture disable-shadow -bool true
defaults write com.apple.screencapture type -string "png"
killall SystemUIServer

# Safari.app
defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true
defaults write com.apple.Safari ShowStatusBar -bool true
defaults write com.apple.Safari ShowFavoritesBar -bool false
defaults write com.apple.Safari AutoOpenSafeDownloads -bool false
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true
defaults write -g WebKitDeveloperExtras -bool true
killall Safari
