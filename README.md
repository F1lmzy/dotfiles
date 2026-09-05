# dotfiles

Personal dotfiles, portable between macOS and Linux (Omarchy/Arch).

## Layout

- `zshrc` — Oh My Zsh config, symlinked to `~/.zshrc`. macOS-only paths are
  guarded so the same file works on both machines.
- `config/` — app configs mirroring `~/.config/<app>`. Some (yabai, skhd,
  sketchybar, nix-darwin) are macOS-only and simply unused on Linux.

## Zsh setup on a new machine

```sh
# 1. Install Oh My Zsh (keeps an existing .zshrc; we replace it with the symlink anyway)
KEEP_ZSHRC=yes RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# 2. Point .zshrc at the repo
ln -sf "$PWD/zshrc" "$HOME/.zshrc"

# 3. Install custom plugins into $ZSH_CUSTOM/plugins/ ($ZSH = ~/.oh-my-zsh)
git clone https://github.com/zsh-users/zsh-autosuggestions      "$ZSH/custom/plugins/zsh-autosuggestions"
git clone https://github.com/zsh-users/zsh-syntax-highlighting  "$ZSH/custom/plugins/zsh-syntax-highlighting"
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting "$ZSH/custom/plugins/fast-syntax-highlighting"
git clone https://github.com/marlonrichert/zsh-autocomplete      "$ZSH/custom/plugins/zsh-autocomplete"
git clone https://github.com/zsh-users/zsh-completions          "$ZSH/custom/plugins/zsh-completions"

# 4. Make zsh the login shell (add /usr/bin/zsh to /etc/shells first on Arch)
chsh -s "$(command -v zsh)"
```

> Note: `zsh-syntax-highlighting` and `fast-syntax-highlighting` are both syntax
> highlighters and are not meant to be loaded together — the config currently
> loads both; pick one and drop the other from `plugins=(...)` if you see issues.