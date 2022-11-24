# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac


# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth
# append to the history file, don't overwrite it
shopt -s histappend
# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
export HISTSIZE=
export HISTFILESIZE=
# Show date-time on history command
export HISTTIMEFORMAT="[%d/%m/%y %T]    "
# Change the history file location
export HISTFILE=~/.bash_eternal_history
# Ignore usual commands
HISTIGNORE='ls:bg:fg:history:s:b'

# Force prompt to write history after every command.
# http://superuser.com/questions/20900/bash-history-loss
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"
shopt -s histappend
stophistory () {
  PROMPT_COMMAND="bash_prompt_command"
  echo 'History recording stopped. Make sure to `kill -9 $$` at the end of the session.'
}

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alFtrBh --group-directories-first'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Tell ls to be colourful
export CLICOLOR=1
export LSCOLORS=Exfxcxdxbxegedabagacad

# Necessary to use brewst-sdk
if [ -f ~/.bash_irobot ]; then
    source ~/.bash_irobot
fi
if [ -f ~/.bash_ahs ]; then
    source ~/.bash_ahs
fi

export EDITOR=vim
export VISUAL=vim

# added by Miniconda3 4.3.21 installer
#export PATH="/usr/local/lib/miniconda3/bin:$PATH"

# Automagically activate conda environment if folder has a .condaauto with
# the name of the environment to activate
if [ -e /usr/local/etc/conda_auto_activate.sh ]
then
    source /usr/local/etc/conda_auto_activate.sh
fi


if [ -e ~/.local/bin/virtualenvwrapper_lazy.sh ]
then
    export WORKON_HOME=$HOME/.virtualenvs
    export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
    export VIRTUALENVWRAPPER_VIRTUALENV=$HOME/.local/bin/virtualenv
    source ~/.local/bin/virtualenvwrapper_lazy.sh
fi

# Change directories without cd
shopt -s autocd

# PS1 prompt color vars
export PROMPT_DIRTRIM='2' #only works with bash 4.x
if [ -f ~/.bash_ps1 ]; then
    # Advanced PS1, two lines
    source ~/.bash_ps1
else
    BOLD="\[\033[1m\]"
    RED="\[\033[1;31m\]"
    YELLOW="\[\033[0;33m\]"
    GREEN="\[\033[0;32m\]"
    WHITE="\[\033[0;37m\]"
    PURPLE="\[\033[1;35m\]"
    BLUE="\[\033[0;34m\]"
    OFF="\[\033[m\]"

    # Simple PS1
    PS1='\w\[\033[0;32m\]$( git branch 2> /dev/null | cut -f2 -d\* -s | sed "s/^ / [/" | sed "s/$/]/" )\[\033[0m\] \$ '

fi

# Activate git automcompletion
if [ -f /usr/share/bash-completion/completions/git ]; then
    source /usr/share/bash-completion/completions/git
fi

# Use this utility script to allow nvm to be load in a "lazy" fashion.
[ -s ~/.lazyload_nvm.sh ] && source ~/.lazyload_nvm.sh  # This loads nvm

# Avoid removing everything when using https://github.com/lucionardelli/dotfiles repo
[ -s ~/.git_clean.sh ] && source ~/.git_clean.sh

# Because vi is great!
set -o vi
# But we still want to be able to clear screen with Crtl+L
bind -m vi-insert "\C-l":clear-screen
bind -m vi-command "\C-l":clear-screen

# Defines the following keybingings
#   CTRL-T - Paste the selected file path into the command line
#   CTRL-R - Paste the selected command from history into the command line
#   ALT-C - cd into the selected directory
[ -s ~/.fzf/fzfrc ] && source ~/.fzf/fzfrc


# Add GO to the User's path
export PATH=$PATH:/usr/local/go/bin
