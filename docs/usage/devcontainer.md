# Devcontainer usage

このリポジトリのdevcontainerは、PowerShell profile検証とLinux系設定の実command検証を実行するための開発環境です。
機能追加はdevcontainer featuresだけで行います。

## 管理対象

- `.devcontainer/devcontainer.json`

## features

- Node.js 22.22.2
- PowerShell
- jq
- Vim
- Neovim
- zsh
- tmux

Dockerfileによるapt package追加は行いません。
jq、Vim、Neovim、zsh、tmuxはapt package featureで導入します。

## 初期化

devcontainer作成後にCorepackを有効化し、pnpm依存関係を導入します。

```bash
corepack enable
pnpm install --frozen-lockfile
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
