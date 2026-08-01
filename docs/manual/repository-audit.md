# Repository audit

調査日: 2026-08-02

## 採用方針

- LinuxではVim、Neovim、zshを主、bashを副、tmux、mise、git、VS Codeをchezmoiで管理する。
- WindowsではWindows Terminal、PowerShellプロファイル、VS Code、Oh My Posh設定をchezmoiで管理する。
- WindowsのPowerShell補助スクリプトは廃棄し、インストール作業は`docs/manual/windows-setup.md`へ寄せる。
- Linuxのパッケージ導入もchezmoi適用時には自動実行せず、`docs/manual/linux-setup.md`へ寄せる。
- プラグインマネージャはNeovimが`lazy.nvim`、Vimが`vim-plug`、zshが`zinit`、tmuxがTPM。
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
- `cargo:herdr`と`npm:hunkdiff`をmise管理対象に追加した。
- `package.json`の`test`を実際のJSON検証とchezmoiテンプレート検証に置き換えた。
- Neovimの`lazy-lock.json`を生成し、`telescope-packer.nvim`を削除した。
- READMEから危険なDist-Clean手順を通常導線から外し、manualへの導線を作った。

## プラグイン保守状況

### Neovim

- 管理方式: `lazy.nvim`
- 設定場所: `dot_config/nvim/lua/plugins/init.lua`
- 残課題:
  - LSP、補完、UI、colorschemeが1ファイルに集約されている。
  - Masonで必要な言語サーバーやフォーマッタの一覧が明文化されていない。

### Vim

- 管理方式: `vim-plug`
- 設定場所: `dot_config/vim/plug.vim`
- 残課題:
  - `PlugSnapshot`の運用が未定。
  - Vimを軽量編集用、NeovimをIDE用にするなどの役割分担が未記載。

### zsh

- 管理方式: `zinit`
- 設定場所: `dot_config/zsh/dot_zshrc`、`dot_config/zsh/zinit.zsh`
- 残課題:
  - `701_setup-zinit.zsh`は更新と掃除の副作用が強いため、手動メンテ用途として扱う必要がある。
  - zinitプラグインの更新タイミングが文書化されていない。

### tmux

- 管理方式: TPM
- 設定場所: `dot_config/tmux/tmux.conf`
- 残課題:
  - TPMプラグインはブランチ追従で、固定版運用ではない。
  - 更新タイミングと復旧手順が未記載。

### mise

- 管理方式: `dot_config/mise/config.toml`
- 残課題:
  - 固定したバージョンの更新頻度が未定。
  - `npm:hunkdiff`はnpmバックエンドを使うため、Node/npmまわりの制約に注意が必要。

## ドキュメント残課題

- `dot_config/vim.old`が参照用アーカイブなのか、まだ使う設定なのか未記載。
- `.chezmoiexternal.toml`が実質空で、今後使う予定があるのか不明。
- `.gitconfig.local`をincludeしているが、作成例がない。
- VS Code設定がWindows用とLinux用で分かれる理由をもう少し詳しく書ける。
