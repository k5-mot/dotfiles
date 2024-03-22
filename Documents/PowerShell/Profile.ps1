
### Prompt
function prompt() {
    $isAdmin = IsAdmin
    $color = if ($isAdmin) { "DarkRed" } else { "DarkCyan" }
    $symbol = if ($isAdmin) { "#" }   else { "$" }
    $username = $env:UserName
    $computername = $env:ComputerName.ToLower()
    $drive = $pwd.Drive.Name
    $path = $pwd.path.Replace($HOME, "~").Replace("${drive}:", "")

    Write-Host "${username}@${computername}" -ForegroundColor "DarkGreen" -NoNewline
    Write-Host ":" -NoNewline
    Write-Host "${drive}:${path}" -ForegroundColor "DarkBlue"
    Write-Host  "${symbol}" -ForegroundColor $color -NoNewline
    return " "
}

### Encoding
$PSDefaultParameterValues['*:Encoding'] = 'utf8'

### LSColor
$PSStyle.FileInfo.Directory = "`e[33;1m"

### Completion
Set-PSReadlineOption -HistoryNoDuplicates
Set-PSReadLineOption -BellStyle Visual
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineKeyHandler -Key "Tab" -Function NextSuggestion
Set-PSReadLineKeyHandler -Key "Shift+Tab" -Function PreviousSuggestion
Set-PSReadLineKeyHandler -Key "Ctrl+r" -Function SwitchPredictionView

### Environment Variables
$Env:XDG_CONFIG_HOME = Join-Path -Path $Env:USERPROFILE -ChildPath ".config"
$Env:XDG_CACHE_HOME = Join-Path -Path $Env:USERPROFILE -ChildPath ".cache"
$Env:XDG_STATE_HOME = Join-Path -Path $Env:USERPROFILE -ChildPath ".local\state"
$Env:XDG_DATA_HOME = Join-Path -Path $Env:USERPROFILE -ChildPath ".local\share"
$Env:Path = $Env:Path + ";C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.39.33519\bin\HostX64\x64;C:\Program Files\Microsoft Visual Studio\2022\Community\Common7\IDE\VC\VCPackages;C:\Program Files\Microsoft Visual Studio\2022\Community\Common7\IDE\CommonExtensions\Microsoft\TestWindow;C:\Program Files\Microsoft Visual Studio\2022\Community\Common7\IDE\CommonExtensions\Microsoft\TeamFoundation\Team Explorer;C:\Program Files\Microsoft Visual Studio\2022\Community\MSBuild\Current\bin\Roslyn;C:\Program Files (x86)\Microsoft SDKs\Windows\v10.0A\bin\NETFX 4.8 Tools\x64\;C:\Program Files\Microsoft Visual Studio\2022\Community\Common7\IDE\CommonExtensions\Microsoft\FSharp\Tools;C:\Program Files\Microsoft Visual Studio\2022\Community\Team Tools\DiagnosticsHub\Collector;C:\Program Files (x86)\Windows Kits\10\bin\10.0.22621.0\\x64;C:\Program Files (x86)\Windows Kits\10\bin\\x64;C:\Program Files\Microsoft Visual Studio\2022\Community\\MSBuild\Current\Bin\amd64;C:\Windows\Microsoft.NET\Framework64\v4.0.30319;C:\Program Files\Microsoft Visual Studio\2022\Community\Common7\IDE\;C:\Program Files\Microsoft Visual Studio\2022\Community\Common7\Tools\;C:\Program Files\Microsoft\jdk-11.0.22.7-hotspot\bin;C:\Program Files (x86)\VMware\VMware Player\bin\;C:\Program Files\Volta\;C:\Windows\system32;C:\Windows;C:\Windows\System32\Wbem;C:\Windows\System32\WindowsPowerShell\v1.0\;C:\Windows\System32\OpenSSH\;C:\Program Files (x86)\NVIDIA Corporation\PhysX\Common;C:\Program Files\NVIDIA Corporation\NVIDIA NvDLISR;C:\Program Files\TortoiseGit\bin;C:\Program Files\PowerShell\7\;C:\Program Files\MySQL\MySQL Server 8.0\bin;C:\Program Files\Amazon\SessionManagerPlugin\bin\;C:\Program Files\Git\cmd;C:\Program Files\Amazon\AWSCLIV2\;C:\Program Files\nodejs\;C:\Program Files\Kubernetes\Minikube;C:\Program Files\LLVM\bin;C:\Program Files\dotnet\;C:\Program Files (x86)\Windows Kits\10\Windows Performance Toolkit\;C:\Users\merry\AppData\Local\Programs\Python\Python312\Scripts\;C:\Users\merry\AppData\Local\Programs\Python\Python312\;C:\Users\merry\AppData\Local\Programs\Python\Launcher\;C:\Users\merry\AppData\Local\Volta\bin;C:\Users\merry\AppData\Local\Programs\Python\Python39\Scripts\;C:\Users\merry\AppData\Local\Programs\Python\Python39\;C:\Users\merry\AppData\Local\Microsoft\WindowsApps;C:\Users\merry\AppData\Local\GitHubDesktop\bin;C:\Users\merry\AppData\Local\Programs\Microsoft VS Code\bin;C:\Users\merry\AppData\Local\Programs\oh-my-posh\bin;C:\Program Files\Neovim\bin;C:\Users\merry\AppData\Local\Microsoft\WinGet\Packages\twpayne.chezmoi_Microsoft.Winget.Source_8wekyb3d8bbwe;C:\Users\merry\AppData\Roaming\npm;C:\Users\merry\AppData\Local\Microsoft\WinGet\Links;C:\Users\merry\.dotnet\tools;C:\Program Files\Microsoft Visual Studio\2022\Community\Common7\IDE\CommonExtensions\Microsoft\CMake\CMake\bin;C:\Program Files\Microsoft Visual Studio\2022\Community\Common7\IDE\CommonExtensions\Microsoft\CMake\Ninja;C:\Program Files\Microsoft Visual Studio\2022\Community\Common7\IDE\VC\Linux\bin\ConnectionManagerExe;C:\Program Files\Microsoft Visual Studio\2022\Community\VC\vcpkg"
$Env:INCLUDE = "C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.39.33519\include;C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.39.33519\ATLMFC\include;C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\VS\include;C:\Program Files (x86)\Windows Kits\10\include\10.0.22621.0\ucrt;C:\Program Files (x86)\Windows Kits\10\\include\10.0.22621.0\\um;C:\Program Files (x86)\Windows Kits\10\\include\10.0.22621.0\\shared;C:\Program Files (x86)\Windows Kits\10\\include\10.0.22621.0\\winrt;C:\Program Files (x86)\Windows Kits\10\\include\10.0.22621.0\\cppwinrt;C:\Program Files (x86)\Windows Kits\NETFXSDK\4.8\include\um"
$Env:LIB = "C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.39.33519\ATLMFC\lib\x64;C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.39.33519\lib\x64;C:\Program Files (x86)\Windows Kits\NETFXSDK\4.8\lib\um\x64;C:\Program Files (x86)\Windows Kits\10\lib\10.0.22621.0\ucrt\x64;C:\Program Files (x86)\Windows Kits\10\\lib\10.0.22621.0\\um\x64"

### Alias
$profiledir = $(Get-Item $PROFILE.CurrentUserAllHosts).DirectoryName
$scriptsdir = $(Join-Path $profiledir 'Scripts')
$vimbindir = $(Get-ChildItem "C:\Program Files\Vim" | Sort-Object -Descending -Property Name | Select-Object -first 1).FullName
$vimexe = Join-Path -Path $vimbindir -ChildPath "vim.exe"
$gvimexe = Join-Path -Path $vimbindir -ChildPath "gvim.exe"
Set-Alias unzip Expand-Archive
Set-Alias touch New-Item
Set-Alias vi  "$vimexe"
Set-Alias vim "$vimexe"
Set-Alias gvim "$gvimexe"
Set-Alias Edit-Profile             $(Join-Path $scriptsdir 'Edit-Profile.ps1')
Set-Alias Get-Timestamp            $(Join-Path $scriptsdir 'Get-Timestamp.ps1')
Set-Alias Install-Fonts            $(Join-Path $scriptsdir 'Install-Fonts.ps1')
Set-Alias Install-PSModule         $(Join-Path $scriptsdir 'Install-PSModule.ps1')
Set-Alias Install-VSCodeExtensions $(Join-Path $scriptsdir 'Install-VSCodeExtensions.ps1')
Set-Alias Install-WingetPackages   $(Join-Path $scriptsdir 'Install-WingetPackages.ps1')
Set-Alias Install-WSL              $(Join-Path $scriptsdir 'Install-WSL.ps1')
Set-Alias Invoke-AsAdmin           $(Join-Path $scriptsdir 'Invoke-AsAdmin.ps1')
Set-Alias Publish-SymbolicLink     $(Join-Path $scriptsdir 'Publish-SymbolicLink.ps1')
Set-Alias Test-Admin               $(Join-Path $scriptsdir 'Test-Admin.ps1')
Set-Alias Test-ExistCommand        $(Join-Path $scriptsdir 'Test-ExistCommand.ps1')
Set-Alias Test-ExistPSModule       $(Join-Path $scriptsdir 'Test-ExistPSModule.ps1')
Set-Alias Test-ReparsePoint        $(Join-Path $scriptsdir 'Test-ReparsePoint.ps1')
Set-Alias which                    $(Join-Path $scriptsdir 'which.ps1')

Register-ArgumentCompleter -Native -CommandName aws -ScriptBlock {
    param($commandName, $wordToComplete, $cursorPosition)
    $env:COMP_LINE = $wordToComplete
    if ($env:COMP_LINE.Length -lt $cursorPosition) {
        $env:COMP_LINE = $env:COMP_LINE + " "
    }
    $env:COMP_POINT = $cursorPosition
    aws_completer.exe | ForEach-Object {
        [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
    }
    Remove-Item Env:\COMP_LINE
    Remove-Item Env:\COMP_POINT
}

### Local Configs
$loaddir = "$env:USERPROFILE\Documents\PowerShell\Autoload"
Get-ChildItem $loaddir | Where-Object Extension -eq ".ps1" | ForEach-Object { . $_.FullName }

### Oh-My-Posh
if (Test-ExistCommand 'oh-my-posh') {
    oh-my-posh init pwsh --config $env:POSH_THEMES_PATH/spaceship.omp.json | Invoke-Expression
}

# ### PowerShell Module
# # URL: https://www.powershellgallery.com/
# ### PowerShell Modules
$psmodules = @(
    'posh-git'
    'Terminal-Icons'
    'PSReadLine'
    'CompletionPredictor'
)
foreach ($psmodule in $psmodules) {
    if (Test-ExistPSModule $psmodule) {
        Import-Module $psmodule
    }
}
