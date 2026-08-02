#!/usr/bin/env bash
set -euo pipefail

TIMESTAMP="$(date +%s)"
LOG_DIR="${HOME}/.devcontainer/logs/${TIMESTAMP}"

# 指定したディレクトリが存在する場合、現在のユーザーへ所有者を変更します。
# 引数:
#   $1: 所有者を変更するディレクトリのパス。
# 戻り値:
#   成功した場合は0、失敗した場合は非0を返します。
function chown_dir() {
    local dir=$1
    if [ -d "$dir" ]; then
        sudo chown -R "$(whoami):$(whoami)" "$dir"
    fi
}

# プロジェクトごとの初期化ログを安全なファイル名へ対応付けます。
# 引数:
#   $1: ログ対象のプロジェクトディレクトリのパス。
# 戻り値:
#   成功した場合は0を返し、ログファイルのパスを標準出力へ出力します。
function project_log_file() {
    local project_dir=$1
    local project_name="${project_dir//\//_}"

    if [ "$project_name" = "." ]; then
        project_name="root"
    fi

    printf "%s/%s.log" "$LOG_DIR" "$project_name"
}

# Pythonプロジェクトの依存関係をlockfileや設定ファイルに応じて導入します。
# 引数:
#   $1: セットアップするプロジェクトディレクトリのパス。
# 戻り値:
#   セットアップまたはスキップに成功した場合は0、失敗した場合は非0を返します。
function setup_python_project() {
    local project_dir=$1
    local log_file
    log_file="$(project_log_file "$project_dir")"
    chown_dir "${project_dir}/.venv"
    mkdir -p "${LOG_DIR}"

    pushd "$project_dir"                >> "${log_file}"
    if [ -f "poetry.lock" ]; then
        # Poetry プロジェクト
        poetry install                  >> "${log_file}"
        printf "\e[36m- Completed to setup the poetry project.: \e[0m\e[36m${project_dir}\e[0m\n"
    elif [ -f "pyproject.toml" ]; then
        # uv プロジェクト
        uv python install 3.12          >> "${log_file}"
        uv sync --dev                   >> "${log_file}"
        printf "\e[36m- Completed to setup the uv(Python) project.: \e[0m\e[36m${project_dir}\e[0m\n"
    elif [ -f "requirements.txt" ]; then
        # pip プロジェクト
        pip install -r requirements.txt >> "${log_file}"
        printf "\e[36m- Completed to setup the pip project.: \e[0m\e[36m${project_dir}\e[0m\n"
    else
        printf "\e[33m- Skipped to setup Python project...: \e[0m\e[36m${project_dir}\e[0m\n"
    fi
    popd                               >> "${log_file}"
}

# Node.jsプロジェクトの依存関係をlockfileに応じて導入します。
# 引数:
#   $1: セットアップするプロジェクトディレクトリのパス。
# 戻り値:
#   セットアップまたはスキップに成功した場合は0、失敗した場合は非0を返します。
function setup_nodejs_project() {
    local project_dir=$1
    local log_file
    log_file="$(project_log_file "$project_dir")"
    chown_dir "${project_dir}/node_modules"
    mkdir -p "${LOG_DIR}"

    pushd "$project_dir" >> "${log_file}"
    if [ -f "pnpm-lock.yaml" ]; then
        # pnpm プロジェクト
        pnpm install --frozen-lockfile >> "${log_file}"
        printf "\e[36m- Completed to setup the pnpm project.: \e[0m\e[36m${project_dir}\e[0m\n"
    elif [ -f "yarn.lock" ]; then
        # yarn プロジェクト
        yarn install     >> "${log_file}"
        printf "\e[36m- Completed to setup the yarn project.: \e[0m\e[36m${project_dir}\e[0m\n"
    elif [ -f "package-lock.json" ]; then
        # npm プロジェクト
        npm install      >> "${log_file}"
        printf "\e[36m- Completed to setup the npm project.: \e[0m\e[36m${project_dir}\e[0m\n"
    else
        printf "\e[33m- Skipped to setup Node.js project...: \e[0m\e[36m${project_dir}\e[0m\n"
    fi
    popd                 >> "${log_file}"
}

# Serena MCP serverのcacheを準備し、未作成ならproject indexを作成します。
# 引数:
#   なし。
# 戻り値:
#   セットアップまたはスキップに成功した場合は0、失敗した場合は非0を返します。
function setup_serena() {
    chown_dir .serena

    if [ ! -d ".serena/cache" ]; then
        uvx --no-env-file --from git+https://github.com/oraios/serena serena project index
        printf "\e[36m- Completed to setup Serena MCP server.\e[0m\n"
    fi
}

# devcontainer作成後にcache権限と検出したプロジェクト依存関係を初期化します。
# 引数:
#   なし。
# 戻り値:
#   初期化に成功した場合は0、失敗した場合は非0を返します。
function main() {
    printf "\e[34mpostCreateCommand\e[0m\n"

    local script_start=$(date +%s%3N)

    corepack enable
    chown_dir "/usr/local/share/nvm"
    chown_dir ".pnpm-store"
    chown_dir "/home/vscode/.cache"
    chown_dir "/home/vscode/.cache/uv"
    chown_dir ".serena/cache"

    # repository rootの依存関係を先に初期化
    if [ -f "package.json" ]; then
        setup_nodejs_project "." &
    fi

    if [ -f "pyproject.toml" ]; then
        setup_python_project "." &
    fi

    # 隠しディレクトリ以外のディレクトリを探索
    for dir in */; do
        # 末尾のスラッシュを削除
        dir="${dir%/}"

        # 隠しディレクトリをスキップ
        if [[ "$dir" == .* ]]; then
            continue
        fi

        # package.jsonが存在する場合、Node.jsプロジェクトとしてセットアップ
        if [ -f "$dir/package.json" ]; then
            setup_nodejs_project "$dir" &
        fi

        # pyproject.tomlが存在する場合、Pythonプロジェクトとしてセットアップ
        if [ -f "$dir/pyproject.toml" ]; then
            setup_python_project "$dir" &
        fi
    done

    # プロジェクトのセットアップとSerenaとpre-commitのセットアップを並列実行
    setup_serena &

    # すべてのセットアップが完了するまで待機
    wait

    local script_end=$(date +%s%3N)
    local total_duration=$((script_end - script_start))
    local seconds=$((total_duration / 1000))
    local milliseconds=$((total_duration % 1000))
    printf "\e[32mSetup complete! Total time: %d.%03d [s]\e[0m\n" "$seconds" "$milliseconds"
}

main
