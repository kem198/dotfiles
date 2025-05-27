#!/bin/bash

set -x
set -euo pipefail

###################################
# 関数定義
###################################
# 初期化処理
function init {
    : Initialize

    # パッケージアップデート
    : Update packages
    if (type "pacman"); then
        : Exists pacman
        : Update packages
        sudo pacman -Syu --noconfirm
    elif (type "apt-get"); then
        : Exists apt-get
        : Update packages
        sudo apt-get update && sudo apt-get upgrade -y
    else
        : Supported package managers not exists
        : Abort setup
        exit
    fi

    # dotfiles を clone
    : Clone dotfiles
    local DOTFILES_HOME=${HOME}/dotfiles
    if [ ! -d "${DOTFILES_HOME}" ]; then
        git clone https://github.com/kem198/dotfiles.git "${DOTFILES_HOME}" --recursive
    else
        git -C "${DOTFILES_HOME}" pull origin main
        git -C "${DOTFILES_HOME}" submodule update --init --recursive
    fi
}

# 環境情報を表示
function show_environment {
    : Display the current time
    date

    : Show system information
    uname -a

    : Show OS information
    cat /etc/os-release

    : Show current user name
    whoami

    : Show current shell
    echo "$SHELL"

    : Show environment variables
    env

    : Print working directory
    pwd
}

# ディレクトリを作成
function make_dir {
    # XDG Base Directory Specification
    local XDG_CONFIG_HOME="$HOME/.config"
    local XDG_CACHE_HOME="$HOME/.cache"
    local XDG_DATA_HOME="$HOME/.local/share"
    local XDG_STATE_HOME="$HOME/.local/state"
    mkdir -p "$XDG_CONFIG_HOME" "$XDG_CACHE_HOME" "$XDG_DATA_HOME" "$XDG_STATE_HOME"

    # zsh history
    mkdir -p "$XDG_STATE_HOME/zsh/"

    # My directory
    mkdir -p ~/works/repos/dev
}


###################################
# メイン処理
###################################
function main {
    # 初期化処理
    init

    # ヘッダー出力
    bash "${HOME}/dotfiles/setup/linux/header.sh" "Start setup"

    # 環境情報を表示
    show_environment

    # ディレクトリを作成
    make_dir

    # アプリケーションのインストール
    bash "${HOME}/dotfiles/setup/linux/install-packages.sh"
    bash "${HOME}/dotfiles/setup/linux/install-sheldon.sh"
    bash "${HOME}/dotfiles/setup/linux/install-scripts.sh"

    # シンボリックリンクを作成
    bash "${HOME}/dotfiles/setup/linux/link.sh"

    # 完了メッセージを出力
    set +x
    bash "${HOME}/dotfiles/setup/linux/header.sh" "Setup completed"
    echo
    echo "Git config:"
    git config -l
    echo
    echo "Please enter your [user.email] and [user.name] for Git."
    echo "  $ vim ~/.config/git/local"
    echo
    echo "Please set zsh to default shell."
    echo "  $ sudo chsh \"\$USER\" -s \"\$(which zsh)\""
    echo
    echo "Next, Please reboot host."
}

main
