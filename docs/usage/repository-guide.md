# Repository guide

このガイドは、このdotfilesを適用した環境で開発リポジトリを作るときの標準手順です。
個別プロジェクトの事情がある場合も、ここから外れる理由をREADMEかADRに残します。
規約の詳細は`docs/rules/coding-rules.md`に従います。
Gitの開発規約は`CONTRIBUTING.md`に従います。
採用済み仕様は`openspec/specs/dotfiles/spec.md`で管理し、docsは手順と規約を説明します。

## 1. このdotfilesの使い方

LinuxではVim、Neovim、zsh、bash、tmux、mise、git、VS Codeをchezmoiで管理します。
WindowsではWindows Terminal、PowerShellプロファイル、VS Code、Oh My Posh設定だけをchezmoiで管理し、インストール作業は`docs/usage/windows-setup.md`の手順で行います。

基本操作:

```bash
chezmoi diff
chezmoi apply
chezmoi update
pnpm test
```

PowerShell profileや実際のshell/editor/tmux commandまで確認する場合は、devcontainerまたは該当commandが入ったLinux環境で追加検証します。

```bash
pnpm run test:powershell
pnpm run test:configs
```

ツール導入はmiseに寄せます。

```bash
mise install
mise reshim
mise current
```

tmuxは通常設定を使います。
airgap環境、初回ネットワークなし環境、プラグインなしで切り分けたい環境ではslim設定を使います。

```bash
tmux -f ~/.config/tmux/tmux.slim.conf new-session
```

global toolとproject-local toolの境界は`CONTEXT.md`の用語に従います。
global toolはmiseで管理し、project-local toolは各プロジェクトのlockfileで管理します。

| 分類 | 管理場所 | 例 |
| --- | --- | --- |
| global tool | `dot_config/mise/config.toml` | `uv`、`git-cz`、`herdr`、`hunkdiff`、repo検証用CLI |
| project-local tool | 各プロジェクトのlockfile | `ruff`、`pytest`、`taskipy`、`ty`、`vite`、`vitest`、`playwright` |
| managed plugin | editor/shell/tmux設定 | `lazy.nvim` plugin、zinit plugin、TPM plugin |
| manual setup | `docs/usage/` | OS package、PowerShell module、VS Code extension |

## 2. Python開発

標準ツールはuv、ty、ruff、pytest、taskipyです。
uvはPython本体、仮想環境、依存関係、lock、コマンド実行の入口として使います。
tyは型検査、ruffはlintとformat、pytestはテスト、taskipyはプロジェクト内タスクの薄い入口です。

新規作成:

```bash
uv init --package my-python-app
cd my-python-app
uv add --dev ty ruff pytest taskipy
uv sync
```

推奨`pyproject.toml`:

```toml
[project]
requires-python = ">=3.12"

[tool.taskipy.tasks]
format = "ruff format ."
lint = "ruff check . && ty check"
test = "pytest"
check = "task lint && task test"

[tool.ruff]
target-version = "py312"
line-length = 88

[tool.ruff.lint]
select = ["E", "F", "I", "B", "UP", "RUF", "SIM", "C4", "PTH"]
ignore = []

[tool.ruff.format]
quote-style = "double"
indent-style = "space"
docstring-code-format = true

[tool.pytest.ini_options]
testpaths = ["tests"]
addopts = "-q"
```

日常操作:

```bash
uv add requests
uv add --dev pytest
uv run task format
uv run task lint
uv run task test
uv run task check
```

Pythonの基本ルール:

- PEP 8とGoogle Python Style Guideを基準にします。
- 公開APIにはGoogle style docstringを書きます。
- CLIは`main(argv)`から終了codeを返します。
- formatterはruff formatに任せ、手作業の整形論争を避ける。
- import順はruffの`I`で統一する。

## 3. React/TypeScript開発

標準ツールはVite + React + TypeScript、Oxc/Oxlint、Vitest、Playwrightです。
Viteは開発サーバーとbuild、TypeScriptは型検査、Oxlintはlint、Vitestはunit/component test、PlaywrightはE2Eを担当します。

新規作成:

```bash
pnpm create vite my-react-app --template react-ts
cd my-react-app
pnpm install
pnpm add -D oxlint vitest jsdom @testing-library/react @testing-library/jest-dom playwright
pnpm create playwright
```

推奨`scripts`:

```json
{
  "scripts": {
    "dev": "vite",
    "build": "tsc -b && vite build",
    "lint": "oxlint . && tsc -b --noEmit",
    "lint:fix": "oxlint . --fix",
    "test": "vitest run",
    "test:watch": "vitest",
    "test:e2e": "playwright test",
    "check": "pnpm lint && pnpm test && pnpm test:e2e"
  }
}
```

推奨`.oxlintrc.json`:

```json
{
  "plugins": ["react", "typescript", "unicorn", "oxc"],
  "categories": {
    "correctness": "error",
    "suspicious": "error",
    "perf": "warn"
  },
  "rules": {
    "no-console": "warn",
    "react/jsx-key": "error"
  }
}
```

推奨`tsconfig.json`方針:

- `strict`を有効にする。
- `noUncheckedIndexedAccess`を有効にする。
- `exactOptionalPropertyTypes`を有効にする。
- `noImplicitOverride`を有効にする。
- `moduleResolution`はプロジェクトのbundlerに合わせる。

日常操作:

```bash
pnpm dev
pnpm lint
pnpm test
pnpm test:e2e
pnpm check
```

React/TypeScriptの基本ルール:

- Microsoft TypeScript Coding GuidelinesとGoogle TypeScript Style Guideを基準にする。
- namespaceは使わず、ES modulesで分割する。
- React componentは小さく保ち、propsの型を明示する。
- 共有型は`types.ts`へ逃がしすぎず、利用箇所に近い場所へ置く。
- `any`は避ける。外部境界では`unknown`で受け、検証してから型を狭める。
- UIの状態はURL、server state、client state、derived stateを混ぜない。

## 4. Java開発

Java本体はmiseで固定版を入れます。

```bash
mise install java
java --version
```

ビルドツールはプロジェクトの既存方針に合わせます。
新規ならGradleかMavenのどちらかに統一し、wrapperを必ずコミットします。

Gradle例:

```bash
gradle init --type java-application
./gradlew test
```

Maven例:

```bash
mvn -v
mvn test
```

推奨lint/format:

- formatterはgoogle-java-formatを使う。
- GradleではSpotlessでgoogle-java-formatを実行する。
- Mavenではgoogle-java-format系pluginかCheckstyleを使う。
- CIではformat check、unit test、必要に応じてintegration testを分ける。

Javaのコーディングルール:

- Google Java Style Guideを基準にする。
- public APIにはJavadocを書く。
- nullを返すAPIを増やさず、必要なら`Optional`か明示的な例外を使う。
- mutable stateの範囲を狭める。
- package-privateを活用し、公開面を必要最小限にする。
- テスト名は期待する振る舞いが読める名前にする。

## 5. Gitとコントリビューション

GitHub Flow、commit message、commit粒度、tag戦略は`CONTRIBUTING.md`に従います。
commit作成はgit-czを使います。

```bash
git add -A
git-cz
```

## 6. 共通CI方針

どの言語でも、CIは次の順に寄せます。

1. format check
2. lint
3. type check
4. unit test
5. integration/E2E test
6. build

ローカルでは`check`タスクを用意し、CIと同じ検証を1コマンドで再現できるようにします。
このdotfiles自体は`.github/workflows/validate.yml`で設定ファイルを検証し、`.github/workflows/renovate.yml`で管理ツールの更新PRを作ります。

## 7. WSL

Windows上でWSLを使う場合は、Windows側でUbuntuを導入してからLinux setupを実行します。

```powershell
wsl --install Ubuntu
```

Ubuntu初回起動時にLinuxユーザー名とpasswordを設定します。
その後、WSL内で`docs/usage/linux-setup.md`の手順を実行します。

Windows側の認証情報をWSLから使う場合は、必要なものだけを個別にリンクします。
既存ファイルを上書きする前に、リンク先と所有権を確認します。

## 8. proxy

proxy環境では、必要に応じて`~/.env`などのchezmoi管理外ファイルへ環境変数を置きます。
credentialをこのリポジトリへcommitしてはいけません。

```bash
export PROXY_USER="<ID>"
export PROXY_PASS="<PASSWORD>"
export PROXY_HOST="<HOST>"
export PROXY_PORT="<PORT>"
export HTTP_PROXY="http://${PROXY_USER}:${PROXY_PASS}@${PROXY_HOST}:${PROXY_PORT}"
export HTTPS_PROXY="${HTTP_PROXY}"
export http_proxy="${HTTP_PROXY}"
export https_proxy="${HTTP_PROXY}"
```
