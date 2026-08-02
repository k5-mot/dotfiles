# :gear: dotfiles

## 管理対象

- Linux: Vim、Neovim、zsh、bash、tmux、mise、git、VS Code
- Windows: Windows Terminal、PowerShellプロファイル、VS Code、Oh My Posh

Vimは軽量編集用としてプラグインレスで運用し、IDE相当の補完、LSP、UI拡張はNeovimへ寄せます。

## セットアップ

- [Linux setup](docs/manuals/linux-setup.md)
- [Windows setup](docs/manuals/windows-setup.md)
- [Repository guide](docs/manuals/repository-guide.md)
- [Coding rules](docs/rules/coding-rules.md)
- [Contributing](docs/rules/contributing.md)
- [Repository audit](docs/manuals/repository-audit.md)

chezmoi適用時にパッケージ導入スクリプトを自動実行しない方針です。
OSパッケージ、PowerShellモジュール、VS Code拡張機能、miseツールの導入はmanualの手順で明示的に実行します。

## :bookmark_tabs: Note


```powershell
 wsl --install Ubuntu
ダウンロードしています: Ubuntu
インストールしています: Ubuntu
ディストリビューションが正常にインストールされました。'wsl.exe -d Ubuntu' を使用して起動できます
Ubuntu を起動しています...
Provisioning the new WSL instance Ubuntu
This might take a while...
Create a default Unix user account: user
New password:
Retype new password:
passwd: password updated successfully
To run a command as administrator (user "root"), use "sudo <command>".
See "man sudo_root" for details.

user@host:/mnt/c/Users/user$

```

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
