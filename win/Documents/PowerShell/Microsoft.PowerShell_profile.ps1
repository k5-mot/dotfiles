$ESC=[char]27

function prompt () {
    $host.UI.WriteLine("");
    $host.UI.WriteLine("$ESC[36m$($env:USERNAME)$ESC[0m@$ESC[34m$($env:COMPUTERNAME)$ESC[0m:$ESC[32m" + ((Get-Location).Path) + "$ESC[0m");
    $host.UI.Write("[PS]");
    " > "
}

# ついでに、初期位置を変更しておく。
#Set-Location "C:\Users\$env:USERNAME\"