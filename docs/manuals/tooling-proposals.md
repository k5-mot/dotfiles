# Tooling proposals

この文書は、grilling観点での提案だけを記録します。
ここに書いた内容は未採用の提案であり、設定ファイルへは反映していません。

## 1. Cross-cutting

- 提案: `docs/manuals/repository-guide.md`の推奨スタックと、miseで実際に管理するツールの対応表を追加する。
  - 理由: 現状はuvやgit-czなど一部がmiseにあり、ruff/pytest/taskipy/vitest/playwrightなどはプロジェクトローカル導入として説明されています。この境界は正しいですが、読者が「miseに入るもの」と「各プロジェクトに入れるもの」を混同しやすいです。
  - 採用判断: グローバルCLIとして常に必要なものだけmiseへ置く方針でよいか。

- 提案: docsに「global tool」「project-local tool」「plugin」「manual setup」の用語表を追加する。
  - 理由: Renovate、mise、lazy.nvim、zinit、TPM、uvが別の更新単位を持つため、用語が揺れると保守判断が難しくなります。
  - 採用判断: `CONTEXT.md`の glossary として切り出すか、repository guide内に置くか。

## 2. Vim and Neovim

- 提案: Vimは現状どおりプラグインレスを維持する。
  - 理由: Vimを軽量編集用、NeovimをIDE用に分ける現在の方針と整合しています。
  - 採用判断: Vimに例外的に追加してよいものを「なし」と明文化するか。

- 提案: NeovimのLSP、completion、UI、colorschemeを複数ファイルへ分割する。
  - 理由: 監査で既に「LSP、補完、UI、colorschemeが1ファイルに集約」と残課題化されています。plugin更新PRのレビューでも差分の意味を追いやすくなります。
  - 採用判断: `lua/plugins/lsp.lua`、`completion.lua`、`ui.lua`、`colorscheme.lua`の責務境界を固定してよいか。

- 提案: `lazy.nvim` bootstrap tagと`lazy-lock.json`の役割をdocsへ明記する。
  - 理由: bootstrap tagはplugin manager自体、lockfileは管理対象pluginの解決結果です。更新経路が異なります。
  - 採用判断: Renovate対象はbootstrap tagだけでよいか、lockfile更新も別運用で明記するか。

## 3. zsh

- 提案: タグが無いzinit pluginをcommit pinningするか、現状どおりブランチ追従にするかを決める。
  - 理由: Renovateによるタグ更新PR対象にならないpluginが残っています。再現性を重視するならcommit pinning、メンテ負荷を下げるならブランチ追従です。
  - 採用判断: shell起動の安定性と更新追従のどちらを優先するか。

- 提案: zinit maintenance scriptは手動専用であることをファイル名かdocsでさらに強く示す。
  - 理由: `701_setup-zinit.zsh`は更新と掃除の副作用が強く、自動実行対象に見える名前です。
  - 採用判断: `manual_701_setup-zinit.zsh`のようにrenameするか、docsだけで十分か。

## 4. tmux

- 提案: `tmux.conf`と`tmux.slim.conf`で共通設定をどう同期するか決める。
  - 理由: slim設定を追加したことで、prefix、pane移動、copy modeなどが二重管理になります。
  - 採用判断: 重複を許容するか、chezmoi templateやincludeで共通化するか。

- 提案: TPM pluginは現在のタグ固定を維持する。
  - 理由: Renovate PR化と復旧手順が成立します。
  - 採用判断: tagが無いtmux pluginを将来採用しない方針にするか。

- 提案: `xclip`依存を通常tmux設定にもfallback付きで扱う。
  - 理由: Linux GUI環境以外やairgap環境ではcopy-pipeが失敗しやすいです。
  - 採用判断: 通常設定でも`copy-selection-and-cancel`へ寄せるか、GUI clipboardを優先するか。

## 5. mise and language tooling

- 提案: `uv`はmise管理を維持し、ruff/pytest/taskipyはプロジェクトローカル依存として維持する。
  - 理由: uvは開発環境の入口ですが、lint/test toolはプロジェクトごとのバージョン固定が必要です。
  - 採用判断: tyもプロジェクトローカルだけでよいか、global CLIとしてmiseへ追加するか。

- 提案: Java formatterはmise管理ではなく、プロジェクトのGradle/Maven pluginで管理する。
  - 理由: google-java-formatのバージョンはプロジェクトのJava versionやbuild pluginと合わせるべきです。
  - 採用判断: dotfilesにはJava本体だけを置く方針でよいか。

- 提案: Node系のglobal npm toolsは最小化する。
  - 理由: `npm:hunkdiff`と`npm:git-cz`はglobal toolとして妥当ですが、Vite/Vitest/Playwright/Oxlintはプロジェクトローカルの方が再現性が高いです。
  - 採用判断: global npm toolの追加基準をdocsへ明記するか。

## 6. VS Code

- 提案: VS Code拡張の管理方針を「manual install list」か「settings only」に明確化する。
  - 理由: Windows manualには拡張導入手順があり、Linux側には`dot_config/Code/extension-list`と`install_extension.sh`が残っています。chezmoi適用時に自動実行しない方針とは矛盾しませんが、保守境界が曖昧です。
  - 採用判断: 拡張リストをdocsへ移すか、補助スクリプトを手動コマンドとして残すか。

## 7. Git and docs governance

- 提案: `docs/rules/contributing.md`をrootから見つけやすくするため、root `CONTRIBUTING.md`を短い導線ファイルとして置く。
  - 理由: GitHubはrootの`CONTRIBUTING.md`を特別扱いします。現状のdocs/rules配置は整理されていますが、GitHub UIからの発見性は落ちます。
  - 採用判断: root導線を追加するか、READMEリンクだけで十分か。

- 提案: OpenSpecのCanonical Specとdocsの責務を明記する。
  - 理由: OpenSpecは仕様、manualは手順、rulesは規約という境界があると更新漏れを減らせます。
  - 採用判断: AGENTS.mdだけでなくrepository guideにも短く書くか。
