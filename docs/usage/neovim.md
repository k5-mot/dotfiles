# Neovim usage

NeovimはIDE用途です。
`lazy.nvim`でpluginを管理し、LSP、補完、UI、colorschemeをNeovim側へ集約します。

## 管理対象

- `dot_config/nvim/init.lua`
- `dot_config/nvim/lua/plugins/init.lua`
- `dot_config/nvim/lua/plugins/lsp.lua`
- `dot_config/nvim/lua/plugins/completion.lua`
- `dot_config/nvim/lua/plugins/colorscheme.lua`
- `dot_config/nvim/lua/plugins/statusline.lua`
- `dot_config/nvim/lua/plugins/editor.lua`
- `dot_config/nvim/lua/plugins/syntax.lua`
- `dot_config/nvim/lua/plugins/filer.lua`
- `dot_config/nvim/lua/plugins/telescope.lua`
- `dot_config/nvim/lazy-lock.json`

## lazy.nvim bootstrap

`lazy.nvim`本体のbootstrap tagは`dot_config/nvim/lua/plugins/init.lua`で固定します。
このtagはRenovateの更新PR対象です。

`lazy-lock.json`はNeovim plugin解決結果のlockfileです。
Renovate対象はbootstrap tagだけとし、`lazy-lock.json`は手動で`Lazy sync`した差分をレビューします。

## LSP

Masonの導入対象は`dot_config/nvim/lua/plugins/lsp.lua`で管理します。
Python、Node.js/TypeScript、Java、Lua向けのLSPをNeovim側で扱います。

## plugin責務

- LSP: `lsp.lua`
- completion: `completion.lua`
- UI/statusline: `statusline.lua`、`editor.lua`
- colorscheme: `colorscheme.lua`
- syntax: `syntax.lua`
- filer: `filer.lua`
- search/navigation: `telescope.lua`

plugin specの一覧は現在`plugins/init.lua`に残っています。
今後分割する場合は、上記の責務境界に合わせます。

## colorscheme

colorschemeは`sonokai`を主設定にします。
代替として`onedark.vim`と`gruvbox-material`だけを残します。
その他のcolorscheme pluginはlockfile reviewと取得対象を増やすため採用しません。

## formatter integration

`none-ls.nvim`、`none-ls-extras.nvim`、`prettier.nvim`は、formatterをNeovimから呼び出すための候補として維持します。
formatterやlinter本体のversionはproject-local toolとして管理し、Neovim plugin側へ寄せすぎない方針です。

## 同期

```bash
nvim --headless "+Lazy! sync" +qa
```

更新後は`lazy-lock.json`の差分を確認します。
