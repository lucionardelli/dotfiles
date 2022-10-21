# Setup fzf
# ---------

# FZF config
FZF_BASIC_OPTS="--no-mouse --height 50% -1 --reverse --multi --inline-info"
FZF_PREVIEW_OPTS="--preview='[[ \$(file --mime {}) =~ binary ]] && echo {} is a binary file || (bat --style=numbers --color=always {} || cat {}) 2> /dev/null | head -300' --preview-window='right:hidden:wrap'"
FZF_KEY_BIND="--bind 'ctrl-x:execute(xdg-open {}),ctrl-p:toggle-preview,ctrl-a:select-all+accept,alt-j:down,alt-k:up'"
FZF_DEFAULT_OPTS="${FZF_BASIC_OPTS} ${FZF_PREVIEW_OPTS} ${FZF_KEY_BIND}"

# Default command is applied to all files in git repository if in a git repository, to all non-hidden files otherwise
FZF_DEFAULT_COMMAND="git ls-files --cached --others --exclude-standard || find . -not -path '*/\.*'"

export FZF_DEFAULT_OPTS


if [[ ! "$PATH" == */home/lucio/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/lucio/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "$HOME/.fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "$HOME/.fzf/shell/key-bindings.bash"
