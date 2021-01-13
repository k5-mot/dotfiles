## Set up　variables.
$ESC=[char]27

## Set up aliases.
set-alias cat        get-content
#set-alias cd         set-location
set-alias clear      clear-host
#set-alias cp         copy-item
set-alias h          get-history
set-alias history    get-history
set-alias kill       stop-process
set-alias lp         out-printer
set-alias ls         get-childitem
set-alias mount      new-mshdrive
set-alias mv         move-item
#set-alias popd       pop-location
set-alias ps         get-process
#set-alias pushd      push-location
set-alias pwd        get-location
set-alias r          invoke-history
#set-alias rm         remove-item
#set-alias rmdir      remove-item
#set-alias echo       write-output

set-alias cls        clear-host
set-alias chdir      set-location
#set-alias copy       copy-item
#set-alias del        remove-item
#set-alias dir        get-childitem
set-alias erase      remove-item
#set-alias move       move-item
set-alias rd         remove-item
set-alias ren        rename-item
set-alias set        set-variable
set-alias type       get-content

## Set up functions.
function rm()
{
    Remove-Item -Recurse -Force $args
}

function help()
{
    get-help $args[0] | out-host -paging
}

function man()
{
    get-help $args[0] | out-host -paging
}

function mkdir()
{
    new-item -type directory -path $args
}

function md()
{
    new-item -type directory -path $args
}

function ..()
{
  cd ../
}

function el()
{
    explorer .
}

function pwdc()
{
    Set-Clipboard "$pwd"
}

function mkd()
{
    mkdir $args | Out-Null
}

function elevate-process
{
    $file, [string]$arguments = $args;
    $psi = new-object System.Diagnostics.ProcessStartInfo $file;
    $psi.Arguments = $arguments;
    $psi.Verb = "runas";
    $psi.WorkingDirectory = get-location;
    [System.Diagnostics.Process]::Start($psi);
}

set-alias sudo elevate-process;

function show_profile()
{
    echo $Profile.AllUsersAllHosts
    echo $Profile.AllUsersCurrentHost
    echo $Profile.CurrentUserAllHosts
    echo $Profile.CurrentUserCurrentHost
}

function show_env()
{
    Get-ChildItem env:
}

## Set up Prompt
function prompt()
{
    $isRoot = (([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
    $color  = if ($isRoot) {"Red"} else {"Green"}
    $marker = if ($isRoot) {" # "}   else {" $ "}

    Write-Host ""                  -ForegroundColor "White"
    Write-Host "$env:USERNAME"     -ForegroundColor "Green" -NoNewline
    Write-Host "@"                 -ForegroundColor "White" -NoNewline
    Write-Host "$env:COMPUTERNAME" -ForegroundColor "Blue"  -NoNewline
    Write-Host ":"                 -ForegroundColor "White" -NoNewline
    Write-Host (Get-Location).Path -ForegroundColor "Cyan"
    Write-Host "[PS]"              -ForegroundColor "White" -NoNewline
    Write-Host $marker             -ForegroundColor $color  -NoNewline
    return " "
}

# Set up initial location.
Set-Location "$env:HOMEDRIVE/$env:HOMEPATH"
