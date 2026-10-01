#!/bin/sh
# Run explicitly: sh "$(chezmoi source-path)/bootstrap.sh"
# Does not install system packages, use sudo, or change your login shell.
set -eu
command -v git >/dev/null || { echo 'Install git first.' >&2; exit 1; }
command -v zsh >/dev/null || { echo 'Install zsh first.' >&2; exit 1; }
zsh_dir="${ZSH:-$HOME/.oh-my-zsh}"
if [ ! -d "$zsh_dir" ]; then
  git clone --depth 1 https://github.com/ohmyzsh/ohmyzsh.git "$zsh_dir"
fi
custom="${ZSH_CUSTOM:-$zsh_dir/custom}"
mkdir -p "$custom/plugins"
clone_plugin() {
  if [ ! -d "$custom/plugins/$1" ]; then
    git clone --depth 1 "$2" "$custom/plugins/$1"
  fi
}
clone_plugin zsh-autosuggestions https://github.com/zsh-users/zsh-autosuggestions.git
clone_plugin zsh-autocomplete https://github.com/marlonrichert/zsh-autocomplete.git
clone_plugin zsh-syntax-highlighting https://github.com/zsh-users/zsh-syntax-highlighting.git
clone_plugin zsh-completions https://github.com/zsh-users/zsh-completions.git
printf '\nShell dependencies ready. Apply configs with chezmoi apply.\n'
