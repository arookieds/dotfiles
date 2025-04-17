# Additional configs
$env.config = {
  history: {
    file_format: sqlite
    max_size: 1_000_000
    sync_on_enter: true
    isolation: false
  }
  
  buffer_editor: "hx"
  
  filesize: {
    unit: "metric"
  }

  completions: {
      case_sensitive: false
      quick: true
      partial: true
      algorithm: "prefix"
      external: {
          enable: true
          max_results: 100
          completer: null
      }
      use_ls_colors: true
  }
  
  hooks: {
    pre_prompt: [{ ||
      if (which direnv | is-empty) {
        return
      }

      direnv export json | from json | default {} | load-env
      if 'ENV_CONVERSIONS' in $env and 'PATH' in $env.ENV_CONVERSIONS {
        $env.PATH = do $env.ENV_CONVERSIONS.PATH.from_string $env.PATH
      }
    }]

    env_change: {
      PWD: [
        { ||
            if (which direnv | is-empty) {
              return
            }

            direnv export json | from json | default {} | load-env
        }
      ]
    }
  }
  
}

# def start_zellij [] {
#   if 'ZELLIJ' not-in ($env | columns) {
#     if 'ZELLIJ_AUTO_ATTACH' in ($env | columns) and $env.ZELLIJ_AUTO_ATTACH == 'true' {
#       zellij attach -c
#     } else {
#       zellij
#     }

#     if 'ZELLIJ_AUTO_EXIT' in ($env | columns) and $env.ZELLIJ_AUTO_EXIT == 'true' {
#       exit
#     }
#   }
# }

source ~/.config/nushell/env.nu
source ~/.config/nushell/atuin.nu
source ~/.cache/carapace/init.nu
source ~/.zoxide.nu

mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")

# start_zellij
