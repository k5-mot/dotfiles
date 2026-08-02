$ErrorActionPreference = "Stop"

$repoRoot = Resolve-Path (Join-Path -Path $PSScriptRoot -ChildPath "..")
$profilePath = Join-Path -Path $repoRoot -ChildPath "Documents/PowerShell/Profile.ps1"
$errors = $null

[System.Management.Automation.Language.Parser]::ParseFile($profilePath, [ref]$null, [ref]$errors) > $null

if ($errors.Count -gt 0) {
    $errors | ForEach-Object { Write-Error $_.Message }
    exit 1
}
