# Vim usage

Vimは軽量編集用です。
このリポジトリではVimプラグインを採用しません。
例外的に追加してよいVimプラグインもありません。

## 管理対象

- `dot_vimrc`
- `dot_gvimrc`
- `dot_config/nvim/ginit.vim`

## 方針

- Vimは短時間の編集、remote shell、復旧作業で使います。
- IDE相当の補完、LSP、UI拡張はNeovimへ寄せます。
- `vim-plug`、`PlugInstall`、`PlugUpdate`、`PlugSnapshot`は使いません。
- colorschemeはVim同梱の`slate`を使います。
  tmuxのCatppuccin Frappe系配色と並べたときに違和感が少ない暗色基調を優先し、外部theme pluginは追加しません。

## Vim、GVim、Neovim GUIの違い

`dot_vimrc`はVim本体の主設定です。
Vim設定はtmux slim設定と同じくincludeで分割せず、`~/.vimrc`へ一本化します。
`dot_gvimrc`はGVim専用のGUI差分設定です。
`dot_config/nvim/ginit.vim`はNeovim GUI client向けで、GVimとは別物です。

このため、Vim/GVim互換設定はtmux依存ではありません。
削除する場合は、classic VimやGVimを使わないことを確認してから別途判断します。

## 確認

```bash
vim -Nu ~/.vimrc +qall
```

## ローカル上書き

個人環境だけの設定は`~/.vimrc_local`に置きます。
このファイルはchezmoi管理対象にしません。
