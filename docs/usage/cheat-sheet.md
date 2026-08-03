# Cheat sheet

このチートシートは、このdotfilesで管理しているtmux、zsh、Neovimの主要操作をまとめたものです。
詳細な方針や保守手順は各usage documentを参照します。

## tmux

prefixは`C-s`です。

| 操作 | key |
| --- | --- |
| prefix入力 | `C-s` |
| 設定reload | prefix + `r` |
| pane移動 | prefix + `h/j/k/l` |
| pane移動 | prefix + `C-h/C-j/C-k/C-l` |
| pane resize | prefix + `H/J/K/L` |
| 横split | prefix + `\|` または `%` |
| 縦split | prefix + `-` または `"` |
| 横splitして現在paneを移動 | prefix + `\` |
| 縦splitして現在paneを移動 | prefix + `_` |
| new window | prefix + `c` |
| windowを左へ移動 | prefix + `<` |
| windowを右へ移動 | prefix + `>` |
| pane同期on | prefix + `e` |
| pane同期off | prefix + `E` |
| paste buffer | prefix + `C-p` |
| TPM plugin install | prefix + `I` |
| TPM plugin update | prefix + `U` |
| TPM plugin clean | prefix + `alt-u` |

copy modeはvi keybindです。

| 操作 | key |
| --- | --- |
| 選択開始 | `v` |
| 行選択 | `V` |
| 矩形選択 | `C-v` |
| copyしてcopy mode終了 | `y` または `Enter` |

statuslineは上部に表示します。
右側にはapplication、session、user、host、battery、date/timeをblock表示します。
date/timeは`YYYY/mm/dd hh:MM:ss`です。

## zsh

keymapはvi modeです。

| 操作 | key / command |
| --- | --- |
| 履歴検索 | `Ctrl-R` |
| file選択 | `Ctrl-T` |
| directory選択 | `Alt-C` |
| cdr履歴からcd | `Ctrl-x` |
| 履歴を上へ検索 | `Ctrl-P` |
| 履歴を下へ検索 | `Ctrl-N` |
| 前方word削除 | `Ctrl-W` |
| 補完 | `Tab` |
| autosuggestion採用 | `Ctrl-Space` |
| ghq repositoryへ移動 | `gh` |
| ghq repositoryをブラウザで開く | `gho` |

`Ctrl-R`、`Ctrl-T`、`Alt-C`は`fzf --zsh`が提供します。
`gh`と`gho`も`fzf`でrepositoryを選びます。

## Neovim

leaderは`,`、localleaderは`\`です。

| 操作 | key |
| --- | --- |
| search highlight解除 | `<Esc><Esc>` |
| format current buffer | `<space>f` |
| file検索 | `ff` |
| grep検索 | `fg` |
| buffer検索 | `fb` |
| help検索 | `fh` |
| file browser | `ft` |

LSP keymapはLSP serverがbufferへattachされた後に有効になります。

| 操作 | key |
| --- | --- |
| declarationへ移動 | `gD` |
| definitionへ移動 | `gd` |
| hover | `K` |
| implementationへ移動 | `gi` |
| signature help | `C-k` |
| workspace folder追加 | `<space>wa` |
| workspace folder削除 | `<space>wr` |
| workspace folder一覧 | `<space>wl` |
| type definitionへ移動 | `<space>D` |
| rename | `<space>rn` |
| rename | `<leader>rn` |
| code action | `<space>ca` |
| code action | `<leader>ca` |
| references | `gr` |
| references | `gh` |
| definitions picker | `gp` |
| type definitionへ移動 | `gy` |
| type definitions picker | `gY` |
| incoming calls | `<leader>ci` |
| outgoing calls | `<leader>co` |

diagnostics keymapはLSP attach前から使えます。

| 操作 | key |
| --- | --- |
| diagnostic float | `<space>e` |
| previous diagnostic | `[d` |
| next diagnostic | `]d` |
| diagnosticsをlocation listへ送る | `<space>q` |
| line diagnostics | `<leader>sl` |
| cursor diagnostics | `<leader>sc` |
| buffer diagnostics | `<leader>sb` |
| workspace diagnostics | `<leader>sw` |
| previous diagnostic | `[e` |
| next diagnostic | `]e` |
| previous error | `[E` |
| next error | `]E` |
| incoming calls | `<leader>ci` |
| outgoing calls | `<leader>co` |
