# Portable Zsh, Git and Neovim

Managed with chezmoi on Ubuntu, Arch and macOS. Only these three configurations
are managed. No yt-dlp, credentials, histories, caches or binaries are included.

## New machine

Install chezmoi, Git, Zsh, Neovim >= 0.11.2, ripgrep, fd and a C compiler.
Suggested package names (verify your distro's Neovim version):

- Ubuntu: git zsh ripgrep fd-find build-essential curl unzip; install a current
  Neovim separately if apt's version is too old. `fdfind` is Ubuntu's fd name.
- Arch: chezmoi git zsh neovim ripgrep fd base-devel curl unzip.
- macOS (Homebrew): chezmoi git zsh neovim ripgrep fd; install Xcode command-line
  tools with `xcode-select --install` if not already present.
- Optional: gh, zoxide, fzf, ImageMagick, uv, Python/Jupyter/jupytext.

Once this repository has been committed and pushed to your chosen remote:

```sh
chezmoi init <repository-url>
sh "$(chezmoi source-path)/bootstrap.sh"
chezmoi diff
chezmoi apply --dry-run --verbose
chezmoi apply
nvim --headless '+Lazy! restore' +qa
```

The bootstrap only installs Oh My Zsh and four plugins, without sudo or changing
existing configs. Run it explicitly. Change your login shell separately if needed.
Neovim plugins are installed by Lazy, not stored here. Restore from lazy-lock.json
for consistent versions. Notebook features need separate Python dependencies;
image rendering requires ImageMagick and a Kitty-graphics-capable terminal.

## Daily workflow

```sh
chezmoi edit ~/.zshrc
chezmoi diff
chezmoi apply
chezmoi cd
# Review all changes, then commit and push normally.
git add .
git commit -m 'Update configuration'
git push
```

On another machine: `chezmoi git pull --rebase`, then `chezmoi diff` and
`chezmoi apply`. If an app changes a deployed file (including Lazy's lockfile),
use `chezmoi add <file>` to import that change before the next apply.

## Local settings and secrets

- ~/.config/zsh/local.zsh: optional machine-local shell overrides.
- ~/.gitconfig.local: optional identity or credential overrides, included last.
- GitHub authentication uses `gh auth git-credential` if gh exists when applying.
- macOS defaults to the Keychain credential helper.
- Linux has no shared plaintext credential helper. The migrated Ubuntu machine
  retains its previous `store` helper only in its untracked ~/.gitconfig.local.
  This preserves existing authentication but stores credentials in plaintext;
  consider replacing it with a secure helper later.
- Never add ~/.git-credentials, private keys or tokens to this source repository.

The original ~/dotfiles repository remains untouched. ~/.zshrc is now a regular
chezmoi-managed file, no longer a symlink to that old repository. Backups from
migration are under ~/.local/state/dotfiles-backups/.
