# tmux usage

tmuxは通常設定とairgap向けslim設定を使い分けます。
includeで共通化せず、用途ごとのポータビリティを優先します。

## 管理対象

- 通常設定: `dot_config/tmux/tmux.conf`
- airgap設定: `dot_config/tmux/tmux.slim.conf`

## 通常設定

通常設定はTPMを使います。
TPM本体がない場合はtmux起動時にcloneし、plugin導入を実行します。
statuslineはCatppuccin Frappeのmoduleを項目ごとのブロックとして表示します。
右側にはapplication、session、user、host、battery、date/timeを表示します。
batteryは`tmux-battery`の`#{battery_icon}`と`#{battery_percentage}`をCatppuccin module経由で表示します。
date/timeは`YYYY/mm/dd hh:MM:ss`形式です。

```bash
tmux new-session
```

設定を読み直す場合:

```bash
tmux source-file ~/.config/tmux/tmux.conf
```

## slim設定

slim設定はTPM、GitHub clone、xclip、外部テーマpluginに依存しません。
airgap環境、初回ネットワークなし環境、切り分け用途で使います。
statuslineは外部theme pluginを使わず、tmux標準機能だけでCatppuccin Frappeに近い配色にします。
window tab、hostname、username、日付、秒付き時刻を表示し、通常設定と同じ1秒間隔で更新します。

```bash
tmux -f ~/.config/tmux/tmux.slim.conf new-session
```

## tmux-ide

`tmux-ide`は手動でIDE風のtmux layoutを作る補助commandです。
mode別scriptは持たず、単一entry pointに集約します。

```bash
tmux-ide --mode 1
tmux-ide --mode 2
tmux-ide --mode 3
```

`--mode`を省略した場合はmode 1を使います。

## copy mode

通常設定もslim設定も、copy modeではtmux bufferへコピーします。
xclipへのpipeは使いません。

- 選択開始: `v`
- 行選択: `V`
- 矩形選択: `C-v`
- コピー: `y` または `Enter`
- ペースト: prefix + `C-p`

## TPM plugin inventory

| plugin | 用途 | 維持判断 |
| --- | --- | --- |
| `tmux-plugins/tpm` | TPM本体 | 必須 |
| `catppuccin/tmux` | Frappeステータスラインテーマ | 視認性のため維持 |
| `tmux-plugins/tmux-sensible` | tmuxの無難な既定値 | 維持 |
| `tmux-plugins/tmux-battery` | battery表示 | laptop利用を前提に維持 |
| `tmux-plugins/tmux-resurrect` | session復元 | 維持 |
| `tmux-plugins/tmux-continuum` | resurrect自動保存 | 自動restoreは無効化して維持 |

`tmux-yank`は採用しません。
copy modeはtmux bufferへのコピーへ統一し、system clipboard連携は必要になった時点で別途検討します。
`tmux-pain-control`は採用しません。
必要だったpane操作keybindは`tmux.conf`と`tmux.slim.conf`へ直接定義します。

tagが無いpluginは、必要性と安定性を個別に判断します。
必要性が薄いpluginは追加しません。

## continuum

continuumはsessionの自動保存だけを使います。
自動restoreは古い作業contextや壊れたsession stateを戻す可能性があるため無効にします。
復元が必要な場合はresurrectの操作で明示的に戻します。

## pane keybindings

`tmux-pain-control`由来の有用なkeybindは、pluginなしで使えるように直接定義します。

| 操作 | key |
| --- | --- |
| pane移動 | prefix + `h/j/k/l`、prefix + `C-h/C-j/C-k/C-l` |
| pane resize | prefix + `H/J/K/L` |
| split | prefix + `\|`、`-`、`%`、`"`、`\`、`_` |
| new window | prefix + `c` |
| window swap | prefix + `<` / `>` |

pane分割とnew windowは現在pathを引き継ぎます。

## 更新

Renovateがtag更新PRを作成します。
手動更新する場合はtmux内で実行します。

- 新規導入: prefix + `I`
- 更新: prefix + `U`
- 不要plugin削除: prefix + `alt-u`

このリポジトリのprefixは`C-s`です。
