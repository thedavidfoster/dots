#!/usr/bin/env bash
set -eu

#
# Binary installer
#

# Check for Homebrew
if test ! $(which brew); then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

echo "updating homebrew"
brew update

echo "installng coreutils"
brew install coreutils

echo "installing GNU fine, locate, updatedb and xargs, g-prefixed"
brew install findutils

echo "installing bash 4"
brew install bash

echo "install more recent versions of some OS X tools"
brew tap homebrew/dupes
brew install homebrew/dupes/grep

# Install other useful binaries
binaries=(
  ack
  bash-completion
  fish
  git
  graphicsmagick
  htop-osx
  imagemagick
  mackup
  mysql
  node
  python
  rbenv
  rbenv-gem-rehash
  readline
  ruby-build
  trash
)

# Install the binaries
brew install ${binaries[@]}

# Add osx specific command line tools
if test ! $(which subl); then
  ln -s "/Applications/Sublime Text 2.app/Contents/SharedSupport/bin/subl" /usr/local/bin/subl
fi

# Install spot
if test ! $(which spot); then
  curl -L https://raw.github.com/guille/spot/master/spot.sh -o /usr/local/bin/spot && chmod +x /usr/local/bin/spot
fi

echo "removing outdated versions from the cellar"
brew cleanup

exit 0
