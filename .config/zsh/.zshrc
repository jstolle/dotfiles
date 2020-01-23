source $XDG_CONFIG_HOME/antigen/antigenrc

fpath=(/usr/local/share/zsh/site-functions "${fpath[@]}")

# Pyenv
eval "$(pyenv init -)"

# NVM
[ -s /usr/local/opt/nvm/nvm.sh ] && . /usr/local/opt/nvm/nvm.sh 

alias vim=nvim

# my tmux extras
function ttl() {
  # Return immediately if not in a tmux session
  [[ -z "$TMUX" ]] && return
  newtitle=$1
  echo "\ek${newtitle}\e\\"
}

# Random password generator
function genpass () {
  for word in $($HOME/bin//diceware 5); do
    firstletter=$(echo $word | cut -c1 | gtr '[:lower:]' '[:upper:]')
    otherletters=$(echo $word | cut -c2-)
    echo -n "$firstletter$otherletters"
  done | gtr 'i' '1' | gtr 'a' '@' | gtr 'o' '0'
  echo ""
}

# Terraform execution
function tf() {
  planfilename="$(basename $(pwd)).plan"
  planfile_dir="${2:-..}/plans"
  [ -d $planfile_dir ] || { >&2 echo "Plans directory ($planfile_dir)" && return 1 }
  planfile="${planfile_dir}/${planfilename}"

  case $1 in
    plan    ) terraform plan -out=$planfile ;;
    destroy ) terraform plan -destroy -out=$planfile ;;
    init    ) terraform init ;;
    apply   ) terraform apply $planfile ;;
    val     ) terraform validate ;;
    *       ) { >&2 echo "Unknown tf operation: $1" && return 1}
  esac
}
