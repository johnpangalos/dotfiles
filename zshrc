setopt promptsubst

source /opt/homebrew/opt/zinit/zinit.zsh

zinit wait lucid light-mode for \
  atinit"zicompinit; zicdreplay" \
      zdharma/fast-syntax-highlighting \
  atload"_zsh_autosuggest_start" \
      zsh-users/zsh-autosuggestions \
  blockf atpull'zinit creinstall -q .' \
      zsh-users/zsh-completions

zinit wait lucid for \
        OMZL::git.zsh \
  atload"unalias grv" \
        OMZP::git

PS1="READY >"

GEOMETRY_COLOR_DIR=152
zinit ice lucid atload"geometry::prompt"
zinit light geometry-zsh/geometry

export EDITOR="nvim"
export BROWSER=none
alias vim="nvim"

# Setup FZF
if type rg &> /dev/null; then
  export FZF_DEFAULT_COMMAND='rg --files'
  export FZF_DEFAULT_OPTS='-m --height 50% --border'
fi
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


alias vimrc="vim ~/.config/nvim/init.vim"
