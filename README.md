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
chezmoi state delete-bucket --bucket=entryState
chezmoi update

### Dist-Clean
rm -rfv ~/.bash_profile ~/.bashrc ~/.cache ~/.config ~/.emacs.d ~/.gitconfig ~/.minikube ~/.npm ~/.sudo_as_admin_successful ~/.vim ~/.vimrc ~/.zcompdump ~/.zshenv ~/.zshrc ~/.local/{bin,script,state} ~/.local/share/{gem,mise,nvim,tmux,zinit}
export PROMPT="%F{green}%n%f%F{magenta}@%f%F{blue}%m%f%F{magenta}:%f%F{cyan}%~%f
%F{green}$%f "
$HOME/.local/bin/chezmoi init --apply k5-mot
```

rm -rfv ~/.bash_profile ~/.bashrc ~/.cache ~/.config ~/.emacs.d ~/.gitconfig ~/.minikube ~/.npm ~/.sudo_as_admin_successful ~/.vim ~/.vimrc ~/.zcompdump ~/.zshenv ~/.zshrc && cd ~/.local/share/chezmoi && git pull  && ~/.local/bin/chezmoi state delete-bucket --bucket=entryState && ~/.local/bin/chezmoi init && ~/.local/bin/chezmoi apply

## :bookmark_tabs: Note

Good luck!!!

## :busts_in_silhouette: Author

- [k5-mot](https://github.com/k5-mot/)

## :shield: License

Copyright (c) 2020-2022 [k5-mot](https://github.com/k5-mot/) All Rights Reserved.

[k5-mot/dotfiles](https://github.com/k5-mot/dotfiles/) is under [MIT license](https://en.wikipedia.org/wiki/MIT_License).
