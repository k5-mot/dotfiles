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

Vimは軽量編集用の設定だけを管理し、プラグインは導入しません。
NeovimはIDE用途として`lazy.nvim`でLSP、補完、UI、colorschemeを管理します。

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
Python、uv、Node.js、Java、Luaに加えて、`cargo:herdr`、`npm:hunkdiff`、`npm:git-cz`もmise管理対象に含めます。

確認:

```bash
mise current
uv --version
herdr --version
hunk --version
git-cz --version
```

miseのパッチ更新はRenovateが`.github/renovate.json`に基づいてPR化します。
Renovateは`.github/workflows/renovate.yml`で毎週月曜05:00 JSTに実行します。
メジャー更新とマイナー更新は環境差分が大きいため、自動PR対象から外しています。
`lazy.nvim`、タグ固定済みzinitプラグイン、TPMプラグインもRenovateのタグ更新PR対象です。
miseの詳細は`docs/usage/mise.md`を参照します。

## 6. VimとNeovimを確認する

Vimはプラグインレスです。
設定読み込みだけを確認します。

```bash
vim -Nu ~/.config/vim/init.vim +qall
```

Neovim:

```bash
nvim --headless "+Lazy! sync" +qa
```

Neovimプラグインの更新は必要なタイミングで明示的に実行します。
通常は`lazy-lock.json`の差分をレビューできる状態で実行します。
Vimの詳細は`docs/usage/vim.md`、Neovimの詳細は`docs/usage/neovim.md`を参照します。

## 7. tmuxプラグインを導入する

tmux設定はTPM本体がない場合に自動でTPMをcloneし、プラグイン導入を実行します。
TPMプラグインは`dot_config/tmux/tmux.conf`でタグ固定し、Renovateが更新PRを作れる形にしています。
PR作成にはGitHub ActionsのPull Request作成権限、または`RENOVATE_TOKEN` secretが必要です。
tmuxの詳細は`docs/usage/tmux.md`を参照します。

```bash
tmux new-session
```

既存セッションで設定を読み直す場合:

```bash
tmux source-file ~/.config/tmux/tmux.conf
```

airgap環境やプラグイン導入を避けたい環境では、プラグインレスのslim設定を使います。
この設定はTPM、GitHub clone、xclip、外部テーマへ依存しません。

```bash
tmux -f ~/.config/tmux/tmux.slim.conf new-session
```

手動更新する場合は、tmux内で次を実行します。

- 新規導入: prefix + `I`
- 更新: prefix + `U`
- 不要プラグイン削除: prefix + `alt-u`

このリポジトリのprefixは`C-s`です。
更新後は`~/.local/share/tmux/plugins`配下の変更ではなく、`dot_config/tmux/tmux.conf`のタグ更新PRをレビューします。

復旧手順とは、更新後にtmux起動やプラグイン動作が壊れたときに、直前の固定タグへ戻せるようにする手順です。
Renovate PRならPRをrevertします。
ローカルで壊れた場合は、該当プラグインのディレクトリをバックアップ退避してから設定を読み直し、固定タグから再導入します。

```bash
plugin_dir="$HOME/.local/share/tmux/plugins/<plugin-name>"
mv "$plugin_dir" "${plugin_dir}.bak.$(date +%Y%m%d%H%M%S)"
tmux source-file ~/.config/tmux/tmux.conf
```

## 8. zinitプラグインをメンテナンスする

zinit本体は初回起動時に存在しなければcloneされます。
初期化時に毎回更新や掃除を走らせる必要はありません。
`dot_local/script/701_setup-zinit.zsh`はchezmoiの`run_` scriptではありません。
chezmoi apply時に自動実行されるものではなく、`~/.local/script/701_setup-zinit.zsh`として配置される手動メンテナンス用scriptです。

手動更新:

```zsh
zinit self-update
zinit update --all
```

手動掃除:

```zsh
zinit delete --clean
zinit cclear
zinit compile --all
```

更新タイミングは、月次またはzsh起動時のエラー、補完やプラグインの不具合を直したいときに限定します。
更新後は新しいzshを開いて、プロンプト、補完、履歴検索、autosuggestionsが動くことを確認します。

## 9. Gitローカル設定を作る

共通設定は`dot_config/git/config`で管理し、個人情報は`~/.gitconfig.local`へ分離します。
作成例は`docs/usage/gitconfig-local.example`にあります。

```bash
cp "$(chezmoi source-path)/docs/usage/gitconfig-local.example" ~/.gitconfig.local
vim ~/.gitconfig.local
```

## 10. VS Code設定の分離理由

LinuxのVS Code設定は`dot_config/Code`で、WindowsのVS Code設定は`AppData/Roaming/Code`で管理します。
VS Code本体がOSごとに参照するユーザー設定ディレクトリが異なるためです。
また、フォント、ターミナルシェル、Remote Development、Windows Terminal連携などはOS依存の値になりやすいため、同一ファイルへ無理に寄せると片方の環境で壊れやすくなります。
VS Code拡張機能は`docs/usage/vscode.md`のリストから手動導入します。

## 11. WSLでWindows側の認証情報を使う場合

必要なものだけを個別にリンクします。

```bash
cp -r /mnt/c/Users/<username>/.ssh ~/.ssh
chmod 600 ~/.ssh/*
ln -s /mnt/c/Users/<username>/.aws ~/.aws
ln -s /mnt/c/Users/<username>/.azure ~/.azure
ln -s /mnt/c/Users/<username>/AppData/Roaming/gcloud ~/.config/gcloud
```

既存ファイルを上書きする前に、リンク先と所有権を確認します。
