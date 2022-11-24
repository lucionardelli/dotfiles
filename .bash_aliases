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


# Open all references to the given term
vag() {
    echo $1 | xclip -rmlastnl
    vi $(ag -l "$@");
}

# Open the result of last command in vim
# (Basically used to open files grepped with
# previus aliases)
alias vil='vi $($(fc -ln -1))'

# Rerun last command as sudo
alias root='eval "sudo $(fc -ln -1)"'

# Docker compose
alias dc='docker-compose'

# Say something
alias say='DISPLAY=:0 spd-say -r -5 -l ES'

# Go to sleep! Turn display off.
alias gts='xset dpms force off'

# Open Vim twice as fast!
alias v='vi'

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
alias fv='vim `fzf`'
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

