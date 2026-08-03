#!/usr/bin/env bash
set -euo pipefail

# tmux-batteryのscriptディレクトリを解決します。
# 引数: なし。
# 戻り値:
#   tmux-batteryのscriptディレクトリ候補を標準出力へ出力します。
resolve_battery_scripts_dir() {
    local plugin_manager_path
    plugin_manager_path="${TMUX_PLUGIN_MANAGER_PATH:-${XDG_DATA_HOME:-${HOME}/.local/share}/tmux/plugins}"

    printf '%s\n' "${plugin_manager_path}/tmux-battery/scripts"
}

# tmux-batteryのicon取得結果かfallback iconを出力します。
# 引数: なし。
# 戻り値:
#   出力に成功した場合は0を返します。
# 副作用:
#   tmux-batteryのbattery_icon.shが存在する場合は実行します。
print_battery_icon_or_fallback() {
    local scripts_dir
    local icon
    scripts_dir="$(resolve_battery_scripts_dir)"
    icon=""

    if [ -x "${scripts_dir}/battery_icon.sh" ]; then
        icon="$("${scripts_dir}/battery_icon.sh" 2>/dev/null || true)"
    fi

    if [ -n "${icon}" ]; then
        printf '%s\n' "${icon}"
        return
    fi

    printf '%s\n' "󰂑"
}

print_battery_icon_or_fallback
