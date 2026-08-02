# Repository Instructions

This repository is a chezmoi-managed dotfiles project. The documents under `docs/` are authoritative for setup, coding rules, and contribution rules. When this file and the docs conflict, prefer the more specific rule from the referenced document and update the docs instead of silently inventing a new policy.

## Read First

- Use `docs/usage/repository-guide.md` for the overall workflow, language-specific development setup, WSL notes, and proxy examples.
- Use `docs/usage/linux-setup.md` for Linux setup and maintenance procedures.
- Use `docs/usage/windows-setup.md` for Windows setup. Windows installation is documented as manual, idempotent steps rather than executable setup scripts.
- Use `docs/rules/coding-rules.md` for language and documentation rules.
- Use `CONTRIBUTING.md` for branch, commit, and tag rules.
- Use `openspec/specs/dotfiles/spec.md` as the canonical product specification.

## Scope

- Linux manages Vim, Neovim, zsh, bash, tmux, mise, git, and VS Code through chezmoi.
- Windows manages Windows Terminal, a minimal PowerShell profile, VS Code, and Oh My Posh through chezmoi.
- Vim is pluginless and limited to lightweight editing.
- Neovim is the IDE-oriented editor and uses `lazy.nvim`.
- zsh uses `zinit`.
- tmux uses TPM in the normal configuration and `tmux.slim.conf` for pluginless airgap use.
- mise uses fixed versions, not `latest`.

## Engineering Rules

- Keep comments and documentation comments in Japanese for code files.
- Follow the documentation comment requirements in `docs/rules/coding-rules.md` when adding or editing functions or methods.
- Keep unrelated refactors out of behavior changes.
- Do not reintroduce automatic package installation scripts for chezmoi apply.
- Do not delete user changes or revert files unless explicitly asked.
- Use structured parsers for structured data whenever available.

## Git Rules

- Commit messages must follow `CONTRIBUTING.md`.
- Use Japanese gitmoji Conventional Commits.
- Keep each commit to one logical change.
- Do not commit work in progress.
- Commit after each completed task or subtask when changes were made.

## Validation

Run the narrowest relevant validation before committing. For repository-wide changes, run:

```bash
pnpm test
pnpm run test:configs
bash -n dot_bash_profile dot_bashrc dot_config/env
zsh -n dot_config/zsh/dot_zshrc dot_config/zsh/zinit.zsh
tmux -f /dev/null -L dotfiles-check start-server \; source-file -n dot_config/tmux/tmux.conf \; kill-server
tmux -f /dev/null -L dotfiles-slim-check start-server \; source-file -n dot_config/tmux/tmux.slim.conf \; kill-server
pnpm run test:powershell
pnpm exec openspec validate --specs
git diff --check
```

If a validation command is unavailable in the local environment, record that fact in the final response.

## Documentation

- Update `openspec/specs/dotfiles/spec.md` when the accepted behavior or policy changes.
- Keep proposals that are not yet accepted separate from implementation changes.
