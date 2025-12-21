path+=("/opt/homebrew/bin/")

. "$HOME/.atuin/bin/env"

eval "$(atuin init zsh)"

# fnm
# FNM_PATH="/opt/homebrew/opt/fnm/bin"
# if [ -d "$FNM_PATH" ]; then
#   eval "`fnm env`"
# fi

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/podman/bin:$HOME/.local/bin:$PATH"
export XDG_CONFIG_HOME="$HOME/.config"

# Added by Antigravity
export PATH="/Users/liorgefen/.antigravity/antigravity/bin:$PATH"
alias ssh_nu="/opt/homebrew/bin/nu --config $HOME/.config/nushell/config.nu --env-config $HOME/.config/nushell/env.nu"
