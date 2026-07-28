

# Dock
defaults write com.apple.dock "tilesize" -int "40"
defaults write com.apple.dock "largesize" -int "100"
defaults write com.apple.dock "autohide" -bool "true"
defaults write com.apple.dock "show-recents" -bool "false"
defaults write com.apple.dock "mineffect" -string "genie"

# Finder
# 拡張機能を表示
defaults write NSGlobalDomain "AppleShowAllExtensions" -bool "true"
# パスバーを表示
defaults write com.apple.finder "ShowPathbar" -bool "true"
# リスト表示
defaults write com.apple.finder "FXPreferredViewStyle" -string "Nlsv"


# trackpad
# 3本指ドラッグ
defaults write com.apple.AppleMultitouchTrackpad "TrackpadThreeFingerDrag"
