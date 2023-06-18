export LANG=en_US.UTF-8

eval "$(/opt/homebrew/bin/brew shellenv)"

autoload -Uz compinit
compinit
# Generate new ~/.config/zr.zsh if it does not exist or if ~/.zshrc has been changed
if [[ ! -f ~/.config/zr.zsh ]] || [[ ~/.zshrc -nt ~/.config/zr.zsh ]]; then
  zr \
    ohmyzsh/ohmyzsh.git/lib/git.zsh \
    frmendes/geometry \
    junegunn/fzf.git/shell/key-bindings.zsh \
    ohmyzsh/ohmyzsh.git/plugins/git/git.plugin.zsh \
    zsh-users/zsh-syntax-highlighting \
    zsh-users/zsh-completions \
    > ~/.config/zr.zsh
fi

    # zsh-users/zsh-autosuggestions \
source ~/.config/zr.zsh

# Setup fnm https://github.com/Schniz/fnm
 eval "$(fnm env)"

export EDITOR="nvim"
export BROWSER=none
alias vim="nvim"

# Setup FZF
if type rg &> /dev/null; then
  export FZF_DEFAULT_COMMAND="rg --files --hidden --follow --glob '!.git'"
  export FZF_DEFAULT_OPTS='-m --height 50% --border'
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export PATH="~/.local/share/nvim/lsp_servers/:$PATH"

export PATH="$HOME/go/bin/:$PATH"


export PATH="/opt/homebrew/opt/llvm/bin:$PATH"

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"

alias ls="exa"

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

export PATH="$(brew --prefix llvm@13)/bin:$HOME/.bun-tools/zig:$PATH"
export LDFLAGS="$LDFLAGS -L$(brew --prefix llvm@13)/lib"
export CPPFLAGS="$CPPFLAGS -I$(brew --prefix llvm@13)/include"

alias config="(cd ~/.dotfiles && vim)"
