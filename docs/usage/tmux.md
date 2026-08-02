# tmux usage

tmuxは通常設定とairgap向けslim設定を使い分けます。
includeで共通化せず、用途ごとのポータビリティを優先します。

## 管理対象

- 通常設定: `dot_config/tmux/tmux.conf`
- airgap設定: `dot_config/tmux/tmux.slim.conf`

## 通常設定

通常設定はTPMを使います。
TPM本体がない場合はtmux起動時にcloneし、plugin導入を実行します。

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

```bash
tmux -f ~/.config/tmux/tmux.slim.conf new-session
```

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
| `catppuccin/tmux` | statusline theme | 視認性のため維持 |
| `tmux-plugins/tmux-sensible` | tmuxの無難な既定値 | 維持 |
| `tmux-plugins/tmux-pain-control` | pane操作補助 | 自前keybindで足りるか判断保留 |
| `tmux-plugins/tmux-battery` | battery表示 | laptop利用を前提に維持 |
| `tmux-plugins/tmux-resurrect` | session復元 | 維持 |
| `tmux-plugins/tmux-continuum` | resurrect自動保存 | 自動restoreは無効化して維持 |

`tmux-yank`は採用しません。
copy modeはtmux bufferへのコピーへ統一し、system clipboard連携は必要になった時点で別途検討します。

tagが無いpluginは、必要性と安定性を個別に判断します。
必要性が薄いpluginは追加しません。

## continuum

continuumはsessionの自動保存だけを使います。
自動restoreは古い作業contextや壊れたsession stateを戻す可能性があるため無効にします。
復元が必要な場合はresurrectの操作で明示的に戻します。

## tmux-pain-controlの判断基準

自前keybindを残すか`tmux-pain-control`を残すかは、使う操作面で決めます。
現在の設定にあるpane移動、resize、splitだけで足りるならpluginを外す方が単純です。
plugin独自の細かなpane操作や既定keybindを使っているなら、自前keybindを減らしてpluginへ寄せる方が保守しやすくなります。

現時点の差分:

| 操作 | 自前設定 | `tmux-pain-control` |
| --- | --- | --- |
| pane移動 | prefix + `h/j/k/l` | prefix + `h/j/k/l` と `C-h/C-j/C-k/C-l` |
| pane resize | prefix + `H/J/K/L`、5 cell固定 | prefix + `H/J/K/L`、`@pane_resize`で幅を変更可能 |
| split | prefix + `\|`、`-`、`%`、`"` | 同等に加えて `\` と `_` のfull-size split |
| new window | prefix + `c`で現在pathを引き継ぐ | 同等 |
| window swap | 自前設定なし | prefix + `<` / `>` |

`C-h/C-j/C-k/C-l`、full-size split、window swapを使うならplugin維持が有利です。
使わないなら自前設定だけで足ります。
このリポジトリでは、現時点では判断保留として両方を維持します。

## 更新

Renovateがtag更新PRを作成します。
手動更新する場合はtmux内で実行します。

- 新規導入: prefix + `I`
- 更新: prefix + `U`
- 不要plugin削除: prefix + `alt-u`

このリポジトリのprefixは`C-s`です。
