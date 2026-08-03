#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# mise shimがXDG_CONFIG_HOME変更後に別configを見ないよう、実体commandを優先して解決します。
# 引数:
#   $1: 解決するcommand名。
# 戻り値:
#   command pathを解決できた場合は0、解決できない場合は非0を返します。
resolve_command_path() {
    local command_name=$1

    if command -v mise >/dev/null 2>&1 && mise which "${command_name}" >/dev/null 2>&1; then
        mise which "${command_name}"
        return 0
    fi

    command -v "${command_name}"
}

# Neovim起動ログにLua startup errorが含まれないことを検証します。
# 引数:
#   $1: 検証対象のログファイルパス。
# 戻り値:
#   起動エラーが含まれない場合は0、含まれる場合は非0を返します。
assert_no_nvim_startup_error() {
    local log_file=$1

    if grep -Eq 'Error in .*/nvim/init\.lua|E5113:' "$log_file"; then
        grep -En 'Error in .*/nvim/init\.lua|E5113:' "$log_file"
        return 1
    fi
}

# Vim設定を実際のvim commandで読み込めることを確認します。
# 引数: なし。
# 戻り値: 読み込みに成功した場合は0、失敗した場合は非0を返します。
test_vim_config() {
    local vim_command
    vim_command="$(resolve_command_path vim)"

    "${vim_command}" -Nu "${repo_root}/dot_vimrc" -n -es +'set nomore' +qall
}

# Neovim設定とlazy.nvim pluginを実際のnvim commandで同期して読み込めることを確認します。
# 引数: なし。
# 戻り値: 同期と読み込みに成功した場合は0、失敗した場合は非0を返します。
test_nvim_config() {
    local nvim_command
    local temp_dir
    local log_file
    nvim_command="$(resolve_command_path nvim)"
    temp_dir="$(mktemp -d)"
    log_file="${temp_dir}/nvim.log"

    (
        export XDG_CONFIG_HOME="${temp_dir}/config"
        export XDG_DATA_HOME="${temp_dir}/data"
        export XDG_CACHE_HOME="${temp_dir}/cache"
        export XDG_STATE_HOME="${temp_dir}/state"

        mkdir -p "${XDG_CONFIG_HOME}" "${XDG_DATA_HOME}" "${XDG_CACHE_HOME}" "${XDG_STATE_HOME}"
        ln -s "${repo_root}/dot_config/nvim" "${XDG_CONFIG_HOME}/nvim"

        "${nvim_command}" --headless "+Lazy! sync" +qa >"${log_file}" 2>&1 || {
            cat "${log_file}"
            return 1
        }
        "${nvim_command}" --headless +qa >>"${log_file}" 2>&1 || {
            cat "${log_file}"
            return 1
        }
        assert_no_nvim_startup_error "${log_file}"
    )
}

# zsh設定とzinit pluginを実際のzsh commandで読み込めることを確認します。
# 引数: なし。
# 戻り値: 読み込みに成功した場合は0、失敗した場合は非0を返します。
test_zsh_config() {
    local zsh_command
    local temp_dir
    local log_file
    zsh_command="$(resolve_command_path zsh)"
    temp_dir="$(mktemp -d)"
    log_file="${temp_dir}/zsh.log"

    HOME="${temp_dir}" \
    XDG_DATA_HOME="${temp_dir}/.local/share" \
    XDG_CACHE_HOME="${temp_dir}/.cache" \
    XDG_STATE_HOME="${temp_dir}/.local/state" \
    XDG_CONFIG_HOME="${temp_dir}/.config" \
        "${zsh_command}" -f -c "source '${repo_root}/dot_config/zsh/dot_zshenv'; source '${repo_root}/dot_config/zsh/zinit.zsh'" >"${log_file}" 2>&1 || {
            cat "${log_file}"
            return 1
        }
}

# tmux通常設定とslim設定を実際のtmux commandで読み込めることを確認します。
# 引数: なし。
# 戻り値: 読み込みに成功した場合は0、失敗した場合は非0を返します。
test_tmux_config() {
    local tmux_command
    tmux_command="$(resolve_command_path tmux)"

    "${tmux_command}" -f /dev/null -L dotfiles-command-check start-server \; \
        source-file -n "${repo_root}/dot_config/tmux/tmux.conf" \; \
        new-session -d -s dotfiles-command-check \; \
        display-message -p "#{session_name}" \; \
        kill-server

    "${tmux_command}" -f /dev/null -L dotfiles-slim-command-check start-server \; \
        source-file -n "${repo_root}/dot_config/tmux/tmux.slim.conf" \; \
        new-session -d -s dotfiles-slim-command-check \; \
        display-message -p "#{session_name}" \; \
        kill-server
}

test_vim_config
test_nvim_config
test_zsh_config
test_tmux_config
