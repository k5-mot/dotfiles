# VS Code usage

VS Codeでは設定ファイルだけをchezmoiで管理し、拡張機能はmanual setupとして扱います。
拡張リストはこの文書で管理します。

## 管理対象

- Linux: `dot_config/Code/User/settings.json`
- Linux: `dot_config/Code/User/keybindings.json`
- Linux: `dot_config/Code/User/snippets/`
- Windows: `AppData/Roaming/Code/User/settings.json`

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
