# Linux dotfiles development

この文書は、Linux上でこのdotfilesリポジトリ自体を開発するときのchezmoi運用手順です。
初回セットアップ手順は`docs/usage/linux-setup.md`、通常利用と各言語の開発環境は`docs/usage/repository-guide.md`に従います。

## 前提

- chezmoiのsource directoryはこのリポジトリにします。
- package導入やVS Code拡張導入をchezmoi applyへ混ぜません。
- docs、OpenSpec、CI、devcontainer、lockfile、test scriptはchezmoi適用対象ではありません。
- 採用済み仕様を変える場合は`openspec/specs/dotfiles/spec.md`も更新します。

確認:

```bash
chezmoi source-path
chezmoi doctor
```

`chezmoi source-path`がこのリポジトリではない場合は、作業対象のsource directoryを確認してから続けます。

## 日常の編集

管理対象ファイルは、chezmoiのsource形式で編集します。

| 実体 | source file |
| --- | --- |
| `~/.config/nvim/init.lua` | `dot_config/nvim/init.lua` |
| `~/.config/tmux/tmux.conf` | `dot_config/tmux/tmux.conf` |
| `~/.zshenv` | `dot_zshenv` |
| `~/.local/bin/tmux-ide` | `dot_local/bin/tmux-ide` |

既存のhome側ファイルからsourceへ取り込む場合:

```bash
chezmoi add ~/.config/tmux/tmux.conf
chezmoi add ~/.config/nvim/init.lua
```

source側を直接編集した後、homeへ反映する前に差分を確認します。

```bash
chezmoi diff
chezmoi apply --dry-run --verbose
chezmoi apply
```

OS別ignoreやtemplateの影響を確認したい場合:

```bash
chezmoi managed --include files
chezmoi execute-template < .chezmoiignore
```

## 新規ファイル追加

homeへ配置したいpathをchezmoiの命名規則へ変換して追加します。

```bash
chezmoi add ~/.config/example/config.toml
```

scriptを追加する場合は、用途を分けます。

| 用途 | 配置 |
| --- | --- |
| 日常的に実行するCLI | `dot_local/bin/` |
| 手動メンテナンス手順 | `dot_local/script/` |
| chezmoi apply時に自動実行する処理 | 原則追加しない |

自動インストールscriptを追加したい場合は、先にdocsとOpenSpecで方針を変更します。

## ローカル専用情報

個人情報、credential、token、host固有pathはリポジトリへ入れません。

| 情報 | 置き場所 |
| --- | --- |
| Git user/email、署名設定 | `~/.gitconfig.local` |
| Vimの個人上書き | `~/.vimrc_local` |
| shellの秘密情報 | shell外部のsecret管理 |
| SSH/AWS/Azure/gcloud認証情報 | chezmoi管理外 |

コミット前に確認します。

```bash
git diff --cached
git grep -nE 'token|password|secret|credential|BEGIN .*PRIVATE KEY'
```

## 検証

リポジトリ全体の基本検証:

```bash
pnpm test
```

実commandで設定を読み込む検証:

```bash
pnpm run test:configs
```

PowerShell profile検証:

```bash
pnpm run test:powershell
```

個別に切り分ける場合:

```bash
bash -n dot_bash_profile dot_bashrc dot_config/env
zsh -n dot_config/zsh/dot_zshrc dot_config/zsh/zinit.zsh
tmux -f /dev/null -L dotfiles-check start-server \; source-file -n dot_config/tmux/tmux.conf \; kill-server
tmux -f /dev/null -L dotfiles-slim-check start-server \; source-file -n dot_config/tmux/tmux.slim.conf \; kill-server
nvim --headless "+Lazy! sync" +qa
git diff --check
```

Neovimのplugin構成を変更した場合は`dot_config/nvim/lazy-lock.json`を確認し、意図しないplugin更新が混ざっていないことを確認します。

## 環境変数の扱い

恒久的に使う環境変数は、shell startup fileか共有env設定へ寄せます。
Linuxでは`dot_zshenv`、`dot_bash_profile`、`dot_config/env`を優先し、個人環境だけの値はchezmoi管理外の`~/.env`へ置きます。

テストscriptでは、実HOMEへplugin stateや一時設定を書かないために、一時的な`HOME`やXDG環境変数を使ってよいです。
この一時環境変数は対象commandと子processだけに渡し、永続的な設定として扱いません。
mise shimが一時XDGを読んで誤動作しないよう、検証scriptは必要に応じて実体commandを解決してから一時環境を渡します。

## 反映と切り戻し

反映前:

```bash
chezmoi diff
chezmoi apply --dry-run --verbose
```

反映:

```bash
chezmoi apply
```

想定外の差分が出た場合は、home側ではなくsource側の差分を確認します。

```bash
git diff
chezmoi diff
```

切り戻しはGitの論理commit単位で行います。
作業中の未整理差分をまとめて戻す前に、ユーザー変更が混ざっていないか確認します。

## コミット前

コミット規約は`CONTRIBUTING.md`に従います。
1 commitは1つの論理変更だけにします。

推奨順:

```bash
git status --short
git diff --check
pnpm test
pnpm run test:configs
git add <files>
git-cz
```

AI agentはtaskまたはsubtaskの完了ごとにcommitし、work in progressをcommitしません。
