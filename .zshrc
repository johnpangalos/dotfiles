export LANG=en_US.UTF-8

eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(/opt/homebrew/bin/mise activate zsh)"

if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

  autoload -Uz compinit
  compinit
fi

eval "$(sheldon source)"

export EDITOR="nvim"
alias vim="nvim"

# Setup FZF
if type rg &> /dev/null; then
  export FZF_DEFAULT_COMMAND="rg --files --hidden --follow --glob '!.git'"
  export FZF_DEFAULT_OPTS='-m --height 50% --border'
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export PATH="~/.local/share/nvim/lsp_servers/:$PATH"

export PATH="/opt/homebrew/opt/llvm/bin:$PATH"

bindkey -v

alias ls="eza"
alias asdf="mise"
alias sed="gsed"

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

export PATH="$(brew --prefix llvm@13)/bin:$HOME/.bun-tools/zig:$PATH"

export LDFLAGS="$LDFLAGS -L$(brew --prefix llvm@13)/lib"
export CPPFLAGS="$CPPFLAGS -I$(brew --prefix llvm@13)/include"

alias config="(cd ~/.dotfiles && vim)"

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

if command -v gcloud &> /dev/null; then
  source "$(brew --prefix)/share/google-cloud-sdk/path.zsh.inc"
  source "$(brew --prefix)/share/google-cloud-sdk/completion.zsh.inc"
fi

if command -v wezterm &> /dev/null; then
  mkdir -p $HOME/.config/wezterm
  wezterm shell-completion --shell zsh > $HOME/.config/wezterm/completions.zsh
  source "$HOME/.config/wezterm/completions.zsh"
  alias wez="wezterm cli"
fi

export PATH="${PATH}:${HOME}/.krew/bin"

alias pip="pip3"
alias python="python3"
export PATH="/opt/homebrew/opt/openjdk@11/bin:$PATH"

export GOPATH="$HOME/go"
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin


jwtd() {
    if [[ -x $(command -v jq) ]]; then
         jq -R 'split(".") | .[0],.[1] | @base64d | fromjson' <<< "${1}"
         echo "Signature: $(echo "${1}" | awk -F'.' '{print $3}')"
    fi
}

alias gfixup="git commit -v --fixup HEAD && GIT_SEQUENCE_EDITOR=touch git rebase -i --stat --autosquash --autostash HEAD~2"
alias gsquash="git commit -v --squash HEAD && GIT_SEQUENCE_EDITOR=touch git rebase -i --stat --autosquash --autostash HEAD~2"

export JAVA_HOME=/Library/Java/JavaVirtualMachines/amazon-corretto-11.jdk/Contents/Home
export GRAALVM_HOME=$HOME/Development/graalvm/Contents/Home/

alias mov-to-webm="sh $HOME/scratch/mov-to-web.sh"
