## Purpose

The dotfiles capability defines a reproducible, manually controlled personal development environment managed by chezmoi. It separates Linux and Windows responsibilities, keeps installation steps explicit, and records editor, shell, terminal, language toolchain, validation, and contribution policies as documentation-backed requirements.

## Requirements

### Requirement: Chezmoi-managed operating system scope

The repository SHALL use chezmoi to manage configuration files while keeping operating-system installation work out of automatic chezmoi apply hooks.

#### Scenario: Linux configuration scope is applied

- **WHEN** a Linux user applies the dotfiles with chezmoi
- **THEN** Vim, Neovim, zsh, bash, tmux, mise, git, and VS Code configuration SHALL be managed
- **AND** package installation SHALL remain documented as manual setup steps

#### Scenario: Windows configuration scope is applied

- **WHEN** a Windows user applies the dotfiles with chezmoi
- **THEN** Windows Terminal, the minimal PowerShell profile, VS Code, and Oh My Posh configuration SHALL be managed
- **AND** PowerShell installation helper scripts SHALL NOT be required

### Requirement: Editor roles are explicit

The repository SHALL keep Vim as a pluginless lightweight editor and Neovim as the IDE-oriented editor.

#### Scenario: Vim remains lightweight

- **WHEN** Vim configuration is loaded
- **THEN** it SHALL NOT depend on vim-plug or repository-managed Vim plugins
- **AND** it SHALL provide only configuration needed for lightweight editing

#### Scenario: Neovim provides IDE features

- **WHEN** Neovim configuration is synchronized
- **THEN** `lazy.nvim` SHALL manage Neovim plugins
- **AND** Mason SHALL include language server coverage for Python, Node.js or TypeScript, Java, and Lua workflows

### Requirement: Shell and terminal plugin maintenance is controlled

The repository SHALL make zsh and tmux plugin maintenance explicit and reviewable.

#### Scenario: zinit initializes zsh plugins

- **WHEN** zsh starts and zinit is not installed
- **THEN** the zinit bootstrap SHALL install zinit from the pinned tag
- **AND** tagged zinit plugins SHALL be eligible for Renovate tag update pull requests
- **AND** public zinit plugins without tags SHALL be pinned to commits when their upstream repository is accessible

#### Scenario: TPM manages normal tmux plugins

- **WHEN** tmux starts with the normal configuration
- **THEN** TPM SHALL bootstrap itself when missing
- **AND** TPM plugins SHALL be pinned to tags where tags are available
- **AND** tag updates SHALL be reviewable through Renovate pull requests

#### Scenario: tmux runs in an airgap environment

- **WHEN** a user starts tmux with `tmux.slim.conf`
- **THEN** tmux SHALL NOT require TPM, GitHub access, xclip, or external theme plugins
- **AND** keybindings SHALL remain aligned with the normal tmux configuration where practical

### Requirement: mise versions are fixed and updateable

The repository SHALL manage development tools through mise with fixed versions instead of `latest`.

#### Scenario: Core tools are installed

- **WHEN** a user runs `mise install`
- **THEN** Python, uv, Node.js, Java, Rust, Lua, jq, peco, fzf, GitHub CLI, Vim, Neovim, tmux, herdr, hunkdiff, and git-cz SHALL be installable from `dot_config/mise/config.toml`

#### Scenario: mise versions are maintained

- **WHEN** Renovate runs
- **THEN** patch updates for mise-managed tools SHALL be proposed as pull requests
- **AND** major and minor updates SHALL NOT be automatically proposed for mise-managed tools

### Requirement: Documentation is the operating contract

The repository SHALL document setup, maintenance, coding rules, contribution rules, and accepted behavior in dedicated documents.

#### Scenario: Setup guidance is needed

- **WHEN** a user needs Linux setup instructions
- **THEN** `docs/usage/linux-setup.md` SHALL provide the procedure

#### Scenario: Windows setup guidance is needed

- **WHEN** a user needs Windows setup instructions
- **THEN** `docs/usage/windows-setup.md` SHALL provide idempotent manual commands

#### Scenario: Development guidance is needed

- **WHEN** a user needs Python, React or TypeScript, Java, Git, or CI guidance
- **THEN** `docs/usage/repository-guide.md`, `docs/rules/coding-rules.md`, and `CONTRIBUTING.md` SHALL provide the applicable guidance

#### Scenario: Tool-specific usage guidance is needed

- **WHEN** a user needs Vim, Neovim, tmux, mise, or VS Code extension guidance
- **THEN** dedicated documents under `docs/usage/` SHALL provide the applicable guidance

#### Scenario: VS Code extensions are maintained

- **WHEN** a user needs VS Code extensions
- **THEN** extension lists SHALL be documented under `docs/usage/`
- **AND** extension installation SHALL remain a manual setup step

### Requirement: Contribution rules are normative

The repository SHALL treat contribution rules as normative according to RFC 8174.

#### Scenario: A commit is created

- **WHEN** a contributor commits a change
- **THEN** the commit message SHALL use Japanese gitmoji Conventional Commits
- **AND** the commit SHALL contain one logical change

#### Scenario: A release tag is created

- **WHEN** a contributor creates a release tag
- **THEN** the tag SHALL use `v<MAJOR>.<MINOR>.<PATCH>`
- **AND** prerelease or build metadata tags SHALL NOT be used

### Requirement: Repository validation is automated

The repository SHALL provide local and CI validation for managed configuration.

#### Scenario: Local repository validation runs

- **WHEN** a contributor runs `pnpm test`
- **THEN** JSON files, TOML files, and chezmoi templates SHALL be validated

#### Scenario: CI validation runs

- **WHEN** GitHub Actions runs repository validation
- **THEN** shell syntax, zsh syntax, tmux normal configuration, tmux slim configuration, and the PowerShell profile SHALL be validated where supported by the runner

### Requirement: Dependency maintenance is pull-request based

The repository SHALL use Renovate and GitHub Actions to propose reviewable dependency updates.

#### Scenario: Plugin tags are updated

- **WHEN** Renovate detects newer supported tags
- **THEN** TPM plugins, the `lazy.nvim` bootstrap tag, and tagged zinit entries SHALL be proposed through pull requests

#### Scenario: GitHub Actions are updated

- **WHEN** Renovate detects newer GitHub Actions versions
- **THEN** those updates SHALL be grouped as GitHub Actions update pull requests

### Requirement: Tooling proposals are non-mutating until accepted

Broad tool, setting, and plugin proposals SHALL be recorded separately from implementation changes until accepted.

#### Scenario: A tooling recommendation is made

- **WHEN** a recommendation proposes adding or removing managed tools, settings, or plugins
- **THEN** the repository configuration SHALL NOT be changed as part of the recommendation
- **AND** the recommendation SHALL identify the affected tool, reasoning, and acceptance question
