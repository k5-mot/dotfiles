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
| `peco` | interactive filtering |
| `fzf` | fuzzy finder |
| `github-cli` | GitHub CLI |
| `vim` | 軽量editor |
| `neovim` | IDE editor |
| `tmux` | terminal multiplexer |
| `cargo:herdr` | global CLI |
| `npm:hunkdiff` | global CLI |
| `npm:git-cz` | commit helper |

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

## update

Renovateはmise管理ツールのpatch更新だけをPR化します。
major/minor更新は環境差分が大きいため自動PR対象外です。

Node系global npm toolは最小化します。
常に複数プロジェクトで使うCLIだけを`npm:` backendへ追加します。
