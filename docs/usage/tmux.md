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
| `tmux-plugins/tmux-yank` | copy/yank補助 | xclip非依存化後も必要性を再評価 |
| `tmux-plugins/tmux-pain-control` | pane操作補助 | keybind重複が多ければ削除候補 |
| `tmux-plugins/tmux-battery` | battery表示 | laptop利用が薄ければ削除候補 |
| `tmux-plugins/tmux-resurrect` | session復元 | 維持 |
| `tmux-plugins/tmux-continuum` | resurrect自動保存/復元 | 維持 |

tagが無いpluginは、必要性と安定性を個別に判断します。
必要性が薄いpluginは追加しません。

## 更新

Renovateがtag更新PRを作成します。
手動更新する場合はtmux内で実行します。

- 新規導入: prefix + `I`
- 更新: prefix + `U`
- 不要plugin削除: prefix + `alt-u`

このリポジトリのprefixは`C-s`です。
