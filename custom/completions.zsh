autoload bashcompinit && bashcompinit

autoload -U compinit
compinit

# kubctl
source <(kubectl completion zsh)

# aws
complete -C '/usr/local/bin/aws_completer' aws

# eksctl
fpath=($fpath ~/.oh-my-zsh/custom/completion)

