# oh-my-zsh
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="eastwood-update"
zstyle ':omz:update' mode auto
zstyle ':omz:update' frequency 1
COMPLETION_WAITING_DOTS="true"
source $ZSH/oh-my-zsh.sh
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/podman/bin:$HOME/.local/bin:$HOME/.zfunc:$PATH"

# Starship
setopt prompt_subst
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
autoload bashcompinit && bashcompinit
autoload -Uz compinit
compinit
source <(kubectl completion zsh)
complete -C '/usr/local/bin/aws_completer' aws

# ZSH
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Starship
eval "$(starship init zsh)"
export STARSHIP_CONFIG=~/.config/starship/starship.toml

# Exports
export LANG=en_US.UTF-8
export EDITOR="/usr/local/bin/hx"
# Aliases
alias kubectl="minikube kubectl --"
alias k="minikube kubectl --"
alias java="asdf exec java"
alias scala"asdf exec scala"
alias zls="zellij list-sessions"
alias zla="zellij list-aliases"
alias zr="zellij run --"
alias zrf="zellij run --close-on-exit -f --"


# Credentials
source ~/.cred/credentials

## ZelliJ
# if [[ -z "$ZELLIJ" ]]; then
#     if [[ "$ZELLIJ_AUTO_ATTACH" == "true" ]]; then
#         zellij attach -c
#     else
#         zellij attach general
#     fi

#     if [[ "$ZELLIJ_AUTO_EXIT" == "true" ]]; then
#         exit
#     fi
# fi


export XDG_CONFIG_HOME="$HOME/.config"

## direnv
. "$HOME/.atuin/bin/env"

eval "$(direnv hook zsh)"
eval "$(atuin init zsh)"
eval "$(zoxide init zsh)"
source <(fzf --zsh)
