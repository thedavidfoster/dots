#!/usr/bin/env bash
set -eu

# modules
source "$lib/symlink/index.sh"
source "$lib/is-osx/index.sh"

# Only run if on a Mac
if [[ 0 -eq `osx` ]]; then
  exit 0
fi

# exit 1
# paths
osx="$os/osx"

# Run each program
echo "starting to install defaults..."
sh "$osx/defaults.sh"
echo "...done with defaults"
echo "starting to install binaries..."
sh "$osx/binaries.sh"
echo "...done with binaries"
echo "starting to install apps..."
sh "$osx/apps.sh"
echo "...done with apps"

# install oh-my-fish
curl -L https://github.com/bpinto/oh-my-fish/raw/master/tools/install.fish | fish

# set default shell to fish
echo "/usr/local/bin/fish" | sudo tee -a /etc/shells
chsh -s /usr/local/bin/fish

#Post install instructions
echo "To complete full setup:"
echo "1. Open Dropbox and login to your account."
echo "2. Wait until syncing is completed."
echo "3. Run 'mackup restore'."
echo "4. Reboot Mac."

# Symlink the profile
# disabled because I am using Mackup
#if [[ ! -e "$HOME/.bash_profile" ]]; then
#  echo "symlinking: $osx/profile.sh => $HOME/.bash_profile"
#  symlink "$osx/profile.sh" "$HOME/.bash_profile"
#  source $HOME/.bash_profile
#else
#  echo "$HOME/.bash_profile already exists. remove and run again."
#fi
