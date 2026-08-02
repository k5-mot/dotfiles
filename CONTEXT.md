# Dotfiles

This context defines the vocabulary for this chezmoi-managed dotfiles repository. It keeps setup, tooling, plugin, and documentation terms precise so configuration and documentation decisions stay aligned.

## Language

**Managed configuration**:
A file or directory that chezmoi applies into a target machine as part of this dotfiles repository.
_Avoid_: Installed package, generated state

**Manual setup**:
An idempotent setup step documented for a user to run explicitly, outside automatic chezmoi apply hooks.
_Avoid_: Bootstrap script, hidden install

**Global tool**:
A command-line tool installed through mise because it is useful across projects and is not primarily versioned by one project.
_Avoid_: Project dependency, plugin

**Project-local tool**:
A tool declared inside an application repository so its version follows that project's lockfile and CI.
_Avoid_: Global tool, user package

**Managed plugin**:
An editor, shell, or tmux plugin declared in dotfiles configuration and maintained through its plugin manager or Renovate.
_Avoid_: Project-local tool, OS package

**Airgap tmux profile**:
The pluginless tmux configuration intended for offline, restricted, or portability-focused environments.
_Avoid_: Minimal tmux, fallback config

**Canonical Spec**:
The OpenSpec document that records accepted repository behavior and policy as requirements and scenarios.
_Avoid_: Proposal, task memo

**Task memo**:
A local working note under `docs/tasks/` used for audit notes, proposal discussion, or implementation tracking before the result becomes accepted docs or spec.
_Avoid_: Canonical Spec, rule document
