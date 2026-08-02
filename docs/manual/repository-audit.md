# Repository audit

調査日: 2026-08-02

## 採用方針

- LinuxではVim、Neovim、zshを主、bashを副、tmux、mise、git、VS Codeをchezmoiで管理する。
- WindowsではWindows Terminal、PowerShellプロファイル、VS Code、Oh My Posh設定をchezmoiで管理する。
- WindowsのPowerShell補助スクリプトは廃棄し、インストール作業は`docs/manual/windows-setup.md`へ寄せる。
- Linuxのパッケージ導入もchezmoi適用時には自動実行せず、`docs/manual/linux-setup.md`へ寄せる。
- プラグインマネージャはNeovimが`lazy.nvim`、zshが`zinit`、tmuxがTPM。
- Vimは軽量編集用としてプラグインレスにする。
- miseは`latest`を使わず固定版で管理し、`herdr`と`hunk`を追加する。

## 対応済み

- Windows用`run_onchange_setup.ps1.tmpl`とPowerShell補助スクリプトを削除した。
- PowerShellプロファイルは最小構成へ寄せ、未導入モジュールを読み飛ばす形にした。
- Linux用`run_onchange_setup.bash.tmpl`を削除し、chezmoi適用時の一括インストール副作用を止めた。
- zshの`zplug` fallbackを削除し、`zinit`だけを採用した。
- zshの`compinit`重複呼び出しを解消した。
- tmux設定内でTPMを自動導入するようにした。
- tmuxのresurrect/continuum設定に対応するプラグインを一覧へ追加した。
- miseのツール指定から`latest`と`stable`を外し、現在利用中の版へ固定した。
- `uv`、`cargo:herdr`、`npm:hunkdiff`、`npm:git-cz`をmise管理対象に追加した。
- `package.json`の`test`を実際のJSON検証とchezmoiテンプレート検証に置き換えた。
- Neovimの`lazy-lock.json`を生成し、`telescope-packer.nvim`を削除した。
- READMEから危険なDist-Clean手順を通常導線から外し、manualへの導線を作った。
- Vimをプラグインレスへ変更し、`vim-plug`設定と旧Vim設定アーカイブを削除した。
- NeovimのMason導入対象にPython、Node.js、Java、Lua向けのLSPを明記した。
- tmuxプラグインをタグ固定し、Renovateのcustom regex managerとGitHub Actionsで更新PR化できるようにした。
- `lazy.nvim`とタグ固定済みzinitプラグインをRenovateの更新PR対象に追加した。
- airgap向けにプラグインレスの`dot_config/tmux/tmux.slim.conf`を追加した。
- miseのパッチ更新をRenovateとGitHub ActionsでPR化できるようにした。
- GitHub ActionsでJSON、TOML、chezmoiテンプレート、shell、tmux、PowerShellプロファイルを検証するようにした。
- `.gitconfig.local`の作成例を`docs/manual/gitconfig-local.example`に追加した。
- リポジトリの使い方と開発環境セットアップを`docs/manual/repository-guide.md`へまとめた。
- Python/TypeScript/Java/Bashの強制ルールを`docs/manual/coding-rules.md`へまとめた。
- GitHub Flow、commit、tagの開発規約を`contributing.md`へまとめた。

## プラグイン保守状況

### Neovim

- 管理方式: `lazy.nvim`
- 設定場所: `dot_config/nvim/lua/plugins/init.lua`
- 対応:
  - Masonで`pyright`、`ts_ls`、`eslint`、`jdtls`、`lua_ls`を導入対象に含めた。
  - Python、Node.js、Java、Lua本体はmiseで固定版管理する。
  - `lazy.nvim` bootstrapのタグをRenovateで更新PR化できるようにした。
- 残課題:
  - LSP、補完、UI、colorschemeが1ファイルに集約されている。

### Vim

- 管理方式: プラグインレス
- 設定場所: `dot_config/vim`
- 対応:
  - `dot_config/vim/plug.vim`と`dot_config/vim/plugin`を削除した。
  - `dot_config/vim.old`を削除した。
  - Vimは軽量編集用、NeovimはIDE用としてREADMEとLinux manualへ明記した。
  - `PlugSnapshot`はvim-plugで現在のプラグインリビジョン一覧をスナップショットとして保存し、後で同じ状態へ戻すためのコマンド。Vimをプラグインレス化したため、このリポジトリでは不要。
- 残課題:
  - なし。

### zsh

- 管理方式: `zinit`
- 設定場所: `dot_config/zsh/dot_zshrc`、`dot_config/zsh/zinit.zsh`
- 対応:
  - 初回起動時にzinit本体をcloneするフローは維持した。
  - 更新と掃除は手動メンテナンスとして`docs/manual/linux-setup.md`に記載した。
  - 更新タイミングは月次または不具合対応時に限定した。
  - タグがあるzinit本体と一部プラグインを`ice ver`で固定し、Renovate更新PR対象にした。
- 残課題:
  - タグが無いzinitプラグインはタグ更新PR対象にできないため、必要ならcommit pinning方針を別途決める。

### tmux

- 管理方式: TPM
- 設定場所: `dot_config/tmux/tmux.conf`
- 対応:
  - TPMプラグインをタグ固定した。
  - Renovateのcustom regex managerと`.github/workflows/renovate.yml`でTPMプラグインタグの更新PRを作れるようにした。
  - 手動更新タイミングと復旧手順を`docs/manual/linux-setup.md`に記載した。
  - 復旧手順とは、更新後にtmux起動やプラグイン動作が壊れた場合、直前の固定タグへ戻すかローカルの壊れたプラグインディレクトリをバックアップ退避して固定タグから再導入する手順を指す。
  - airgap向けの`dot_config/tmux/tmux.slim.conf`を追加した。
- 残課題:
  - TPM本体の初回cloneはネットワーク依存のため、オフライン環境では手動準備が必要。

### mise

- 管理方式: `dot_config/mise/config.toml`
- 対応:
  - `uv`、`java`、`npm:git-cz`を追加した。
  - Renovateのmise managerと`.github/workflows/renovate.yml`でパッチ更新だけをPR化する設定を追加した。
  - `package.json`は標準の`packageManager`へ寄せ、npm系バックエンドが`devEngines`で失敗しないようにした。
- 残課題:
  - `npm:hunkdiff`と`npm:git-cz`はNode/npmバックエンドに依存するため、`node`更新PRでは動作確認が必要。

## ドキュメント残課題

- `dot_config/vim.old`は不要なため削除した。
- `.chezmoiexternal.toml`は将来の外部依存予約ファイルとして残し、ファイル先頭に英語コメントを追加した。
- `.gitconfig.local`の作成例を追加した。
- VS Code設定をWindows用とLinux用で分ける理由をLinux/Windows manualへ追記した。

## 全体的な指摘事項

- GitHub Actionsで設定検証を自動化した。
