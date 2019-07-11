# Avoid removing everything when using https://github.com/lucionardelli/dotfiles repo

function git {
  unset -f git
  GDIR=$(git rev-parse --show-toplevel)
  if [[ "$GDIR" == "$HOME" &&  "$1" == "clean" ]]; then
	echo "WTF!? Are you crazy! You can't possibly want to do that here!"
  else
    command git "$@"
  fi
}

