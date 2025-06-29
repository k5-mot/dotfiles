
# Self-elevate the script if required
if (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
    if ([int](Get-CimInstance -Class Win32_OperatingSystem | Select-Object -ExpandProperty BuildNumber) -ge 6000) {
        $CommandLine = "-NoExit -File `"" + $MyInvocation.MyCommand.Path + "`" " + $MyInvocation.UnboundArguments
        Start-Process -Wait -FilePath pwsh.exe -Verb Runas -ArgumentList $CommandLine
        Exit
    }
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
