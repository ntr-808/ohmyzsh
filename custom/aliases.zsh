if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

alias lg='lazygit'

# alias
alias la='ls -lah'

alias vim="nvim"
alias v="nvim"

alias k="kubectl"
alias kgp="kubectl get pods"
alias kga="kubectl get all"
alias kg="kubectl get"
alias rpkc="kubectl --namespace redpanda exec -i -t redpanda-0 -c redpanda -- rpk "
