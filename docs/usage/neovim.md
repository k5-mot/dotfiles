# Neovim usage

NeovimはIDE用途です。
`lazy.nvim`でpluginを管理し、LSP、補完、UI、colorschemeをNeovim側へ集約します。

## 管理対象

- `dot_config/nvim/init.lua`
- `dot_config/nvim/lua/plugins/init.lua`
- `dot_config/nvim/lua/plugins/lsp.lua`
- `dot_config/nvim/lua/plugins/format.lua`
- `dot_config/nvim/lua/plugins/lint.lua`
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
nvim-lspconfigはserver default configの提供元として使い、server登録と有効化はNeovim 0.11以降の`vim.lsp.config`と`vim.lsp.enable`を使います。
deprecatedな`require('lspconfig')[server].setup()`は使いません。
LSP UIはnative LSPを基本にし、一覧表示やpreviewが必要な操作だけTelescopeへ寄せます。
`lspsaga.nvim`は使いません。

主な追加LSP keymap:

| key | action |
| --- | --- |
| `gh` | references |
| `gp` | definitions picker |
| `gy` | goto type definition |
| `gY` | type definitions picker |
| `<leader>rn` | rename |
| `<leader>ca` | code action |
| `<leader>sl` / `<leader>sc` / `<leader>sb` / `<leader>sw` | diagnostics |
| `[e` / `]e` | previous/next diagnostic |
| `[E` / `]E` | previous/next error diagnostic |
| `<leader>ci` / `<leader>co` | incoming/outgoing calls |

`<leader>o` outlineと`<A-d>` floating terminalは割り当てません。

## plugin責務

- LSP: `lsp.lua`
- formatting: `format.lua`
- lint: `lint.lua`
- completion: `completion.lua`
- UI/statusline: `statusline.lua`、`editor.lua`
- colorscheme: `colorscheme.lua`
- syntax: `syntax.lua`
- filer: `filer.lua`
- search/navigation: `telescope.lua`

plugin specの一覧は現在`plugins/init.lua`に残っています。
今後分割する場合は、上記の責務境界に合わせます。
補完は`blink.cmp`で扱い、従来の主要keymapは維持します。
emojiは補完sourceには含めず、既存のTelescope emoji pickerで扱います。
ファイラは`neo-tree.nvim`で扱います。
tablineは`barbar.nvim`を使わず、`lualine.nvim`のtablineへ統合します。
`nvim-treesitter`は`main` branchへ固定し、legacy `nvim-treesitter.configs` APIは使いません。
highlight開始はNeovim nativeの`vim.treesitter.start()`で行います。

## colorscheme

colorschemeは`catppuccin/nvim`を主設定にし、flavorはtmuxと同じ`frappe`へ固定します。
代替として`sonokai`、`onedark.vim`、`gruvbox-material`をインストールだけ残します。
その他のcolorscheme pluginはlockfile reviewと取得対象を増やすため採用しません。
`tmuxline.vim`は採用しません。
tmux statuslineはtmux側の`catppuccin/tmux`で管理します。

## formatter integration

formatは`conform.nvim`、lintは`nvim-lint`で扱います。
formatterやlinter本体のversionはproject-local toolとして管理し、Neovim plugin側へ寄せすぎない方針です。
conform.nvimへ登録するformatterは、Neovim起動時にPATH上で実行できるものだけに絞ります。
Luaで書いたNeovim設定の補助には、小規模な`lazydev.nvim`を使います。
Node、Perl、RubyのNeovim providerは使わないため無効化します。
Python providerは`pynvim`を使うため維持します。
Treesitter parser generation用の`tree-sitter` commandはmiseで管理します。
LuaRocks必須pluginを使わないため、lazy.nvimのLuaRocks supportは無効化します。

| workflow | plugin | tool解決 |
| --- | --- | --- |
| format | `conform.nvim` | project-local formatterをPATHから実行 |
| lint | `nvim-lint` | project-local linterをPATHから実行 |
| Neovim Lua補助 | `lazydev.nvim` | Neovim Lua APIの補完を補助 |

## 同期

```bash
nvim --headless "+Lazy! sync" +qa
```

更新後は`lazy-lock.json`の差分を確認します。
