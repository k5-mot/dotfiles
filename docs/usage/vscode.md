# VS Code usage

VS Codeでは拡張機能に依存しない設定ファイルだけをchezmoiで管理します。
拡張機能と、拡張機能に紐づくsettingsはmanual setupとして扱います。

## 管理対象

- Linux: `dot_config/Code/User/settings.json`
- Linux: `dot_config/Code/User/keybindings.json`
- Linux: `dot_config/Code/User/snippets/`
- Windows: `AppData/Roaming/Code/User/settings.json`

## 分割settings

次のファイルはVS Codeから自動で読み込まれません。
必要な設定だけをユーザーが自分の`settings.json`へ転記します。

| file | 用途 |
| --- | --- |
| `docs/usage/vscode-settings/settings.latex.json` | LaTeX Workshop向け設定 |
| `docs/usage/vscode-settings/settings.python.json` | Python/Jupyter向け設定 |
| `docs/usage/vscode-settings/settings.cpp.json` | C/C++拡張向け設定 |
| `docs/usage/vscode-settings/settings.theme.json` | theme/icon拡張向け設定 |

## Linux extensions

```text
ms-python.python
ms-toolsai.jupyter
ms-python.vscode-pylance
james-yu.latex-workshop
esbenp.prettier-vscode
eamodio.gitlens
```

## Windows extensions

```text
github.copilot
github.copilot-chat
pkief.material-icon-theme
zhuangtongfa.material-theme
ms-vscode-remote.vscode-remote-extensionpack
ms-vscode.remote-explorer
ms-vscode-remote.remote-ssh-edit
```

## 手動導入

Linux:

```bash
while read -r extension; do
  code --install-extension "$extension"
done <<'EOF'
ms-python.python
ms-toolsai.jupyter
ms-python.vscode-pylance
james-yu.latex-workshop
esbenp.prettier-vscode
eamodio.gitlens
EOF
```

Windows:

```powershell
$extensions = @(
    "github.copilot",
    "github.copilot-chat",
    "pkief.material-icon-theme",
    "zhuangtongfa.material-theme",
    "ms-vscode-remote.vscode-remote-extensionpack",
    "ms-vscode.remote-explorer",
    "ms-vscode-remote.remote-ssh-edit"
)

$installedExtensions = code --list-extensions
foreach ($extension in $extensions) {
    if ($installedExtensions -notcontains $extension) {
        code --install-extension $extension
    }
}
```
