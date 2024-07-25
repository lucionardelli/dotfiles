#!/bin/bash

# Grep aliases
alias gga='ag -l'
alias ggan='ag'
alias ggp='ag --python -l'
alias ggpn='ag --python'
alias ggh='ag -G .*\.h -l'
alias gghn='ag -G .*\.h'
alias ggc='ag -G .*\.c -l'
alias ggcn='ag -G .*\.c'
alias gghpp='ag -G .*\.hpp -l'
alias gghppn='ag -G .*\.hpp'
alias ggcpp='ag --cpp -l'
alias ggcppn='ag --cpp'
alias ggsc='ag -G SC.* -l'
alias ggscn='ag -G SC.*'
alias ggdjango="ag -l --ignore={'*migrations*',}"

alias gg='ag --python --cpp --js -l'
alias ggn='ag --python --cpp --js'

# Batcat is too long!
alias bat="batcat"

# Open all references to the given term

vag() {
    ignore_test=false
    while [[ $# -gt 0 ]]; do
        case "$1" in
            -it)
                ignore_test=true
                shift
                ;;
            *)
                break
                ;;
        esac
    done

    query="$1"
    shift

    echo "$query" | xclip -rmlastnl
    files=()
    while read -r filename; do 
        if $ignore_test && [[ "$filename" == *"test"* ]]; then
            continue
        fi
        files+=("$filename")
    done < <(ag -l "$query" "$@")
    
    if [ ${#files[@]} -ne 0 ]; then
        nvim "${files[@]}"
    fi
}
# Open the result of last command in vim
# (Basically used to open files grepped with
# previus aliases)
alias vil='nvim $($(fc -ln -1))'

# Rerun last command as sudo
alias root='eval "sudo $(fc -ln -1)"'

# Docker compose
alias dc='docker-compose'

# Say something
alias say='DISPLAY=:0 spd-say -r -5 -l ES'

# Go to sleep! Turn display off.
alias gts='xset dpms force off'

# Open NeoVim for times faster!
alias v='nvim'
# vi is NeoVim now. vim is still vim
alias vi='nvim'

# Get weather report in Rosario
alias clima='curl https://wttr.in/Rosario\?lang\=es'

# Master key to open visual things
alias xopen='xdg-open'

# Life's too short! Go places!
alias o='cd $HOME/kw/OOHLA.media/oohlamedia-dev/'
alias of='cd $HOME/kw/OOHLA.media/oohlamedia-frontend/'
alias soohla='ssh oohla@oohla-dev' # DigitalOcen
alias sroohla='ssh root@oohla-dev' #DigitalOcean
alias fcoohla='ssh -p 17177 oohlamedia@45.33.18.240' # Fastcomet
alias kleene='ssh lnardelli@dcc.fceia.unr.edu.ar' # Dcc's Kleene

# FZF
alias fh='history | fzf --tac --no-sort'
alias fv='nvim `fzf`'
alias fb='bat `fzf`'

# fkill - kill proces using fzf completion
fkill() {
  local pid
  pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

  if [ "x$pid" != "x" ]
  then
    echo $pid | xargs kill -${1:-9}
  fi
}

mkcd() { mkdir -p "$1" && cd "$1"; }

# Open bash on docker image
alias dbashi='docker run --rm -it --entrypoint bash'
# Open bash on running container
dbash () {
    docker compose exec -ti "$1" bash
}
# Get docker ID from service
docker-id () {
    docker ps -f name=$1 --format "{{.ID}}"
}

# Truncate logs (not the most elegant thing to do...)
dddlog () {
    sudo sh -c ": > $(docker inspect --format='{{.LogPath}}' $(docker-id $1))"
}

# Taken from https://polothy.github.io/post/2019-08-19-fzf-git-checkout. A fuzzy finder for local git branches
fzf-git-branch() {
    git rev-parse HEAD > /dev/null 2>&1 || return

    git branch --color=always --all --sort=-committerdate |
        grep -v HEAD |
        fzf --height 50% --ansi --no-multi --preview-window right:65% \
            --preview 'git log -n 50 --color=always --date=short\
            --pretty="format:%C(auto)%cd %h%d %s" $(sed "s/.* //" <<< {})' |
        sed "s/.* //"
}

# Simple wrapper function to our previous one. It lets you select a branch and then runs git checkout for you. If you selected a remote branch, it’ll use the --track option.
fzf-git-checkout() {
    git rev-parse HEAD > /dev/null 2>&1 || return

    local branch

    branch=$(fzf-git-branch)
    if [[ "$branch" = "" ]]; then
        echo "No branch selected."
        return
    fi

    # If branch name starts with 'remotes/' then it is a remote branch. By
    # using --track and a remote branch name, it is the same as:
    # git checkout -b branchName --track origin/branchName
    if [[ "$branch" = 'remotes/'* ]]; then
        git checkout --track $branch
    else
        git checkout $branch;
    fi
}
alias gb='fzf-git-branch'
alias gco='fzf-git-checkout'
