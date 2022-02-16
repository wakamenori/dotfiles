alias co="code ."
alias ch="charm ."
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

# Customize to your needs...
# neovimをデフォルトに設定
alias vi="nvim"
alias vim="nvim"
alias view="nvim -R"

# History
export HISTFILE=~/.zsh_history
export HISTSIZE=100000
export SAVEHIST=100000

setopt no_beep
setopt auto_pushd
setopt pushd_ignore_dups
setopt auto_cd
setopt hist_ignore_dups
setopt share_history
setopt inc_append_history

alias cl="clear"
alias dialy="~/shellscripts/dialy.sh"
alias sp="spotify"

# git
alias gopen="git open"
alias t="tig"
# python
alias vpy="python3 -m venv venv | source ./venv/bin/activate"

# ghq & peco
function peco-src () {
  local selected_dir=$(ghq list -p | peco --query "$LBUFFER")
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N peco-src
bindkey '^]' peco-src

# nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Docker
alias dc="docker-compose"
# kube ps1
source <(kubectl completion zsh)
export PATH=$PATH:/Users/matsukokuumahikari/.cargo/bin
