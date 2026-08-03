#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# 指定したOSとしてchezmoi管理対象一覧を出力します。
# 引数:
#   $1: chezmoiの`.chezmoi.os`へ渡すOS名。
# 戻り値:
#   成功した場合は0を返し、管理対象一覧を標準出力へ出力します。
function managed_for_os() {
    local os_name=$1
    chezmoi managed -S "$REPO_ROOT" --override-data "{\"chezmoi\":{\"os\":\"${os_name}\"}}"
}

# 管理対象一覧に指定pathが含まれることを検証します。
# 引数:
#   $1: 改行区切りの管理対象一覧。
#   $2: 含まれるべきpath。
# 戻り値:
#   pathが含まれる場合は0、含まれない場合は非0を返します。
function assert_contains() {
    local managed=$1
    local expected_path=$2

    if ! grep -Fxq "$expected_path" <<< "$managed"; then
        printf "Expected managed path was missing: %s\n" "$expected_path" >&2
        return 1
    fi
}

# 管理対象一覧に指定pathが含まれないことを検証します。
# 引数:
#   $1: 改行区切りの管理対象一覧。
#   $2: 含まれてはいけないpath。
# 戻り値:
#   pathが含まれない場合は0、含まれる場合は非0を返します。
function assert_not_contains() {
    local managed=$1
    local rejected_path=$2

    if grep -Fxq "$rejected_path" <<< "$managed"; then
        printf "Unexpected managed path was present: %s\n" "$rejected_path" >&2
        return 1
    fi
}

linux_managed="$(managed_for_os linux)"
windows_managed="$(managed_for_os windows)"
darwin_managed="$(managed_for_os darwin)"

assert_contains "$linux_managed" ".config/nvim/init.lua"
assert_contains "$linux_managed" ".config/tmux/tmux.conf"
assert_contains "$linux_managed" ".vimrc"
assert_contains "$linux_managed" ".zshenv"
assert_not_contains "$linux_managed" ".config/vim"
assert_not_contains "$linux_managed" ".config/vim/common"
assert_not_contains "$linux_managed" "docs"
assert_not_contains "$linux_managed" "openspec"
assert_not_contains "$linux_managed" "package.json"
assert_not_contains "$linux_managed" ".devcontainer"

assert_contains "$windows_managed" "AppData/Roaming/Code/User/settings.json"
assert_contains "$windows_managed" "AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json"
assert_contains "$windows_managed" "Documents/PowerShell/Profile.ps1"
assert_not_contains "$windows_managed" ".config/nvim/init.lua"
assert_not_contains "$windows_managed" ".config/tmux/tmux.conf"
assert_not_contains "$windows_managed" ".local/script/701_setup-zinit.zsh"
assert_not_contains "$windows_managed" "docs"

if [ -n "$darwin_managed" ]; then
    printf "Darwin should not currently manage any files, but got:\n%s\n" "$darwin_managed" >&2
    exit 1
fi
