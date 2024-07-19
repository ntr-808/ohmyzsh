kubectx_mapping["kind-kind"]="local"
kubectx_mapping["arn:aws:eks:ap-southeast-2:077786784673:cluster/dc-test"]="dc-test"
# kubectx_mapping["context_name_from_kubeconfig"]="$emoji[wolf_face]"
# kubectx_mapping["production_cluster"]="%{$fg[yellow]%}prod!%{$reset_color%}

kube_txt() {
  if rg -qs '(apiVersion: |kind: |metadata: )' --pre-glob='*.{yaml,yml}' --max-depth 1 .; then
    ctx=$(kubectx_prompt_info)
    if [[ -n ctx ]]; then
      echo "k8s:%{$fg_bold[red]%}${ctx}%{$reset_color%} "
    else
      echo ""
    fi
  else
    echo ""
  fi
}

parse_git_dirty() {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit, working tree clean" ]] && echo "*"
}

shorten_git_branch() {
  local branch_name="$1"
  if [[ ${#branch_name} -gt 20 ]]; then
    local shortened="${branch_name:0:20}"
    local rest="${branch_name:20}"
    local index=$(echo "$rest" | grep -bo '-' | head -n1 | cut -d: -f1)
    if [[ -n "$index" ]]; then
      echo "${branch_name:0:20+index}"
    else
      echo "$shortened..."
    fi
  else
    echo "$branch_name"
  fi
}

parse_git_branch() {
  if git rev-parse --is-inside-work-tree &> /dev/null; then
    local branch=$(git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')
    echo "git:%{$fg_bold[magenta]%}$(shorten_git_branch $branch)$(parse_git_dirty)%{$reset_color%} "
  else
    echo ""
  fi
}

PROMPT='%{$fg_bold[green]%}%~%{$reset_color%} $(kube_txt)$(parse_git_branch)-> ' 

