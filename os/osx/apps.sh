#!/usr/bin/env bash
set -eu

#
# Application installer (via brew-cask)
# #- denotes an app I have from AppStore

# Apps
apps=(
  1password
#-acorn
  airfoil
  alfred
  appcleaner
  atom
  backblaze
  bartender
# boot2docker
# boot2docker-status
#-caffeine
#-daisydisk
  dayone-cli
  dropbox
  droplr
  duet
#-evernote
#-fantastical
  google-chrome
  google-drive
  google-earth
  google-earth-web-plugin
  google-nik-collection
  hazel
  heroku-toolbelt
  intellij-idea-ce
  istat-menus
  java
#-kindle
  kitematic
  little-snitch
  logitech-control-center
  mailbox
  moom
  mysqlworkbench
  name-mangler
  nvalt
  omnigraffle
# opendns-updater
#-pdfpen
  qlcolorcode
  qlgradle
  qlimagesize
  qlmarkdown
  qlprettypatch
  qlstephen
  quicklook-json
  rdio
# screens-connect
# shimo
  shiori
  silverlight
#-slack
#-sketch
  skype
#-soulver
  sublime-text
#-textexpander
  transmit
# valentina-studio
  ynab
)

# fonts
fonts=(
  font-bitter
  font-lato
  font-source-code-pro
  font-source-sans-pro
)

# Atom packages
atom=(
  advanced-railscasts-syntax
  atom-beautify
  autocomplete-plus
  file-icons
  fizzy
  git-history
  highlight-selected
  language-groovy
  linter
  merge-conflicts
  monokai
  sort-lines
  Sublime-Style-Column-Selection
  yosemite-unity-ui
  zentabs
)

# Specify the location of the apps
appdir="/Applications"

# Check for Homebrew
if test ! $(which brew); then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

main() {

  # Ensure homebrew is installed
  homebrew

  # Install homebrew-cask
  echo "installing cask..."
  brew install caskroom/cask/brew-cask

  # Tap alternative versions
  brew tap caskroom/versions

  # Tap the fonts
  brew tap caskroom/fonts

  # install apps
  echo "installing apps..."
  brew cask install --appdir=$appdir ${apps[@]}

  # install fonts
  echo "installing fonts..."
  brew cask install ${fonts[@]}

  # install atom plugins
  echo "installing atom plugins..."
  apm install ${atom[@]}

  # install gvm
  echo "installing gvm tools..."
  curl -s get.gvmtool.net | bash

  # Add osx specific command line tools
  if test ! $(which subl); then
    ln -s "/Applications/Sublime Text 2.app/Contents/SharedSupport/bin/subl" /usr/local/bin/subl
  fi

  cleanup
}

homebrew() {
  if test ! $(which brew); then
    echo "Installing homebrew..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi
}

alfred() {
  brew cask alfred link
}

cleanup() {
  brew cleanup
}

main "$@"
exit 0
