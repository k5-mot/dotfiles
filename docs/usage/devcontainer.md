# Devcontainer usage

このリポジトリのdevcontainerは、PowerShell profile検証とLinux系設定の実command検証を実行するための開発環境です。
機能追加はdevcontainer featuresだけで行います。

## 管理対象

- `.devcontainer/devcontainer.json`
- `.devcontainer/postCreateCommand.sh`

## features

- Node.js 22.22.2
- PowerShell
- Python 3.12
- uv
- jq
- Vim
- Neovim
- zsh
- tmux

Dockerfileによるapt package追加は行いません。
jq、Vim、Neovim、zsh、tmuxはapt package featureで導入します。
Node.js、PowerShell、Python、uvはdevcontainer featureで導入します。

## mount

devcontainerは次のcacheをvolumeとして保持します。

- Serena cache
- pnpm store
- uv cache

Codex設定は`${localEnv:HOME}/.codex`から`/home/vscode/.codex`へbind mountします。
実credential値はリポジトリへ記録しません。

## 初期化

devcontainer作成後に`postCreateCommand.sh`がCorepackを有効化し、リポジトリrootの依存関係を導入します。
rootに`package.json`がある場合は`pnpm install --frozen-lockfile`を実行します。
rootに`pyproject.toml`がある場合は`uv python install 3.12`と`uv sync --dev`を実行します。

直下のサブディレクトリにNode.jsまたはPythonプロジェクトがある場合も、検出したlockfileや設定ファイルに応じて依存関係を導入します。
Serena cacheが未作成の場合は、Serenaのproject indexも作成します。

```bash
corepack enable
bash ./.devcontainer/postCreateCommand.sh
```

## 検証

通常の軽量検証:

```bash
pnpm test
```

PowerShell profileの構文検証:

```bash
pnpm run test:powershell
```

Vim、Neovim、zsh、tmuxを実際のcommandで読み込む検証:

```bash
pnpm run test:configs
```

`test:configs`はNeovim plugin同期とzinit plugin読み込みを含むため、通常の`pnpm test`より時間がかかります。
検証scriptは実HOMEを汚さないため、一時的な`HOME`やXDG環境変数を対象commandへ渡します。
これはtest isolation用途に限り、恒久的な環境変数設定はshell startup file側で管理します。
