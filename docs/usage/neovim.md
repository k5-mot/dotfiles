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
LSP UIは`lspsaga.nvim`を使い、標準LSP keymapと衝突しにくい割り当てにします。

主なLspsaga keymap:

| key | action |
| --- | --- |
| `gh` | finder |
| `gd` | goto definition |
| `gp` | peek definition |
| `gy` | goto type definition |
| `gY` | peek type definition |
| `<leader>rn` | rename |
| `<leader>ca` | code action |
| `<leader>sl` / `<leader>sc` / `<leader>sb` / `<leader>sw` | diagnostics |
| `[e` / `]e` | previous/next diagnostic |
| `[E` / `]E` | previous/next error diagnostic |
| `<leader>ci` / `<leader>co` | incoming/outgoing calls |
| `<leader>o` | outline |
| `<A-d>` | floating terminal |

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
`nvim-treesitter`は`master` branchへ固定します。
現行の`syntax.lua`は`nvim-treesitter.configs`を使うため、互換性のない`main` branch rewriteへは設定移行と同時に切り替えます。

## colorscheme

colorschemeは`catppuccin/nvim`を主設定にします。
代替として`sonokai`、`onedark.vim`、`gruvbox-material`をインストールだけ残します。
その他のcolorscheme pluginはlockfile reviewと取得対象を増やすため採用しません。
`tmuxline.vim`は採用しません。
tmux statuslineはtmux側の`catppuccin/tmux`で管理します。

## formatter integration

formatは`conform.nvim`、lintは`nvim-lint`で扱います。
formatterやlinter本体のversionはproject-local toolとして管理し、Neovim plugin側へ寄せすぎない方針です。
Luaで書いたNeovim設定の補助には、小規模な`lazydev.nvim`を使います。

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
