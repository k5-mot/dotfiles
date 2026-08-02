# Devcontainer usage

このリポジトリのdevcontainerは、PowerShell profile検証とNode.js/pnpmによる軽量検証を実行するための開発環境です。
機能追加はdevcontainer featuresだけで行います。

## 管理対象

- `.devcontainer/devcontainer.json`

## features

- Node.js 22.22.2
- PowerShell

Dockerfileによるapt package追加は行いません。
Vim、Neovim、zsh、tmuxなど実commandでの設定読み込み検証は、GitHub Actionsまたは該当commandが入ったローカル環境で実行します。

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
devcontainer内で実行する場合は、必要なcommandがbase imageまたは別途の手動準備で利用可能なことを確認します。
