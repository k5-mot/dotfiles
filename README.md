# :gear: dotfiles

## Installation

- Windows
```powershell
winget install Microsoft.PowerShell Git.Git twpayne.chezmoi
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
chezmoi init --apply "git@github.com:k5-mot/dotfiles.git"
chezmoi state delete-bucket --bucket=entryState
chezmoi update
```
- Linux
```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- -b $HOME/.local/bin
$HOME/.local/bin/chezmoi init --apply "git@github.com:k5-mot/dotfiles.git"
$HOME/.local/bin/chezmoi init --apply "https://github.com/k5-mot/dotfiles.git"

sudo chsh -s /bin/zsh

chezmoi state delete-bucket --bucket=entryState
chezmoi update

### Dist-Clean
rm -rfv ~/.bash_profile ~/.bashrc ~/.cache ~/.config ~/.emacs.d ~/.gitconfig ~/.minikube ~/.npm ~/.sudo_as_admin_successful ~/.vim ~/.vimrc ~/.zcompdump ~/.zshenv ~/.zshrc ~/.local/{bin,script,state} ~/.local/share/{gem,mise,nvim,tmux,zinit}
export PROMPT="%F{green}%n%f%F{magenta}@%f%F{blue}%m%f%F{magenta}:%f%F{cyan}%~%f
%F{green}$%f "
$HOME/.local/bin/chezmoi init --apply k5-mot
```

## :bookmark_tabs: Note

### proxy

```bash:~/.env
export PROXY_USER="<ID>"
export PROXY_PASS="<PASSWORD>"
export PROXY_HOST="<HOST>"
export PROXY_PORT="<PORT>"
export HTTP_PROXY="http://${PROXY_USER}:${PROXY_PASS}@${PROXY_HOST}:${PROXY_PORT}"
export HTTPS_PROXY="${HTTP_PROXY}"
export http_proxy="${HTTP_PROXY}"
export https_proxy="${HTTP_PROXY}"
```

## :busts_in_silhouette: Author

- [k5-mot](https://github.com/k5-mot/)

## :shield: License

Copyright (c) 2020-2022 [k5-mot](https://github.com/k5-mot/) All Rights Reserved.

[k5-mot/dotfiles](https://github.com/k5-mot/dotfiles/) is under [MIT license](https://en.wikipedia.org/wiki/MIT_License).
