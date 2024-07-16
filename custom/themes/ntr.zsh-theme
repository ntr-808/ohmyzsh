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

PROMPT='%{$fg[cyan]%}%~%{$reset_color%} $(kube_txt)$(git_prompt_info)-> ' 

ZSH_THEME_GIT_PROMPT_PREFIX="git:%{$fg_bold[magenta]%}"
ZSH_THEME_GIT_PROMPT_BRANCH=""
ZSH_THEME_GIT_PROMPT_DIRTY="*"
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "

