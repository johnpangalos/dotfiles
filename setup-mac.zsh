#!/bin/zsh

YES='(Y|y)'
NO='(N|n)'

# Install brew as well as a few dependencies
echo "Checking for brew"
if ! (( $+commands[brew] )); then
  echo "Brew not found, installing..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"

  brew install neovim \
    fzf \
    eza \
    go \
    fnm \
    git \
    gh \
    dockutil

  brew install --cask firefox \
    discord \
    karabiner-elements \
    rectangle \
    bitwarden \
    docker \
    tunnelblick \
    wezterm
else
  echo "Brew found skipping install."
fi

# Install node and setting it as the default for the system
echo "Checking for node"
if ! (( $+commands[node] )) && (( $+commands[fnm] )); then
  echo "Node not found, installing..."
  fnm install --lts
  fnm default lts-latest 
  eval "$(fnm env)"
  
  echo "Installing pnpm"
  curl -fsSL https://get.pnpm.io/install.sh | sh -
  source ~/.zshrc
else
  echo "Node found, skipping install."
fi


# Setup ssh key
#
# Creates a new ssh key and then uploads it to GitHub using the GitHub CLI
vared -p 'Would you like to setup a ssh key? This set is required for dotfiles setup: (Y/n) ' -c SHOULD_ADD_SSH_KEY

case $SHOULD_ADD_SSH_KEY in
  $~YES)
    vared -p 'Enter your email: ' -c EMAIL
    ssh-keygen -t ed25519 -C $EMAIL -N "" -q -f $HOME/.ssh/id_ed25519

    vared -p 'You will be prompted to login into GitHub to upload your ssh key there, press any key to continue.' -c TEMP
    gh auth login

    vared -p 'What would you like to title your ssh key on GitHub? ' -c SSH_KEY_TITLE
    gh ssh-key add $HOME/.ssh/id_ed25519.pub -t "${SSH_KEY_TITLE}"
    ;;
  $~NO)
    echo "Skipping dotfiles reset."
    ;;
  *)
    echo "Invalid argument $SHOULD_RESET, skipping dotfiles reset."
    ;;
esac

# Reinstall dark mode binary
vared -p 'Would you like to (re)install dark mode binary?: (Y/n) ' -c SHOULD_INSTALL_BINARY 
(
  case $SHOULD_INSTALL_BINARY in
    $~YES)
      echo "Installing dark mode notify binary"
      sudo mkdir -p /usr/local/bin/
      sudo cp ./dark-mode-notify /usr/local/bin/dark-mode-notify

      UID=$(id -u)
      if launchctl print gui/$UID/ke.bou.dark-mode-notify > /dev/null 2>&1 ; then
        launchctl bootout gui/$UID ~/Library/LaunchAgents/ke.bou.dark-mode-notify.plist
      fi
      launchctl bootstrap gui/$UID ~/Library/LaunchAgents/ke.bou.dark-mode-notify.plist
      launchctl kickstart -k gui/$UID/ke.bou.dark-mode-notify
      echo "Dark mode binary installed"
      ;;
    $~NO)
      echo "Skipping dark mode binary."
      ;;
    *)
      echo "Invalid argument $SHOULD_INSTALL_BINARY, skipping install."
      ;;
  esac
)

# Reset dotfiles
# Remove old dotfiles and replace them with symlinks
vared -p 'Would you like to reset dotfiles?: (Y/n) ' -c SHOULD_RESET 
(
  case $SHOULD_RESET in
    $~YES)
      echo "Downloading dotfiles repository"
      if [ ! -d $HOME/.dotfiles ]; then
        git clone -q -- git@github.com:johnpangalos/dotfiles.git $HOME/.dotfiles
      fi
      cd $HOME/.dotfiles

      echo "Resetting dotfiles"

      mkdir -p $HOME/.config
      mkdir -p $HOME/Library/LaunchAgents

      to_copy=(
        ".config/nvim"
        ".config/helix"
        ".config/sheldon"
        ".zshrc"
        ".wezterm.lua"
        ".change_background.sh"
        ".tool-versions"
        "Library/LaunchAgents/ke.bou.dark-mode-notify.plist"
      )

      for i in "${to_copy[@]}"; do
        rm -rf $HOME/${i}
        ln -s $HOME/.dotfiles/${i} $HOME/${i}
      done

      echo "Dotfiles reset."
      ;;
    $~NO)
      echo "Skipping dotfiles reset."
      ;;
    *)
      echo "Invalid argument $SHOULD_RESET, skipping dotfiles reset."
      ;;
  esac
)

# Setup nvim
# nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'

# Reset mac dock
vared -p 'Would you like to reset the Dock?: (Y/n) ' -c SHOULD_RESET_DOCK

case $SHOULD_RESET_DOCK in
  $~YES)
    defaults delete com.apple.dock persistent-apps
    defaults delete com.apple.dock recent-apps

    dock_item() {
      printf '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>%s</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>', "$1"
    }

    defaults write com.apple.dock persistent-apps -array \
      "$(dock_item /Applications/Firefox.app)" \
      "$(dock_item /Applications/WezTerm.app)" \
      "$(dock_item /Applications/Discord.app)" \
      "$(dock_item /Applications/Bitwarden.app)" \
      "$(dock_item /System/Applications/System\ Settings.app)" 

    killall Dock
    ;;
  $~NO)
    echo "Skipping Dock reset."
    ;;
  *)
    echo "Invalid argument $SHOULD_RESET_DOCK, skipping Dock reset."
    ;;
esac

vared -p 'Would you like to config git with you name and email?: (Y/n) ' -c SHOULD_CONFIG_GIT
case $SHOULD_CONFIG_GIT in
  $~YES)
    vared -p 'Enter your name: ' -c NAME
    vared -p 'Enter your email: ' -c EMAIL
    git config --global user.name $NAME 
    git config --global user.email $EMAIL 
    ;;
  $~NO)
    echo "Skipping git config."
    ;;
  *)
    echo "Invalid argument $SHOULD_CONFIG_GIT, skipping git config."
    ;;
esac

