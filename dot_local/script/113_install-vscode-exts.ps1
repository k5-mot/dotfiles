
# Self-elevate the script if required
if (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
    if ([int](Get-CimInstance -Class Win32_OperatingSystem | Select-Object -ExpandProperty BuildNumber) -ge 6000) {
        $CommandLine = "-NoExit -File `"" + $MyInvocation.MyCommand.Path + "`" " + $MyInvocation.UnboundArguments
        Start-Process -Wait -FilePath pwsh.exe -Verb Runas -ArgumentList $CommandLine
        Exit
    }
}

### VSCode Extensions
$vsexts = @(
    'github.copilot'
    'github.copilot-chat'
    'saoudrizwan.claude-dev'
    'pkief.material-icon-theme'
    'zhuangtongfa.material-theme'
    'ms-vscode-remote.vscode-remote-extensionpack'
    'ms-vscode.remote-explorer'
    'ms-vscode-remote.remote-ssh-edit'
    # 'formulahendry.auto-rename-tag'
    # 'ms-vscode.cpptools'
    # 'ms-vscode.cpptools-extension-pack'
    # 'ms-azuretools.vscode-docker'
    # 'dsznajder.es7-react-js-snippets'
    # 'dbaeumer.vscode-eslint'
    # 'eamodio.gitlens'
    # 'visualstudioexptteam.vscodeintellicode'
    # 'ms-toolsai.jupyter'
    # 'ms-vscode.live-server'
    # 'ritwickdey.liveserver'
    # 'ms-vsliveshare.vsliveshare'
    # 'yzhang.markdown-all-in-one'
    # 'zhuangtongfa.material-theme'
    # 'ms-vscode.powershell'
    # 'esbenp.prettier-vscode'
    # 'ms-python.python'
    # 'ms-python.vscode-pylance'
    # 'ms-vscode-remote.vscode-remote-extensionpack'
    # 'ms-vscode.remote-explorer'
    # 'pkief.material-icon-theme'
    # 'shd101wyy.markdown-preview-enhanced'
    # 'christian-kohler.path-intellisense'
)
foreach ($vsext in $vsexts) {
    code --install-extension $vsext
}
