# Setup fzf
# ---------
if [[ ! "$PATH" == */home/lnardelli/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/lnardelli/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/lnardelli/.fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/home/lnardelli/.fzf/shell/key-bindings.bash"
