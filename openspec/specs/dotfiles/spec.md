## Purpose

The dotfiles capability defines a reproducible, manually controlled personal development environment managed by chezmoi. It separates Linux and Windows responsibilities, keeps installation steps explicit, and records editor, shell, terminal, language toolchain, validation, and contribution policies as documentation-backed requirements.

## Requirements

### Requirement: Chezmoi-managed operating system scope

The repository SHALL use chezmoi to manage configuration files while keeping operating-system installation work out of automatic chezmoi apply hooks.

#### Scenario: Chezmoi ignores unsupported operating-system files

- **WHEN** chezmoi evaluates ignore rules for a non-Linux host
- **THEN** Linux shell configuration such as `.bash_profile`, `.bashrc`, `.zshenv`, and `.emacs.d/` SHALL NOT be applied
- **AND** Linux `.config/` and `.local/` managed configuration SHALL NOT be applied
- **AND** Windows-specific `AppData` and `Documents` configuration SHALL only be applied on Windows hosts
- **AND** Darwin hosts SHALL NOT receive managed files until macOS support is explicitly accepted

#### Scenario: Chezmoi ignores repository support files

- **WHEN** chezmoi evaluates managed files
- **THEN** repository documentation, OpenSpec files, CI configuration, devcontainer configuration, dependency lockfiles, package manifests, and test scripts SHALL NOT be applied to the target home directory
- **AND** those files SHALL remain repository support files rather than managed configuration

#### Scenario: Chezmoi templates are evaluated

- **WHEN** chezmoi evaluates repository templates
- **THEN** PowerShell, shell, and cd interpreters SHALL be declared through `.chezmoi.toml.tmpl`
- **AND** `.chezmoiexternal.toml` SHALL remain an intentionally empty reservation until an external managed dependency is accepted

#### Scenario: Linux configuration scope is applied

- **WHEN** a Linux user applies the dotfiles with chezmoi
- **THEN** Vim, Neovim, zsh, bash, tmux, mise, git, and VS Code configuration SHALL be managed
- **AND** Linux support configuration for dircolors, fzshell, latexmk, Starship, `tmux-ide`, local maintenance scripts, minimal Emacs init, and GVim SHALL be managed
- **AND** legacy statusline helper scripts and decorative local bin scripts SHALL NOT be managed after their removal is accepted
- **AND** package installation SHALL remain documented as manual setup steps

#### Scenario: Windows configuration scope is applied

- **WHEN** a Windows user applies the dotfiles with chezmoi
- **THEN** Windows Terminal, the minimal PowerShell profile, VS Code, and Oh My Posh configuration SHALL be managed
- **AND** PowerShell installation helper scripts SHALL NOT be required
- **AND** `Documents/PowerShell/Scripts` helper content SHALL NOT be managed
- **AND** OS package, PowerShell module, VS Code extension, and mise tool installation SHALL remain explicit manual setup rather than automatic chezmoi apply behavior

#### Scenario: Windows PowerShell profile is loaded

- **WHEN** the PowerShell profile is loaded
- **THEN** configured PowerShell modules SHALL be imported with errors surfaced when they are missing
- **AND** Oh My Posh SHALL only be initialized when the command and configured theme file are available
- **AND** XDG environment variables SHALL be set for the Windows user profile
- **AND** helper functions SHALL use comment-based help that explains purpose, parameters, return values, and side effects where applicable

#### Scenario: Git local identity is configured

- **WHEN** user-specific Git identity or secrets are needed
- **THEN** they SHALL be kept in `~/.gitconfig.local`
- **AND** the repository SHALL provide `docs/usage/gitconfig-local.example` as a template

### Requirement: Editor roles are explicit

The repository SHALL keep Vim as a pluginless lightweight editor and Neovim as the IDE-oriented editor.

#### Scenario: Vim remains lightweight

- **WHEN** Vim configuration is loaded
- **THEN** it SHALL NOT depend on vim-plug or repository-managed Vim plugins
- **AND** it SHALL provide only configuration needed for lightweight editing
- **AND** Vim configuration SHALL be consolidated in `~/.vimrc` without includes into `~/.config/vim`
- **AND** Vim-specific `~/.config/vim` files SHALL NOT be managed
- **AND** the active Vim colorscheme SHALL be the Vim-bundled `slate` colorscheme to stay visually close to the Catppuccin Frappe tmux palette without adding plugins
- **AND** local Vim-only overrides MAY be placed in `~/.vimrc_local` outside chezmoi management

#### Scenario: Neovim provides IDE features

- **WHEN** Neovim configuration is synchronized
- **THEN** `lazy.nvim` SHALL manage Neovim plugins
- **AND** Mason SHALL include language server coverage for Python, Node.js or TypeScript, Java, and Lua workflows
- **AND** nvim-lspconfig SHALL provide server default configurations while Neovim native `vim.lsp.config` and `vim.lsp.enable` SHALL register and enable servers
- **AND** deprecated `require('lspconfig')[server].setup()` registration SHALL NOT be used

#### Scenario: Neovim plugin responsibilities are maintained

- **WHEN** Neovim plugin configuration changes
- **THEN** LSP, format, lint, completion, colorscheme, statusline, editor, syntax, filer, and search responsibilities SHALL stay documented in `docs/usage/neovim.md`
- **AND** future plugin spec splitting SHALL follow those responsibility boundaries
- **AND** `catppuccin/nvim` SHALL be the active Neovim colorscheme with the `frappe` flavor
- **AND** alternate colorscheme plugins MAY remain installed without being the active colorscheme
- **AND** `nvim-treesitter` SHALL stay on the `master` branch while the syntax configuration uses the legacy `nvim-treesitter.configs` API
- **AND** `tmuxline.vim` SHALL NOT be used because tmux statusline ownership belongs to tmux configuration
- **AND** unused Node, Perl, and Ruby Neovim providers SHALL be disabled while the Python provider remains enabled
- **AND** LuaSnip SHALL build `jsregexp` for placeholder transformations
- **AND** `cargo:tree-sitter-cli` SHALL be managed by mise for Treesitter parser generation
- **AND** lazy.nvim LuaRocks support SHALL be disabled while no plugin requires LuaRocks

#### Scenario: Neovim formatting and linting are configured

- **WHEN** Neovim handles formatting or linting
- **THEN** `conform.nvim` SHALL provide formatting integration
- **AND** `nvim-lint` SHALL provide lint integration
- **AND** formatter and linter executable versions SHALL remain project-local where practical
- **AND** conform.nvim SHALL register only formatter commands that are executable at Neovim startup
- **AND** `lazydev.nvim` SHALL provide lightweight assistance for Lua-based Neovim configuration

#### Scenario: Neovim plugin lockfile changes

- **WHEN** Neovim plugins are synchronized with Lazy
- **THEN** `dot_config/nvim/lazy-lock.json` SHALL capture resolved plugin revisions
- **AND** that lockfile SHALL be reviewed manually rather than updated by Renovate

### Requirement: Shell and terminal plugin maintenance is controlled

The repository SHALL make zsh and tmux plugin maintenance explicit and reviewable.

#### Scenario: zinit initializes zsh plugins

- **WHEN** zsh starts and zinit is not installed
- **THEN** the zinit bootstrap SHALL install zinit from the pinned tag
- **AND** tagged zinit plugins SHALL be eligible for Renovate tag update pull requests
- **AND** public zinit plugins without tags SHALL be pinned to commits when their upstream repository is accessible

#### Scenario: zsh history search uses fzf

- **WHEN** zsh runs as the user's interactive shell
- **THEN** `fzf --zsh` SHALL provide `Ctrl-R` history search after mise activates the shell environment
- **AND** `zsh-autosuggestions` SHALL provide inline suggestions rather than interactive history search
- **AND** `cdr` history and `ghq` repository selection SHALL use `fzf`
- **AND** `peco` and `history-search-multi-word` SHALL NOT be used for zsh interactive filtering

#### Scenario: zinit maintenance is needed

- **WHEN** zinit self-update, plugin update, cleaning, or compilation is needed
- **THEN** `dot_local/script/701_setup-zinit.zsh` SHALL be treated as a manual maintenance script
- **AND** chezmoi apply SHALL NOT automatically run the script unless its filename is changed to a chezmoi run script

#### Scenario: TPM manages normal tmux plugins

- **WHEN** tmux starts with the normal configuration
- **THEN** TPM SHALL bootstrap itself when missing
- **AND** TPM plugins SHALL be pinned to tags where tags are available
- **AND** `catppuccin/tmux` SHALL use the Frappe flavor
- **AND** the normal statusline SHALL render displayed items as separated Catppuccin blocks
- **AND** the normal statusline SHALL show application, session, user, host, battery, and date/time modules on the right side
- **AND** the normal statusline SHALL show tmux-battery output through the Catppuccin battery module
- **AND** the normal statusline SHALL show date/time in `YYYY/mm/dd hh:MM:ss` format
- **AND** tag updates SHALL be reviewable through Renovate pull requests
- **AND** tmux resurrect and continuum SHALL store restore state under the user cache directory
- **AND** tmux continuum SHALL keep automatic save enabled while automatic restore remains disabled

#### Scenario: tmux runs in an airgap environment

- **WHEN** a user starts tmux with `tmux.slim.conf`
- **THEN** tmux SHALL NOT require TPM, GitHub access, xclip, or external theme plugins
- **AND** keybindings SHALL remain aligned with the normal tmux configuration where practical
- **AND** the slim configuration SHALL avoid includes that would reintroduce plugin or network dependencies
- **AND** the slim statusline SHALL use tmux-native style settings to approximate the Catppuccin Frappe palette without an external theme plugin
- **AND** the slim statusline SHALL show window tabs, hostname, username, date, and time with seconds
- **AND** the slim statusline refresh interval SHALL be 1 second

#### Scenario: tmux copy mode is used

- **WHEN** text is copied from tmux copy mode
- **THEN** normal and slim configurations SHALL copy into the tmux buffer with `copy-selection-and-cancel`
- **AND** normal and slim configurations SHALL bind `Enter` in copy mode to `copy-selection-and-cancel`
- **AND** the copy binding SHALL NOT require `xclip`

#### Scenario: tmux pane operations are used

- **WHEN** a user needs pane movement, pane resize, split, or window swap keybindings
- **THEN** normal and slim tmux configurations SHALL define the keybindings directly
- **AND** `tmux-pain-control` SHALL NOT be used

#### Scenario: tmux IDE layout is created

- **WHEN** a user runs `tmux-ide`
- **THEN** a tmux layout SHALL be created from the selected `--mode`
- **AND** modes 1, 2, and 3 SHALL be handled by the single `tmux-ide` command
- **AND** separate mode-specific `tmux-ide-mode*` commands SHALL NOT be managed

#### Scenario: tmux plugins are reviewed

- **WHEN** TPM plugin inventory is reviewed
- **THEN** each plugin SHALL have a documented purpose and maintenance judgment in `docs/usage/tmux.md`
- **AND** plugins with weak value or unstable maintenance SHOULD be removed only after the proposal is accepted

### Requirement: mise versions are fixed and updateable

The repository SHALL manage development tools through mise with fixed versions instead of `latest`.

#### Scenario: Core tools are installed

- **WHEN** a user runs `mise install`
- **THEN** Python, uv, Node.js, Java, Rust, Lua, jq, fzf, GitHub CLI, Neovim, tree-sitter CLI, shellcheck, shfmt, stylua, taplo, actionlint, herdr, hunkdiff, and git-cz SHALL be installable from `dot_config/mise/config.toml`
- **AND** project-local lint, test, format, and build tools SHALL remain outside mise unless accepted as global tools
- **AND** Vim and tmux SHALL be installed as operating-system packages

#### Scenario: mise-managed tools are prioritized

- **WHEN** zsh or bash starts interactively on Linux
- **THEN** mise-managed tools SHALL take precedence over operating-system preinstalled tools through `PATH`
- **AND** operating-system preinstalled tools SHALL NOT be removed to enforce that precedence
- **AND** missing mise SHALL NOT prevent the shell from starting
- **AND** an interactive shell SHOULD show a short warning when mise is missing
- **AND** non-interactive shells SHALL NOT emit a mise-missing warning

#### Scenario: mise versions are maintained

- **WHEN** Renovate runs
- **THEN** patch updates for mise-managed tools SHALL be proposed as pull requests
- **AND** major and minor updates SHALL NOT be automatically proposed for mise-managed tools

#### Scenario: Node global tools are considered

- **WHEN** a Node-based command-line tool is proposed for mise
- **THEN** it SHALL be accepted only when it is useful across multiple projects
- **AND** project-local tools such as Vite, TypeScript, Oxlint, Vitest, and Playwright SHALL remain project dependencies

#### Scenario: Python project tooling is used

- **WHEN** a Python project is created from this repository's guidance
- **THEN** uv SHALL be the project entry point
- **AND** ty, ruff, pytest, and taskipy SHALL be installed as project-local development dependencies

#### Scenario: Java project tooling is used

- **WHEN** Java formatting or linting is needed
- **THEN** Java itself SHALL be provided by mise
- **AND** google-java-format, Spotless, Checkstyle, or equivalent format and lint tools SHALL be managed by the Java project build

### Requirement: Documentation is the operating contract

The repository SHALL document setup, maintenance, coding rules, contribution rules, and accepted behavior in dedicated documents.

#### Scenario: Setup guidance is needed

- **WHEN** a user needs Linux setup instructions
- **THEN** `docs/usage/linux-setup.md` SHALL provide the procedure

#### Scenario: Linux dotfiles development guidance is needed

- **WHEN** a contributor develops this dotfiles repository on Linux
- **THEN** `docs/usage/linux-dev.md` SHALL document chezmoi edit, diff, apply, validation, local-only data, and commit workflow

#### Scenario: Windows setup guidance is needed

- **WHEN** a user needs Windows setup instructions
- **THEN** `docs/usage/windows-setup.md` SHALL provide idempotent manual commands

#### Scenario: Development guidance is needed

- **WHEN** a user needs Python, React or TypeScript, Java, Git, or CI guidance
- **THEN** `docs/usage/repository-guide.md`, `docs/rules/coding-rules.md`, and `CONTRIBUTING.md` SHALL provide the applicable guidance
- **AND** language-specific mandatory coding rules SHALL remain in `docs/rules/coding-rules.md`
- **AND** Git branch, commit, and tag rules SHALL remain in `CONTRIBUTING.md`

#### Scenario: WSL or proxy guidance is needed

- **WHEN** a user needs WSL setup guidance or proxy examples
- **THEN** `docs/usage/repository-guide.md` SHALL provide the shared guidance
- **AND** credential-bearing proxy values SHALL be kept outside managed repository files

#### Scenario: Tool-specific usage guidance is needed

- **WHEN** a user needs Vim, Neovim, tmux, mise, or VS Code extension guidance
- **THEN** dedicated documents under `docs/usage/` SHALL provide the applicable guidance

#### Scenario: VS Code extensions are maintained

- **WHEN** a user needs VS Code extensions
- **THEN** extension lists SHALL be documented under `docs/usage/`
- **AND** extension installation SHALL remain a manual setup step
- **AND** Linux and Windows VS Code settings SHALL remain separate because VS Code uses OS-specific user settings locations
- **AND** Linux VS Code keybindings and snippets MAY be managed with the Linux VS Code user configuration
- **AND** Windows VS Code keybindings and snippets SHALL NOT be managed until explicitly accepted
- **AND** extension-specific settings SHALL be kept as non-loaded examples under `docs/usage/vscode-settings/`

#### Scenario: Editor defaults are needed

- **WHEN** tools that understand EditorConfig open repository files
- **THEN** `.editorconfig` SHALL define only minimal cross-editor defaults
- **AND** existing files SHALL NOT be reformatted solely because EditorConfig was introduced

#### Scenario: Repository terminology is needed

- **WHEN** a reader needs canonical terminology for setup, tooling, plugins, or specs
- **THEN** `CONTEXT.md` SHALL define the shared glossary
- **AND** `CONTEXT.md` SHALL remain a glossary rather than an implementation spec

#### Scenario: AI agent guidance is needed

- **WHEN** an AI agent works in this repository
- **THEN** `AGENTS.md` SHALL provide English, docs-first operating instructions
- **AND** those instructions SHALL point agents to usage docs, coding rules, contribution rules, and OpenSpec before changing behavior

### Requirement: Contribution rules are normative

The repository SHALL treat contribution rules as normative according to RFC 8174.

#### Scenario: A commit is created

- **WHEN** a contributor commits a change
- **THEN** the commit message SHALL use Japanese gitmoji Conventional Commits
- **AND** the commit SHALL contain one logical change
- **AND** work-in-progress commits SHALL NOT be created without an explicit request
- **AND** refactoring and behavior changes SHALL be separated into different commits
- **AND** git-cz prompt behavior SHALL be configured through `.git-cz.json`

#### Scenario: A release tag is created

- **WHEN** a contributor creates a release tag
- **THEN** the tag SHALL use `v<MAJOR>.<MINOR>.<PATCH>`
- **AND** prerelease or build metadata tags SHALL NOT be used

### Requirement: Repository validation is automated

The repository SHALL provide local and CI validation for managed configuration.

#### Scenario: Local repository validation runs

- **WHEN** a contributor runs `pnpm test`
- **THEN** JSON files, TOML files, and chezmoi templates SHALL be validated
- **AND** OpenSpec specifications SHALL be validated
- **AND** chezmoi managed-file scope SHALL be validated for Linux, Windows, and unsupported operating-system targets
- **AND** non-loaded VS Code example settings under `docs/usage/vscode-settings/` SHALL be included in JSON validation

#### Scenario: Command-based configuration validation runs

- **WHEN** a contributor or CI runs `pnpm run test:configs`
- **THEN** Vim, Neovim, zsh, normal tmux, and slim tmux configurations SHALL be loaded through their real commands
- **AND** validation scripts MAY pass temporary `HOME` or XDG environment variables to tested commands for process-local isolation
- **AND** those temporary environment variables SHALL NOT be treated as persistent shell startup configuration
- **AND** validation scripts SHOULD resolve mise-managed command paths before changing temporary XDG variables when a mise shim would otherwise read the temporary config home

#### Scenario: Shell startup environment is configured

- **WHEN** persistent Linux environment variables are needed
- **THEN** they SHALL be configured through managed shell startup or shared env files such as `dot_zshenv`, `dot_bash_profile`, and `dot_config/env`
- **AND** test isolation environment variables SHALL NOT be promoted into managed startup files unless they are needed during normal interactive shell startup

#### Scenario: CI validation runs

- **WHEN** GitHub Actions runs repository validation
- **THEN** shell syntax, zsh syntax, tmux normal configuration, tmux slim configuration, and the PowerShell profile SHALL be validated where supported by the runner
- **AND** CI SHALL install the system dependencies needed for those validation commands

#### Scenario: PowerShell profile validation runs

- **WHEN** `pnpm run test:powershell` runs
- **THEN** `pwsh` SHALL parse `Documents/PowerShell/Profile.ps1`
- **AND** syntax errors SHALL fail the command

#### Scenario: Devcontainer is used

- **WHEN** the repository is opened in its devcontainer
- **THEN** Node.js 22.22.2, PowerShell, Python 3.12, uv, curl, wget, Git, jq, ca-certificates, build-essential, ripgrep, Vim, Neovim, zsh, and tmux SHALL be provided through devcontainer features
- **AND** the devcontainer SHALL NOT add tools through a Dockerfile
- **AND** devcontainer-managed VS Code extensions and settings SHALL be limited to the devcontainer customization surface
- **AND** Codex settings MAY be bind-mounted from the host while credentials SHALL NOT be recorded in the repository
- **AND** Serena, pnpm, and uv caches SHALL be mounted as persistent volumes
- **AND** command-based Vim, Neovim, zsh, and tmux validation SHALL run in CI and devcontainer environments

#### Scenario: Devcontainer post-create initialization runs

- **WHEN** the devcontainer post-create command runs
- **THEN** Corepack SHALL be enabled
- **AND** the repository root SHALL install pnpm dependencies with the frozen lockfile when `package.json` is present
- **AND** the repository root SHALL synchronize uv development dependencies with Python 3.12 when `pyproject.toml` is present
- **AND** immediate child Node.js projects SHALL be initialized according to `pnpm-lock.yaml`, `yarn.lock`, or `package-lock.json`
- **AND** immediate child Python projects SHALL be initialized according to `poetry.lock`, `pyproject.toml`, or `requirements.txt`
- **AND** Serena project index setup SHALL run only when the cache is not already present

### Requirement: Dependency maintenance is pull-request based

The repository SHALL use Renovate and GitHub Actions to propose reviewable dependency updates.

#### Scenario: Renovate is scheduled

- **WHEN** the Renovate workflow runs on schedule
- **THEN** it SHALL run before Monday 06:00 in the Asia/Tokyo timezone
- **AND** it SHALL be runnable manually through `workflow_dispatch`

#### Scenario: Plugin tags are updated

- **WHEN** Renovate detects newer supported tags
- **THEN** TPM plugins, the `lazy.nvim` bootstrap tag, and tagged zinit entries SHALL be proposed through pull requests
- **AND** those updates SHALL be grouped as managed plugin tag updates

#### Scenario: GitHub Actions are updated

- **WHEN** Renovate detects newer GitHub Actions versions
- **THEN** those updates SHALL be grouped as GitHub Actions update pull requests

#### Scenario: Renovate permissions are needed

- **WHEN** Renovate creates or updates dependency pull requests
- **THEN** the workflow SHALL have permissions to write contents, issues, and pull requests
- **AND** `RENOVATE_TOKEN` MAY be used when GitHub token permissions are insufficient

### Requirement: Tooling proposals are non-mutating until accepted

Broad tool, setting, and plugin proposals SHALL be recorded separately from implementation changes until accepted.

#### Scenario: A tooling recommendation is made

- **WHEN** a recommendation proposes adding or removing managed tools, settings, or plugins
- **THEN** the repository configuration SHALL NOT be changed as part of the recommendation
- **AND** the recommendation SHALL identify the affected tool, reasoning, and acceptance question
