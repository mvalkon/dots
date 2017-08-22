

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
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# JAVA 
export PATH=$PATH:/opt/apache-maven-3.0.5/bin
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
