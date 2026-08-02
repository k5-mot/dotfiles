# Vim usage

Vimは軽量編集用です。
このリポジトリではVimプラグインを採用しません。
例外的に追加してよいVimプラグインもありません。

## 管理対象

- `dot_config/vim/init.vim`
- `dot_config/vim/common/`
- `dot_vimrc`
- `dot_gvimrc`
- `dot_config/nvim/ginit.vim`

## 方針

- Vimは短時間の編集、remote shell、復旧作業で使います。
- IDE相当の補完、LSP、UI拡張はNeovimへ寄せます。
- `vim-plug`、`PlugInstall`、`PlugUpdate`、`PlugSnapshot`は使いません。

## Vim、GVim、Neovim GUIの違い

`dot_config/vim/init.vim`はVim本体の主設定です。
`dot_vimrc`は古いVimやpluginが`~/.vimrc`だけを見る場合の互換入口で、Vimの主設定を読み込ませるために残します。
`dot_gvimrc`はGVim専用のGUI設定です。
`dot_config/nvim/ginit.vim`はNeovim GUI client向けで、GVimとは別物です。

このため、Vim/GVim互換設定はtmux依存ではありません。
削除する場合は、classic VimやGVimを使わないことを確認してから別途判断します。

## 確認

```bash
vim -Nu ~/.config/vim/init.vim +qall
```

## ローカル上書き

個人環境だけの設定は`~/.vimrc_local`に置きます。
このファイルはchezmoi管理対象にしません。
