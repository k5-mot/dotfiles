# mise usage

miseはglobal toolを固定版で管理します。
`latest`は使いません。

## 管理対象

- `dot_config/mise/config.toml`

## global tool

| tool | 役割 |
| --- | --- |
| `python` | Python runtime |
| `uv` | Python projectの入口 |
| `node` | Node.js runtime |
| `java` | Java runtime |
| `rust` | Rust toolchain |
| `lua` | Lua runtime |
| `jq` | JSON処理 |
| `fzf` | fuzzy finder |
| `github-cli` | GitHub CLI |
| `neovim` | IDE editor |
| `shellcheck` | shell static analysis |
| `shfmt` | shell formatter |
| `stylua` | Lua formatter |
| `taplo` | TOML formatter/linter |
| `actionlint` | GitHub Actions linter |
| `cargo:herdr` | global CLI |
| `npm:hunkdiff` | global CLI |
| `npm:git-cz` | commit helper |

VimとtmuxはOS packageで導入します。
Neovimはplugin互換性の再現性を重視してmiseで固定します。
`npm:hunkdiff`は`hunk`と`hunkdiff`の両方のcommandを提供します。
`npm:git-cz`は`.git-cz.json`の設定を使い、gitmoji Conventional Commits形式のcommit messageを作ります。

## project-local tool

次のツールはプロジェクトごとのlockfileで固定します。
miseには追加しません。

- Python: `ruff`、`pytest`、`taskipy`、`ty`
- TypeScript/React: `vite`、`oxlint`、`typescript`、`vitest`、`playwright`
- Java: `google-java-format`、Spotless、Checkstyleなどのbuild plugin

## install

```bash
mise install
mise reshim
mise current
```

## repo validation CLI

repo検証用CLIは、必要な範囲から手動で実行します。
formatterは既存ファイルを一括整形する前に差分を確認します。

```bash
shellcheck dot_local/bin/*.sh dot_local/script/*.sh
find dot_local/bin dot_local/script -type f -name '*.sh' -print0 | xargs -0 shfmt -d
stylua --check dot_config/nvim
taplo format --check dot_config/mise/config.toml
actionlint .github/workflows/*.yml
```

## update

Renovateはmise管理ツールのpatch更新だけをPR化します。
major/minor更新は環境差分が大きいため自動PR対象外です。

Node系global npm toolは最小化します。
常に複数プロジェクトで使うCLIだけを`npm:` backendへ追加します。
