function tf_prompt_info() {
    # dont show 'default' workspace in home dir
    [[ "$PWD" == ~ ]] && return
    # check if in terraform dir
    if [ -d .terraform ]; then
      workspace=$(terraform workspace show 2> /dev/null) || return
      echo "[${workspace}]"
    fi
}

# Terraform execution
function _get_planfile() {
  planfilename="$(basename $(pwd)).plan"
  planfile_dir="$PWD/../plans"
  if [ -d $planfile_dir ]; then
    echo "${planfile_dir}/${planfilename}"
  else
    echo "$planfilename"
  fi
}

function _terraform_plan() {
  terraform plan -out=$(_get_planfile)
}
function _terraform_destroy() {
  terraform plan -destroy -out=$(_get_planfile)
}
function _terraform_apply() {
  terraform apply $(_get_planfile)
}

alias tfp='_terraform_plan'
alias tfd='_terraform_destroy'
alias tfi='terraform init'
alias tfa='_terraform_apply'
alias tfv='terraform validate'
alias tfim='terraform import'
alias tfw='terraform workspace'
alias tfwl='terraform workspace list'
alias tfwn='terraform workspace new'
alias tfws='terraform workspace select'
alias tfwd='terraform workspace delete'
alias tfs='terraform state'
alias tfsl='terraform state list'
alias tfss='terraform state show'
alias tfsrm='terraform state rm'
