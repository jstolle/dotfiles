# my tmux extras
#
function ttitle() {
  # Return immediately if not in a tmux session
  [[ -z "$TMUX" ]] && return
  newtitle=$1
  echo "\ek${newtitle}\e\\"
}
