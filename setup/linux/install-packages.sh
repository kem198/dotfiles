#!/bin/bash

set -x
set -euo pipefail
bash "${HOME}/dotfiles/setup/linux/header.sh" "Run: $0"

# apt でインストールする
function install_with_apt {
    # パッケージリストの取得・既存パッケージの更新
    sudo apt-get update && sudo apt-get upgrade -y

    # インストール
    sudo apt-get install -y "${packages[@]}"

    # Git は PPA からインストールし直す
    # https://loumo.jp/archives/23149
    sudo add-apt-repository -y ppa:git-core/ppa
    sudo apt-get update && sudo apt-get upgrade -y

    # パッケージのキャッシュを削除
    sudo apt-get autoclean -y
}

# pacman でインストールする
function install_with_pacman {
    # [pacman - ArchWiki](https://wiki.archlinux.jp/index.php/Pacman)

    # パッケージリストの取得・既存パッケージの更新
    sudo pacman -Syu --noconfirm

    # インストール
    sudo pacman -S --noconfirm "${packages[@]}"

    # パッケージのキャッシュを削除
    paccache -rk1   # 最も新しいバージョン1つだけを保持
    paccache -ruk0  # アンインストールされたパッケージのキャッシュを全て削除
}

function main {
    # 環境共通でインストールするパッケージ
    local packages=(
        "cppcheck"
        "curl"
        "git"
        "jq"
        "pwgen"
        "patch"
        "translate-shell"
        "tree"
        "vim"
        "wget"
        "zsh"
    )

    # 利用するパッケージマネージャの分岐
    if (type "pacman"); then
        : Exists pacman
        : add packages for pacman
        local packages+=(
            "base-devel"
            "openssh"
            "pacman-contrib"
            "which"
        )
        # Manjaro Linux の場合のみ yay を追加
        # Arch Linux では pacman のリポジトリに存在しないため
        # https://furuya7.hatenablog.com/entry/2020/05/06/180426
        #
        case `cat /etc/issue` in
            Manjaro*)
                # Manjaro は pacman でサポートされているので配列へ追加する
                : Manjaro Linux
                : Add yay to install packages
                local packages+=(
                    "yay"
                )
            ;;
        esac
        : Install with pacman
        install_with_pacman

    elif (type "apt-get"); then
        : Exists apt-get
        : add packages for apt
        local packages+=(
            "build-essential"
            "neofetch"
            "openssh-server"
            "software-properties-common"
        )
        : Install with apt
        install_with_apt

    else
        : Supported package managers not exists
        : Abort setup
        exit
    fi

    set +x
    echo
    echo "Finished: $0"
}

main
