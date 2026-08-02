#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Vim設定を実際のvim commandで読み込めることを確認します。
# 引数: なし。
# 戻り値: 読み込みに成功した場合は0、失敗した場合は非0を返します。
test_vim_config() {
    vim -Nu "${repo_root}/dot_config/vim/init.vim" -n -es +'set nomore' +qall
}

# Neovim設定とlazy.nvim pluginを実際のnvim commandで同期して読み込めることを確認します。
# 引数: なし。
# 戻り値: 同期と読み込みに成功した場合は0、失敗した場合は非0を返します。
test_nvim_config() {
    local temp_dir
    local log_file
    temp_dir="$(mktemp -d)"
    log_file="${temp_dir}/nvim.log"
    export XDG_CONFIG_HOME="${temp_dir}/config"
    export XDG_DATA_HOME="${temp_dir}/data"
    export XDG_CACHE_HOME="${temp_dir}/cache"
    export XDG_STATE_HOME="${temp_dir}/state"

    mkdir -p "${XDG_CONFIG_HOME}" "${XDG_DATA_HOME}" "${XDG_CACHE_HOME}" "${XDG_STATE_HOME}"
    ln -s "${repo_root}/dot_config/nvim" "${XDG_CONFIG_HOME}/nvim"

    nvim --headless "+Lazy! sync" +qa >"${log_file}" 2>&1 || {
        cat "${log_file}"
        return 1
    }
    nvim --headless +qa >>"${log_file}" 2>&1 || {
        cat "${log_file}"
        return 1
    }
}

# zsh設定とzinit pluginを実際のzsh commandで読み込めることを確認します。
# 引数: なし。
# 戻り値: 読み込みに成功した場合は0、失敗した場合は非0を返します。
test_zsh_config() {
    local temp_dir
    local log_file
    temp_dir="$(mktemp -d)"
    log_file="${temp_dir}/zsh.log"

    HOME="${temp_dir}" \
    XDG_DATA_HOME="${temp_dir}/.local/share" \
    XDG_CACHE_HOME="${temp_dir}/.cache" \
    XDG_STATE_HOME="${temp_dir}/.local/state" \
    XDG_CONFIG_HOME="${temp_dir}/.config" \
        zsh -f -c "source '${repo_root}/dot_config/zsh/dot_zshenv'; source '${repo_root}/dot_config/zsh/zinit.zsh'" >"${log_file}" 2>&1 || {
            cat "${log_file}"
            return 1
        }
}

# tmux通常設定とslim設定を実際のtmux commandで読み込めることを確認します。
# 引数: なし。
# 戻り値: 読み込みに成功した場合は0、失敗した場合は非0を返します。
test_tmux_config() {
    tmux -f /dev/null -L dotfiles-command-check start-server \; \
        source-file -n "${repo_root}/dot_config/tmux/tmux.conf" \; \
        new-session -d -s dotfiles-command-check \; \
        display-message -p "#{session_name}" \; \
        kill-server

    tmux -f /dev/null -L dotfiles-slim-command-check start-server \; \
        source-file -n "${repo_root}/dot_config/tmux/tmux.slim.conf" \; \
        new-session -d -s dotfiles-slim-command-check \; \
        display-message -p "#{session_name}" \; \
        kill-server
}

test_vim_config
test_nvim_config
test_zsh_config
test_tmux_config
