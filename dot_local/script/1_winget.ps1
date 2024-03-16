
# Self-elevate the script if required
if (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
    if ([int](Get-CimInstance -Class Win32_OperatingSystem | Select-Object -ExpandProperty BuildNumber) -ge 6000) {
        $CommandLine = "-NoExit -File `"" + $MyInvocation.MyCommand.Path + "`" " + $MyInvocation.UnboundArguments
        Start-Process -Wait -FilePath pwsh.exe -Verb Runas -ArgumentList $CommandLine
        Exit
    }
}


### Policy for running scripts
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
Write-Output $PSVersionTable


### Winget Packages
$wingetpkgs = @(
    'Microsoft.PowerShell'
    'Microsoft.WindowsTerminal'
    'Microsoft.VisualStudioCode'
    'Git.Git'
    'JanDeDobbeleer.OhMyPosh'
    'OBSProject.OBSStudio'
    'NickeManarin.ScreenToGif'
    'TortoiseGit.TortoiseGit'
    'Python.Python.3.12'
    'OpenJS.NodeJS'
    'vim.vim'
    'Neovim.Neovim'
    'Rustlang.Rustup'
    'Docker.DockerCLI'
    'Docker.DockerCompose'
    'Kubernetes.minikube'
    'Kubernetes.kubectl'
    'eksctl.eksctl'
    'Microsoft.VisualStudio.2022.BuildTools'
)
foreach ($wingetpkg in $wingetpkgs) {
    winget install --exact --id $wingetpkg
}


### PowerShell Modules
$psmodules = @(
    'posh-git'
    'Terminal-Icons'
    'PSReadLine'
    'CompletionPredictor'
)
Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
foreach ($psmodule in $psmodules) {
    Install-Module -Name $psmodule -Scope CurrentUser
}


### Fonts
$fonts = @(
    'CascadiaCode'
    'CascadiaMono'
    'FiraCode'
    'FiraMono'
    'Meslo'
    'Noto'
)
foreach ($font in $fonts) {
    oh-my-posh font install $font
}


### VSCode Extensions
$vsexts = @(
    'formulahendry.auto-rename-tag'
    'ms-vscode.cpptools'
    'ms-vscode.cpptools-extension-pack'
    'ms-azuretools.vscode-docker'
    'dsznajder.es7-react-js-snippets'
    'dbaeumer.vscode-eslint'
    'eamodio.gitlens'
    'visualstudioexptteam.vscodeintellicode'
    'ms-toolsai.jupyter'
    'ms-vscode.live-server'
    'ritwickdey.liveserver'
    'ms-vsliveshare.vsliveshare'
    'yzhang.markdown-all-in-one'
    'zhuangtongfa.material-theme'
    'ms-vscode.powershell'
    'esbenp.prettier-vscode'
    'ms-python.python'
    'ms-python.vscode-pylance'
    'ms-vscode-remote.vscode-remote-extensionpack'
    'ms-vscode.remote-explorer'
    'pkief.material-icon-theme'
    'shd101wyy.markdown-preview-enhanced'
    'christian-kohler.path-intellisense'
)
foreach ($vsext in $vsexts) {
    code --install-extension $vsext
}
