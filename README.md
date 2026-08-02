# dotfiles

## 管理対象

- Linux: Vim、Neovim、zsh、bash、tmux、mise、git、VS Code
- Windows: Windows Terminal、PowerShellプロファイル、VS Code、Oh My Posh

Vimは軽量編集用としてプラグインレスで運用し、IDE相当の補完、LSP、UI拡張はNeovimへ寄せます。

## ドキュメント

| 種別 | 文書 | 内容 |
| --- | --- | --- |
| Usage | [Repository guide](docs/usage/repository-guide.md) | 全体の使い方、開発環境、WSL、proxy |
| Usage | [Linux setup](docs/usage/linux-setup.md) | Linux初期セットアップ |
| Usage | [Windows setup](docs/usage/windows-setup.md) | Windows初期セットアップ |
| Usage | [Vim](docs/usage/vim.md) | プラグインレスVim運用 |
| Usage | [Neovim](docs/usage/neovim.md) | lazy.nvimとIDE運用 |
| Usage | [zsh](docs/usage/zsh.md) | zinit pluginと保守運用 |
| Usage | [tmux](docs/usage/tmux.md) | 通常設定、slim設定、TPM運用 |
| Usage | [mise](docs/usage/mise.md) | 固定版ツールと更新方針 |
| Usage | [VS Code](docs/usage/vscode.md) | 拡張リスト、分割settings、手動導入 |
| Usage | [Devcontainer](docs/usage/devcontainer.md) | featuresのみのPowerShell検証環境 |
| Rules | [Coding rules](docs/rules/coding-rules.md) | 言語別コーディング規約 |
| Rules | [Contributing](CONTRIBUTING.md) | GitHub Flow、commit、tag規約 |
| Spec | [OpenSpec canonical spec](openspec/specs/dotfiles/spec.md) | 採用済み仕様 |
| Glossary | [Context](CONTEXT.md) | このリポジトリの用語 |

docsは手順と規約、OpenSpecは採用済み仕様を扱います。
chezmoi適用時にパッケージ導入スクリプトを自動実行しない方針です。
OSパッケージ、PowerShellモジュール、VS Code拡張機能、miseツールの導入はusageの手順で明示的に実行します。

## Author

- [k5-mot](https://github.com/k5-mot/)

## License

Copyright (c) 2020-2022 [k5-mot](https://github.com/k5-mot/) All Rights Reserved.

[k5-mot/dotfiles](https://github.com/k5-mot/dotfiles/) is under [MIT license](https://en.wikipedia.org/wiki/MIT_License).
