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
    zsh-users/zsh-autosuggestions \
    > ~/.config/zr.zsh
fi

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

# export PATH="$HOME/go/bin/:$PATH"

alias ls="exa"
