<#
.SYNOPSIS
現在のPowerShellセッションが管理者権限かどうかを判定します。

.DESCRIPTION
プロンプトの表示を切り替えるために、現在のWindows IDがAdministratorロールに属しているかを確認します。

.OUTPUTS
System.Boolean。管理者権限で実行中ならTrue、それ以外ならFalseを返します。
#>
function Test-CurrentUserAdministrator {
    $identity = [System.Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = [System.Security.Principal.WindowsPrincipal]::new($identity)
    return $principal.IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator)
}

<#
.SYNOPSIS
指定したコマンドを現在のセッションで実行できるかを判定します。

.DESCRIPTION
任意ツールの初期化を安全に行うために、PATH上に対象コマンドが存在するかを確認します。

.PARAMETER Name
存在確認するコマンド名を指定します。

.OUTPUTS
System.Boolean。コマンドが見つかればTrue、見つからなければFalseを返します。
#>
function Test-CommandExists {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Name
    )

    return [bool](Get-Command -Name $Name -ErrorAction SilentlyContinue)
}

<#
.SYNOPSIS
ユーザー名、ホスト名、現在地、権限を含むプロンプト文字列を描画します。

.DESCRIPTION
管理者権限のセッションを見分けやすくするために、権限に応じて色と記号を変えて表示します。

.OUTPUTS
System.String。PowerShellがプロンプト末尾に表示する空白を返します。

.SIDE_EFFECTS
Write-Hostでプロンプト本体を標準出力へ描画します。
#>
function prompt {
    $isAdmin = Test-CurrentUserAdministrator
    $color = if ($isAdmin) { "DarkRed" } else { "DarkCyan" }
    $symbol = if ($isAdmin) { "#" } else { "$" }
    $username = $env:UserName
    $computername = $env:ComputerName.ToLower()
    $drive = $pwd.Drive.Name
    $path = $pwd.Path.Replace($HOME, "~").Replace("${drive}:", "")

    Write-Host "${username}@${computername}" -ForegroundColor "DarkGreen" -NoNewline
    Write-Host ":" -NoNewline
    Write-Host "${drive}:${path}" -ForegroundColor "DarkBlue"
    Write-Host "${symbol}" -ForegroundColor $color -NoNewline
    return " "
}

$PSDefaultParameterValues["*:Encoding"] = "utf8"

if ($PSStyle -and $PSStyle.FileInfo) {
    $PSStyle.FileInfo.Directory = "`e[33;1m"
}

if (Get-Module -ListAvailable -Name PSReadLine) {
    try {
        Set-PSReadLineOption -HistoryNoDuplicates
        Set-PSReadLineOption -BellStyle Visual
        Set-PSReadLineOption -PredictionViewStyle ListView
        Set-PSReadLineKeyHandler -Key "Tab" -Function NextSuggestion
        Set-PSReadLineKeyHandler -Key "Shift+Tab" -Function PreviousSuggestion
        Set-PSReadLineKeyHandler -Key "Ctrl+r" -Function SwitchPredictionView
    }
    catch {
        Write-Verbose "PSReadLineの一部設定をこの環境では適用できません。"
    }
}

$Env:XDG_CONFIG_HOME = Join-Path -Path $Env:USERPROFILE -ChildPath ".config"
$Env:XDG_CACHE_HOME = Join-Path -Path $Env:USERPROFILE -ChildPath ".cache"
$Env:XDG_STATE_HOME = Join-Path -Path $Env:USERPROFILE -ChildPath ".local\state"
$Env:XDG_DATA_HOME = Join-Path -Path $Env:USERPROFILE -ChildPath ".local\share"

Set-Alias unzip Expand-Archive
Set-Alias touch New-Item

if (Test-CommandExists "aws_completer.exe") {
    Register-ArgumentCompleter -Native -CommandName aws -ScriptBlock {
        param($commandName, $wordToComplete, $cursorPosition)
        $env:COMP_LINE = $wordToComplete
        if ($env:COMP_LINE.Length -lt $cursorPosition) {
            $env:COMP_LINE = $env:COMP_LINE + " "
        }
        $env:COMP_POINT = $cursorPosition
        aws_completer.exe | ForEach-Object {
            [System.Management.Automation.CompletionResult]::new($_, $_, "ParameterValue", $_)
        }
        Remove-Item Env:\COMP_LINE
        Remove-Item Env:\COMP_POINT
    }
}

if (Test-CommandExists "oh-my-posh") {
    $ohMyPoshConfig = Join-Path -Path $Env:LOCALAPPDATA -ChildPath "oh-my-posh\config.json"
    if (Test-Path $ohMyPoshConfig) {
        oh-my-posh init pwsh --config $ohMyPoshConfig | Invoke-Expression
    }
}

@(
    "posh-git"
    "Terminal-Icons"
    "PSReadLine"
    "CompletionPredictor"
) | ForEach-Object {
    Import-Module $_ -ErrorAction Stop
}
