#!/bin/bash

set -x
set -euo pipefail

# apt でインストールする
function install_with_apt {
    # パッケージリストの取得・既存パッケージの更新
    sudo apt-get update && sudo apt-get upgrade -y

    # インストール
    sudo apt-get install -y "${packages[@]}"

    # Git は PPA からインストールし直す
    # https://loumo.jp/archives/23149
    sudo add-apt-repository -y ppa:git-core/ppa
    sudo apt-get install -y git

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
    # インストールするパッケージの配列を定義
    packages=(
        "cppcheck"
        "curl"
        "gcc"
        "git"
        "neofetch"
        "pwgen"
        "tree"
        "wget"
        "zsh"
    )

    # 利用するパッケージマネージャをディストリビューションごとに切り替える
    case `cat /etc/issue` in
        Arch*)
            : Arch Linux
            : add packages for pacman
            packages+=(
                "openssh"
                "pacman-contrib"
                "which"
            )
            : Install with pacman
            install_with_pacman
        ;;

        *)
            : Default
            : add packages for apt
            # Ubuntu 用パッケージを配列へ追加
            packages+=(
                "openssh-server"
                "software-properties-common"
            )
            : Install with apt
            install_with_apt
        ;;
    esac

    set +x
    echo
    echo "Finished: $0"
}

main
