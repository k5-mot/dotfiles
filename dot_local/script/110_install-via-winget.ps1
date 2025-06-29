
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
    # 'jdx.mise'
    'jqlang.jq'
    'JesseDuffield.lazygit'
    'GitHub.cli'
    # 'Python.Python.3.12'
    # 'RubyInstallerTeam.Ruby.3.2'
    # 'OpenJS.NodeJS.LTS'
    # 'Rustlang.Rustup'
    # 'vim.vim'
    # 'Neovim.Neovim'
    'Docker.DockerCLI'
    # 'Docker.DockerCompose'
    # 'Kubernetes.minikube'
    # 'Kubernetes.kubectl'
    # 'eksctl.eksctl'
    # 'Microsoft.VisualStudio.2022.BuildTools'
    'AWS.AWSCLI'
    'Microsoft.AzureCLI'
    'Google.CloudSDK'
    'Microsoft.WSL'
    'Canonical.Ubuntu'
    # 'SUSE.openSUSE.Tumbleweed'
    'Oracle.OracleLinux.9.1'
)
foreach ($wingetpkg in $wingetpkgs) {
    winget install --exact --id $wingetpkg
}
