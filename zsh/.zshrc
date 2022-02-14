

#
# User configuration sourced by interactive shells
#

# Source zim
if [[ -s ${ZDOTDIR:-${HOME}}/.zim/init.zsh ]]; then
  source ${ZDOTDIR:-${HOME}}/.zim/init.zsh
fi

alias ctags="`brew --prefix`/bin/ctags"
set -o vi
export FZF_DEFAULT_OPTS='--no-height --no-reverse'
export FZF_CTRL_T_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"

# GO related:
export GOPATH=$HOME/code/go
export PATH=$PATH:~/bin/:~/.cabal/bin:$GOROOT/bin:$GOPATH/bin
export PYENV_ROOT="/usr/local/opt/pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

# JAVA
export PATH=$PATH:/opt/apache-maven-3.0.5/bin
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

export PATH="/Users/mvalkonen/.local/bin:$PATH"

export EDITOR=nvim

alias k=zkubectl

store_by_retailer() {
    cr stores list | jq --arg rid "$1" '.[] | select(.store.retailer_id == $rid)'
}
store_by_merchant() {
    cr stores list | jq --arg mid "$1" '.[] | select(.merchant.channel_merchant_id == $mid)'
}
retailer_by_name() {
    cr retailers list | jq --arg name "$1" '.[] | select(.legal_name | startswith($name))'
}
blocked_stores() {
    cr stores list | jq -r '.[] | select(.store.capacity_reached == true) | [.store.name, .store.store_configuration.order_capacity] | @csv'
}

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/mvalkonen/.sdkman"
[[ -s "/Users/mvalkonen/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/mvalkonen/.sdkman/bin/sdkman-init.sh"
