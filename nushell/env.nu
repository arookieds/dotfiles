def create_left_prompt [] {
    let dir = match (do --ignore-errors { $env.PWD | path relative-to $nu.home-path }) {
        null => $env.PWD
        '' => '~'
        $relative_pwd => ([~ $relative_pwd] | path join)
    }

    let path_color = (if (is-admin) { ansi red_bold } else { ansi green_bold })
    let separator_color = (if (is-admin) { ansi light_red_bold } else { ansi light_green_bold })
    let path_segment = $"($path_color)($dir)"

    $path_segment | str replace --all (char path_sep) $"($separator_color)(char path_sep)($path_color)"
}

def create_right_prompt [] {
    # create a right prompt in magenta with green separators and am/pm underlined
    let time_segment = ([
        (ansi reset)
        (ansi magenta)
        (date now | format date '%x %X') # try to respect user's locale
    ] | str join | str replace --regex --all "([/:])" $"(ansi green)${1}(ansi magenta)" |
        str replace --regex --all "([AP]M)" $"(ansi magenta_underline)${1}")

    let last_exit_code = if ($env.LAST_EXIT_CODE != 0) {([
        (ansi rb)
        ($env.LAST_EXIT_CODE)
    ] | str join)
    } else { "" }

    ([$last_exit_code, (char space), $time_segment] | str join)
}

# $env.ZELLIJ_AUTO_ATTACH = true
# $env.ZELLIJ_AUTO_EXIT = false

# Use nushell functions to define your right and left prompt
$env.PROMPT_COMMAND = {|| create_left_prompt }
# FIXME: This default is not implemented in rust code as of 2023-09-08.
$env.PROMPT_COMMAND_RIGHT =  {|| create_right_prompt }

# The prompt indicators are environmental variables that represent
# the state of the prompt
$env.PROMPT_INDICATOR = {|| "> " }
$env.PROMPT_INDICATOR_VI_INSERT = {|| ": " }
$env.PROMPT_INDICATOR_VI_NORMAL = {|| "> " }
$env.PROMPT_MULTILINE_INDICATOR = {|| "::: " }

# Docker socker
$env.DOCKER_HOST = "unix:///var/folders/2j/hh70xwld7fz97ycq2c06_wcw0000gn/T/podman/podman-machine-default-api.sock"

$env.STARSHIP_CONFIG = $"($env.HOME)/.config/starship/starship.toml"

$env.PATH = [
  "/usr/local/bin"
  "/opt/homebrew/bin"
  "/usr/bin"
  "/bin"
  "/usr/sbin"
  "/sbin"
  "/opt/podman/bin"
  $"($env.HOME)/.cargo/bin"
  $"($env.HOME)/.rye/shims"
  $"($env.HOME)/.atuin/bin"
  $"($env.HOME)/.local/bin"
]

$env.XDG_CONFIG_HOME = $"($env.HOME)/.config"

# Aliases
alias l = ls -sam
alias ll = ls -saml
alias zls = zellij list-sessions
alias zla = zellij list-aliases

$env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense' # optional
mkdir ~/.cache/carapace
carapace _carapace nushell | save --force ~/.cache/carapace/init.nu

zoxide init nushell | save -f ~/.zoxide.nu
