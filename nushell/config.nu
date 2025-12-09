# Additional configs
$env.config = {
  history: {
    file_format: sqlite
    max_size: 1_000_000
    sync_on_enter: true
    isolation: false
  }

  edit_mode: "vi"
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

use std/config *

# Initialize the PWD hook as an empty list if it doesn't exist
$env.config.hooks.env_change.PWD = $env.config.hooks.env_change.PWD? | default []

$env.config.hooks.env_change.PWD ++= [{||
  if (which direnv | is-empty) {
    # If direnv isn't installed, do nothing
    return
  }

  direnv export json | from json | default {} | load-env
  # If direnv changes the PATH, it will become a string and we need to re-convert it to a list
  $env.PATH = do (env-conversions).path.from_string $env.PATH
}]

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

# ASDF
let shims_dir = (
  if ( $env | get --optional ASDF_DATA_DIR | is-empty ) {
    $env.HOME | path join '.asdf'
  } else {
    $env.ASDF_DATA_DIR
  } | path join 'shims'
)
$env.PATH = ( $env.PATH | split row (char esep) | where { |p| $p != $shims_dir } | prepend $shims_dir )

let asdf_data_dir: string = (
  if ( $env | get --optional ASDF_DATA_DIR | is-empty ) {
    $env.HOME | path join '.asdf'
  } else {
    $env.ASDF_DATA_DIR
  }
)

let asdf_data_dir = (
  if ( $env | get --optional ASDF_DATA_DIR | is-empty ) {
    $env.HOME | path join '.asdf'
  } else {
    $env.ASDF_DATA_DIR
  }
)

source "~/.asdf/completions/nushell.nu"
source $"($nu.home-path)/.cargo/env.nu"
