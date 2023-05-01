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
    exa \
    go \
    fnm \
    git \
    gh \
    tmux

  brew install --cask firefox discord karabiner-elements rectangle bitwarden
else
  echo "Brew found skipping install."
fi

# Install node and setting it as the default for the system
echo "Checking for node"
if ! (( $+commands[node] )) && (( $+commands[fnm] )); then
  echo "Node not found, installing..."
  fnm install --lts
  fnm default lts-latest 
  
  echo "Installing pnpm"
  curl -fsSL https://get.pnpm.io/install.sh | sh -
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

    vared -p 'You will be prompted to login into GitHub to upload your ssh key there, press any key to continue.'
    gh auth login

    vared -p 'What would you like to title your ssh key on GitHub?' -C SSH_KEY_TITLE
    gh ssh-key add $HOME/.ssh/id_ed25519 -t SSH_KEY_TITLE
    ;;
  $~NO)
    echo "Skipping dotfiles reset."
    ;;
  *)
    echo "Invalid argument $SHOULD_RESET, skipping dotfiles reset."
    ;;
esac

# Install alacritty
#
# They don't seem to be making an arm version so we'll compile it
# from source.
if ! (( $+commands[rustup] )); then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi

if [ -d /Applications/Alacritty.app ]; then
  (
    cd $HOME
    git clone https://github.com/alacritty/alacritty.git 
    cd alacritty
    make app
    cp -R ./target/release/osx/Alacritty.app /Applications/Alacritty.app
    rm -rf ./alacritty
  )
fi

# Reset dotfiles
#
# Remove old dotfiles and replace them with symlinks
vared -p 'Would you like to reset dotfiles?: (Y/n) ' -c SHOULD_RESET 
(
  case $SHOULD_RESET in
    $~YES)
      echo "Downloading dotfiles repository"
      git clone -q -- git@github.com:johnpangalos/dotfiles.git $HOME/.dotfiles
      cd .dotfiles

      echo "Resetting dotfiles"

      mkdir -p $HOME/.config

      to_copy=(
        ".config/nvim"
        ".zshrc"
        ".tmux.conf"
        ".alacritty.yml"
        ".change_background.sh"
        "Library/LaunchAgents/ke.bou.dark-mode-notify.plist"
      )

      for i in "${to_copy[@]}"; do
        rm -rf $HOME/${i}
        ln -s $HOME/.dotfiles/${i} $HOME/${i}
      done

      echo "Installing dark mode notify binary"
      if [ $EUID != 0 ]; then
        sudo "$0" "$@"
        exit $?
      fi
      sudo cp ./dark-mode-notify /usr/local/bin/dark-mode-notify

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
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'

