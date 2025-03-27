# History
export HISTSIZE=10000000
export HISTFILESIZE=$HISTSIZE
export SAVEHIST=$HISTSIZE
setopt EXTENDED_HISTORY

eval $(thefuck --alias)

# fzf settings
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix ".git" .'
export FZF_CTRL_T_COMMAND="fd --hidden --follow --exclude \".git\" ."
export FZF_DEFAULT_OPTS='--height 60% --layout=reverse --border'

function fuck() {
  thefuck $@
}

function _fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf "$@" --preview 'tree -C {} | head -200' ;;
    export|unset) fzf "$@" --preview "eval 'echo \$'{}" ;;
    ssh)          fzf "$@" --preview 'dig {}' ;;
    vim)          fzf "$@" --preview 'cat {} | head -200' ;;
    *)            fzf "$@" ;;
  esac
}

# ohmyzsh

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
  nvm
  git
  docker
  docker-compose
  npm
  fzf
  colorize
  thefuck
  aliases
)

source $ZSH/oh-my-zsh.sh

# aliases
alias node_docker="docker run -v $(pwd):/root -it node /bin/bash"

alias vim=nvim

alias test="npm run test || echo 'cant run tests'"
alias diff="git diff"
alias remove_branches="git branch | xargs git branch -D"
function commit {
  if [[ $# -eq 0 ]]; then
    return
  fi

  branch_name=$(git rev-parse --abbrev-ref HEAD | grep -oe '\w\+-\d\+')

  message=''
  if [ -z "$branch_name" ]
  then
    message=$1
  else
    message="$branch_name: $1"
  fi

  git commit -am $message
}


#
function send {
  if [[ $# -eq 0 ]]; then
    return
  fi

  git add --all
  commit $1
  git push origin HEAD
}

# capture the output of a command so it can be retrieved with ret
cap () { tee /tmp/capture.out; }

# return the output of the most recent command that was captured by cap
ret () { cat /tmp/capture.out; }

chmod +x ~/configs/git_hooks/pre-push 

function root {
  cd $(git rev-parse --show-toplevel)
}

alias reload="source ~/.zshrc"
export HOMEBREW_NO_ENV_HINTS=true

