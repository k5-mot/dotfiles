# Linux setup manual

この手順は、LinuxでVim、Neovim、zsh、bash、tmux、mise、git、VS Codeをchezmoiで管理するための手順です。
chezmoi適用時にインストール処理を自動実行せず、必要な操作を明示的に実行します。

## 管理対象

- Vim: `dot_config/vim`
- Neovim: `dot_config/nvim`
- zsh: `dot_config/zsh`、`dot_zshenv`
- bash: `dot_bashrc`、`dot_bash_profile`
- tmux: `dot_config/tmux/tmux.conf`
- mise: `dot_config/mise/config.toml`
- git: `dot_config/git/config`
- VS Code: `dot_config/Code`

## 1. 基本パッケージを入れる

Ubuntu系:

```bash
sudo apt update
sudo apt install -y bash curl git jq tmux vim zsh
```

Fedora系:

```bash
sudo dnf install -y bash curl git jq tmux vim zsh
```

## 2. chezmoiを入れる

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- -b "$HOME/.local/bin"
export PATH="$HOME/.local/bin:$PATH"
chezmoi --version
```

## 3. dotfilesを適用する

SSH鍵を設定済みの場合:

```bash
chezmoi init --apply git@github.com:k5-mot/dotfiles.git
```

SSH鍵をまだ置いていない場合:

```bash
chezmoi init --apply https://github.com/k5-mot/dotfiles.git
```

既存環境へ再適用する場合:

```bash
chezmoi update
```

## 4. zshをログインシェルにする

```bash
command -v zsh
chsh -s "$(command -v zsh)"
```

反映には再ログインが必要です。

## 5. miseを入れて固定版ツールを導入する

```bash
curl https://mise.run | sh
export PATH="$HOME/.local/bin:$PATH"
mise install
mise reshim
```

`dot_config/mise/config.toml`では`latest`を使わず、現在の基盤ツールを固定版で管理します。
追加ツールとして`cargo:herdr`と`npm:hunkdiff`もmise管理対象に含めます。

確認:

```bash
mise current
herdr --version
hunk --version
```

## 6. VimとNeovimのプラグインを導入する

Vim:

```bash
vim +PlugInstall +qall
```

Neovim:

```bash
nvim --headless "+Lazy! sync" +qa
```

更新は自動実行せず、必要なタイミングで明示的に実行します。

## 7. tmuxプラグインを導入する

tmux設定はTPM本体がない場合に自動でTPMをcloneし、プラグイン導入を実行します。

```bash
tmux new-session
```

既存セッションで設定を読み直す場合:

```bash
tmux source-file ~/.config/tmux/tmux.conf
```

## 8. WSLでWindows側の認証情報を使う場合

必要なものだけを個別にリンクします。

```bash
cp -r /mnt/c/Users/<username>/.ssh ~/.ssh
chmod 600 ~/.ssh/*
ln -s /mnt/c/Users/<username>/.aws ~/.aws
ln -s /mnt/c/Users/<username>/.azure ~/.azure
ln -s /mnt/c/Users/<username>/AppData/Roaming/gcloud ~/.config/gcloud
```

既存ファイルを上書きする前に、リンク先と所有権を確認します。
