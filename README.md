# Dotfiles

Personal development environment configuration managed with GNU Stow for consistent setup across machines.

## Overview

This repository contains my terminal-based development environment configuration, optimized for data engineering workflows and productivity. The setup emphasizes keyboard-driven efficiency, modern tooling, and reproducible environment management.

## Tech Stack

**Shell & Terminal**
- Nushell - Modern shell with structured data support
- Fish - User-friendly interactive shell
- Ghostty, Alacritty - GPU-accelerated terminal emulators
- Zellij - Terminal multiplexer

**Editors**
- Neovim - Primary code editor
- Helix - Modal editor for quick edits

**System Tools**
- Aerospace - Tiling window manager (macOS)
- Sketchybar - Custom macOS menu bar
- skhd - Hotkey daemon
- btop - System resource monitor
- Yazi - Terminal file manager

**Development Utilities**
- Starship - Cross-shell prompt
- Atuin - Shell history with sync

## Key Features

- **GNU Stow management** - Symlink-based configuration deployment
- **Modular structure** - Each tool in isolated directory
- **Cross-platform considerations** - Configurations for macOS and Linux
- **Version controlled** - Full configuration history and rollback capability

## Installation

```bash
# Clone repository
git clone https://github.com/arookieds/dotfiles.git ~/.dotfiles
cd ~/.dotfiles

# Install configurations using stow
stow nushell
stow nvim
stow alacritty
# ... repeat for desired tools
```

## Structure

```
dotfiles/
├── nushell/          # Nushell configuration & scripts
├── nvim/             # Neovim configuration
├── alacritty/        # Terminal emulator config
├── fish/             # Fish shell config
├── helix/            # Helix editor config
├── starship/         # Prompt configuration
└── ...               # Additional tool configs
```

## Status

**Active Maintenance** - Regularly updated as development environment evolves

## Use Case

This configuration supports:
- Data engineering development (Python, shell scripting)
- Infrastructure work (Kubernetes, Docker)
- Terminal-first workflow efficiency
- Rapid environment setup on new machines

---

**Note:** This repository demonstrates infrastructure-as-code principles applied to personal development environments - the same systematic approach used for production system configuration.
