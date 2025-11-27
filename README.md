# :gear: dotfiles

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)

[chezmoi](https://www.chezmoi.io/)で管理された個人用dotfilesリポジトリです。Windows と Linux の両方の環境に対応しています。

## :sparkles: 特徴

- **クロスプラットフォーム対応**: Windows (PowerShell) と Linux (Bash/Zsh) で動作
- **自動セットアップ**: 初回適用時に必要なパッケージとツールを自動インストール
- **柔軟なスクリプト管理**: 番号順に実行されるモジュール化されたセットアップスクリプト
- **エラーハンドリング**: 堅牢なエラー処理とチェック機能

## :package: 前提条件

### Windows
- Windows 10/11
- PowerShell 7+ (推奨)
- インターネット接続

### Linux
- Ubuntu, Debian, または互換ディストリビューション
- Bash 4.0+
- インターネット接続

## :rocket: インストール

### Windows

1. **必要なツールをインストール**
```powershell
winget install Microsoft.PowerShell Git.Git twpayne.chezmoi
```

2. **環境変数を更新**
```powershell
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
```

3. **dotfilesを適用**
```powershell
# SSH接続の場合（推奨）
chezmoi init --apply "git@github.com:k5-mot/dotfiles.git"

# HTTPS接続の場合
chezmoi init --apply "https://github.com/k5-mot/dotfiles.git"
```

4. **状態をクリーンアップして更新**
```powershell
chezmoi state delete-bucket --bucket=entryState
chezmoi update
```

### Linux (WSL含む)

1. **WSLのインストール (Windowsの場合)**
```bash
wsl --install Ubuntu
```

2. **chezmoiのインストール**
```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- -b $HOME/.local/bin
```

3. **SSH鍵の設定 (WSLの場合)**
```bash
cp -rf /mnt/c/Users/<username>/.ssh/ ~/.ssh/
chmod 600 ~/.ssh/*
```

4. **クラウド認証情報のシンボリックリンク作成 (WSLの場合、オプション)**
```bash
ln -s /mnt/c/Users/<username>/.aws/                  ~/.aws/
ln -s /mnt/c/Users/<username>/.azure/                ~/.azure/
ln -s /mnt/c/Users/<username>/AppData/Roaming/gcloud ~/.config/gcloud
```

5. **dotfilesを適用**
```bash
# SSH接続の場合（推奨）
$HOME/.local/bin/chezmoi init --apply "git@github.com:k5-mot/dotfiles.git"

# HTTPS接続の場合
$HOME/.local/bin/chezmoi init --apply "https://github.com/k5-mot/dotfiles.git"
```

6. **デフォルトシェルをzshに変更 (オプション)**
```bash
chsh -s $(which zsh)
```

7. **状態をクリーンアップして更新**
```bash
chezmoi state delete-bucket --bucket=entryState
chezmoi update
```

## :file_folder: ディレクトリ構造

```
dotfiles/
├── .chezmoi.toml.tmpl           # chezmoi設定ファイル
├── .chezmoiexternal.toml        # 外部ファイル管理
├── .chezmoiignore               # 除外ファイル設定
├── run_onchange_setup.bash.tmpl # Linux初期化スクリプト
├── run_onchange_setup.ps1.tmpl  # Windows初期化スクリプト
├── dot_bashrc                   # Bash設定
├── dot_zshenv                   # Zsh環境変数
├── dot_vimrc                    # Vim設定
├── dot_config/                  # アプリケーション設定
├── dot_local/
│   ├── bin/                     # ユーティリティスクリプト
│   └── script/                  # セットアップスクリプト
│       ├── 000_osinfo.sh        # OS情報表示
│       ├── 100_install-via-apt.sh      # APTパッケージインストール
│       ├── 101_install-docker-via-apt.sh # Docker (Linux)
│       ├── 102_install-kubernetes.sh   # Kubernetes (Linux)
│       ├── 110_install-via-winget.ps1  # Wingetパッケージインストール
│       ├── 111_install-psmodule.ps1    # PowerShellモジュール
│       ├── 112_install-fonts.ps1       # フォント
│       ├── 113_install-vscode-exts.ps1 # VS Code拡張機能
│       ├── 500_install-mise.zsh        # mise (バージョン管理)
│       ├── 600-603_*.zsh               # 言語パッケージマネージャー
│       └── 700_setup-vim.sh            # Vimプラグイン設定
├── AppData/                     # Windows用設定
└── Documents/                   # Windows用ドキュメント
    └── PowerShell/              # PowerShell設定とスクリプト
```

## :hammer_and_wrench: セットアップスクリプトについて

### スクリプト実行順序

スクリプトは `~/.local/script/` (Windows: `%USERPROFILE%\.local\script\`) に配置され、ファイル名の番号順に実行されます。

**番号規則**:
- `000-099`: システム情報と初期設定
- `100-199`: パッケージマネージャー経由のインストール
  - `100-109`: Linux (apt/dnf)
  - `110-119`: Windows (winget/PowerShell)
- `500-599`: ランタイムバージョン管理ツール
- `600-699`: 言語固有のパッケージマネージャー
- `700-799`: アプリケーション固有の設定

### 初期化スクリプトの動作

**Linux (`run_onchange_setup.bash.tmpl`)**:
- `~/.local/script/` 内の `.sh` と `.zsh` スクリプトを実行
- エラー時に自動停止 (`set -e`)
- zshが未インストールの場合は `.zsh` スクリプトをスキップ

**Windows (`run_onchange_setup.ps1.tmpl`)**:
- `%USERPROFILE%\.local\script\` 内の `.ps1` スクリプトを実行
- 番号順にソートして実行
- エラー時に自動停止 (`$ErrorActionPreference = "Stop"`)

## :wrench: カスタマイズ

### 独自のセットアップスクリプトを追加

1. `dot_local/script/` に新しいスクリプトを作成
2. ファイル名を番号で始める（例: `150_custom-setup.sh`）
3. 実行権限を付与（Linux: `chmod +x`）

### プロキシ設定

プロキシ環境下で使用する場合は、`~/.env` に以下を設定:

```bash
export PROXY_USER="<ID>"
export PROXY_PASS="<PASSWORD>"
export PROXY_HOST="<HOST>"
export PROXY_PORT="<PORT>"
export HTTP_PROXY="http://${PROXY_USER}:${PROXY_PASS}@${PROXY_HOST}:${PROXY_PORT}"
export HTTPS_PROXY="${HTTP_PROXY}"
export http_proxy="${HTTP_PROXY}"
export https_proxy="${HTTP_PROXY}"
```

## :recycle: 完全クリーンインストール (Linux)

既存の設定を完全に削除して再インストールする場合:

```bash
# 既存ファイルを削除
rm -rfv ~/.bash_profile ~/.bashrc ~/.cache ~/.config ~/.emacs.d \
        ~/.gitconfig ~/.minikube ~/.npm ~/.sudo_as_admin_successful \
        ~/.vim ~/.vimrc ~/.zcompdump ~/.zshenv ~/.zshrc \
        ~/.local/{bin,script,state} \
        ~/.local/share/{gem,mise,nvim,tmux,zinit}

# 一時的なプロンプトを設定
export PROMPT="%F{green}%n%f%F{magenta}@%f%F{blue}%m%f%F{magenta}:%f%F{cyan}%~%f
%F{green}$%f "

# 再インストール
$HOME/.local/bin/chezmoi init --apply k5-mot
```

## :bug: トラブルシューティング

### WSL初回インストール時の流れ

```powershell
wsl --install Ubuntu
# ダウンロードしています: Ubuntu
# インストールしています: Ubuntu
# ディストリビューションが正常にインストールされました。
# Ubuntu を起動しています...
# Provisioning the new WSL instance Ubuntu
# This might take a while...
# Create a default Unix user account: user
# New password:
# Retype new password:
# passwd: password updated successfully
```

### よくある問題

**スクリプトが実行されない (Linux)**
- 実行権限を確認: `chmod +x ~/.local/script/*.sh`
- shebangが正しいか確認

**スクリプトが実行されない (Windows)**
- 実行ポリシーを確認: `Get-ExecutionPolicy`
- 必要に応じて変更: `Set-ExecutionPolicy RemoteSigned -Scope CurrentUser`

**chezmoiコマンドが見つからない**
- PATHを確認
  - Linux: `export PATH=$HOME/.local/bin:$PATH`
  - Windows: 環境変数の更新が必要な場合がある

## :bookmark_tabs: 関連リンク

- [chezmoi公式ドキュメント](https://www.chezmoi.io/)
- [PowerShell公式ドキュメント](https://docs.microsoft.com/powershell/)
- [Bash リファレンス](https://www.gnu.org/software/bash/manual/)

## :busts_in_silhouette: Author

- [k5-mot](https://github.com/k5-mot/)

## :shield: License

Copyright (c) 2020-2025 [k5-mot](https://github.com/k5-mot/) All Rights Reserved.

[k5-mot/dotfiles](https://github.com/k5-mot/dotfiles/) is under [MIT license](https://en.wikipedia.org/wiki/MIT_License).
