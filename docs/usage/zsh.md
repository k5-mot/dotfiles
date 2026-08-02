# zsh usage

zshは主shellです。
plugin managerは`zinit`だけを使います。

## 管理対象

- `dot_config/zsh/dot_zshrc`
- `dot_config/zsh/dot_zshenv`
- `dot_config/zsh/zinit.zsh`
- `dot_zshenv`

## zinit bootstrap

zinit本体は`dot_config/zsh/zinit.zsh`で初期化します。
`ZINIT_HOME`にzinit本体がない場合だけ、固定tagからcloneします。

`dot_local/script/701_setup-zinit.zsh`は手動メンテナンス用scriptです。
chezmoiの`run_` script名ではないため、`chezmoi apply`では自動実行されません。

## plugin inventory

| plugin | 固定方式 | 用途 | 維持判断 |
| --- | --- | --- | --- |
| `zsh-users/zsh-autosuggestions` | tag | 入力履歴に基づくautosuggestion | 維持 |
| `zdharma-continuum/fast-syntax-highlighting` | tag | command line syntax highlight | 維持 |
| `supercrabtree/k` | tag | directory listing補助 | `ls`/`eza`などで足りるなら削除候補 |
| `tj/git-extras` | tag | Git補助command集 | 使うcommandが明確なら維持 |

## tag固定とcommit固定

tagがあるpluginは`zinit ice ver"<tag>"`で固定します。
Renovateはtag固定のpluginを更新PR対象にします。

tagがないpublic pluginはcommitへ固定します。
commit固定pluginは自動更新PR対象ではないため、更新する場合はupstreamを確認してcommitを明示的に差し替えます。

## fzf integration

履歴検索とinteractive filteringは`fzf`へ寄せます。

`dot_config/zsh/dot_zshrc`は`mise activate zsh`の後で`fzf --zsh`を読み込みます。
`Ctrl-R`は`fzf`の履歴検索に割り当て、`zsh-autosuggestions`はinline suggestionだけを担当します。

`cdr`履歴と`ghq` repository選択も`fzf`を使います。
`peco`と`history-search-multi-word`は使いません。

## mise integration

zshではmise管理版のtoolをOS側に入っている同名toolより優先します。
OS側toolは削除せず、`PATH`の優先順位でmise管理版へ収束させます。

miseが未導入でもinteractive shellの起動は失敗させません。
interactive shellでは短い警告を出し、non-interactive shellでは警告を出しません。

## manual maintenance

zinit更新は月次または不具合対応時だけ実行します。

```zsh
zinit self-update
zinit update --all
```

cache掃除とcompileは、不具合対応または明示的な整理時にだけ実行します。

```zsh
zinit delete --clean
zinit cclear
zinit compile --all
```

更新後は新しいzshを開き、prompt、completion、fzf history search、autosuggestionが動くことを確認します。
