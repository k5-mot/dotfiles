# Windows setup manual

この手順は、Windows 11でWindows Terminal、PowerShellプロファイル、VS Code設定をchezmoiで管理するための手順です。
リポジトリにはPowerShell補助スクリプトを置かず、再実行しても壊れにくいコマンドだけを手順として残します。

## 管理対象

- Windows Terminal: `AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json`
- PowerShell: `Documents/PowerShell/Profile.ps1`
- VS Code: `AppData/Roaming/Code/User/settings.json`
- Oh My Posh: `AppData/Local/oh-my-posh/config.json`

Linux側のVS Code設定は`dot_config/Code`で別管理します。
VS CodeがOSごとに異なるユーザー設定ディレクトリを参照し、既定ターミナル、フォント、パス、Remote Developmentまわりの値もWindowsとLinuxで分かれるためです。

## 事前条件

- Windows 11
- 管理者権限で起動したPowerShell
- Microsoft Store版またはApp Installer同梱の`winget`
- GitHubへ接続できるネットワーク

## 1. wingetを確認する

```powershell
winget --version
```

`winget`が見つからない場合は、Microsoft StoreからApp Installerを更新してからPowerShellを開き直します。

## 2. 基本ツールを入れる

既に入っているパッケージはスキップします。

```powershell
$packages = @(
    "Microsoft.PowerShell",
    "Microsoft.WindowsTerminal",
    "Microsoft.VisualStudioCode",
    "Git.Git",
    "twpayne.chezmoi",
    "JanDeDobbeleer.OhMyPosh"
)

foreach ($package in $packages) {
    winget list --exact --id $package | Out-Null
    if ($LASTEXITCODE -ne 0) {
        winget install --exact --id $package --accept-package-agreements --accept-source-agreements
    }
}
```

インストール後、PATHを現在のセッションに反映します。

```powershell
$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
```

## 3. PowerShellモジュールを入れる

プロファイルは未インストールのモジュールを読み飛ばします。
必要な補完や表示を有効にしたい場合だけ、次を実行します。

```powershell
Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
$modules = @(
    "posh-git",
    "Terminal-Icons",
    "PSReadLine",
    "CompletionPredictor"
)

foreach ($module in $modules) {
    if (-not (Get-Module -ListAvailable -Name $module)) {
        Install-Module -Name $module -Scope CurrentUser -AllowClobber
    }
}
```

## 4. chezmoiを適用する

SSH鍵を設定済みの場合:

```powershell
chezmoi init --apply git@github.com:k5-mot/dotfiles.git
```

SSH鍵をまだ置いていない場合:

```powershell
chezmoi init --apply https://github.com/k5-mot/dotfiles.git
```

既存環境へ再適用する場合:

```powershell
chezmoi update
```

## 5. VS Code拡張機能を入れる

拡張機能のインストール状態はchezmoi管理対象ではありません。
必要なものだけを選んで実行します。

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

## 6. 適用結果を確認する

```powershell
chezmoi managed | Select-String "WindowsTerminal|PowerShell|Code|oh-my-posh"
pwsh -NoLogo -NoProfile -Command ". $PROFILE.CurrentUserAllHosts; 'profile ok'"
```

Windows TerminalとVS Codeを再起動し、設定が反映されていることを確認します。

## トラブルシュート

- `chezmoi`が見つからない場合は、PATH反映コマンドを再実行してからPowerShellを開き直します。
- PowerShellプロファイルの読み込みでモジュールエラーが出る場合は、該当モジュールを再インストールします。
- VS Code設定が反映されない場合は、`AppData/Roaming/Code/User/settings.json`がchezmoi管理対象になっているか確認します。
- Windows Terminal設定が反映されない場合は、Microsoft Store版のWindows Terminalを起動しているか確認します。
