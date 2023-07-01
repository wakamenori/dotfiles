alias co="code ."
alias coi="code-insiders ."
alias ch="~/shellscripts/pycharm ."
alias ws="~/shellscripts/webstorm ."
alias ds="~/shellscripts/dataspell ."
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#
export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOBIN
# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

# Customize to your needs...
# neovimをデフォルトに設定
alias v="nvim"
alias vi="nvim"
alias vim="nvim"
alias view="nvim -R"
alias cat="bat"

# History
export HISTFILE=~/.zsh_history
export HISTSIZE=100000
export SAVEHIST=1000000

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
alias gm="git branch --merged|egrep -v '\*|dev|main'|xargs git branch -d"
# python
alias vpy="python3 -m venv venv ; source ./venv/bin/activate"
alias de="deactivate"

export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# Flutter
export PATH=~/development/flutter/bin:$PATH

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
export WAKATIME_API_KEY=3fbc8f6f-103c-4192-8f22-e65f1b6f13a6

# peco history
function peco-history-selection() {
    BUFFER=$(history 1 | sort -k1,1nr | perl -ne 'BEGIN { my @lines = (); } s/^\s*\d+\*?\s*//; $in=$_; if (!(grep {$in eq $_} @lines)) { push(@lines, $in); print $in; }' | peco --query "$LBUFFER")
    CURSOR=${#BUFFER}
    zle reset-prompt
}
zle -N peco-history-selection
bindkey '^R' peco-history-selection


# cdr
if [[ -n $(echo ${^fpath}/chpwd_recent_dirs(N)) && -n $(echo ${^fpath}/cdr(N)) ]]; then
    autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
    add-zsh-hook chpwd chpwd_recent_dirs
    zstyle ':completion:*' recent-dirs-insert both
    zstyle ':chpwd:*' recent-dirs-default true
    zstyle ':chpwd:*' recent-dirs-max 1000
    zstyle ':chpwd:*' recent-dirs-file "$HOME/.cache/chpwd-recent-dirs"
fi
function peco-cdr () {
    local selected_dir="$(cdr -l | awk '{ print $2 }' | peco --prompt="cdr >" --query "$LBUFFER")"
    if [ -n "$selected_dir" ]; then
        BUFFER="cd ${selected_dir}"
        zle accept-line
    fi
}
zle -N peco-cdr
bindkey '^E' peco-cdr

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/matsukokuumahikari/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/matsukokuumahikari/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/matsukokuumahikari/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/matsukokuumahikari/google-cloud-sdk/completion.zsh.inc'; fi
eval "$(github-copilot-cli alias -- "$0")"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"


# JINA_CLI_BEGIN

## autocomplete
if [[ ! -o interactive ]]; then
    return
fi

compctl -K _jina jina

_jina() {
  local words completions
  read -cA words

  if [ "${#words}" -eq 2 ]; then
    completions="$(jina commands)"
  else
    completions="$(jina completions ${words[2,-2]})"
  fi

  reply=(${(ps:
:)completions})
}

# session-wise fix
ulimit -n 4096
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

# JINA_CLI_END







