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
