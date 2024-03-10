########################################
# Linux Commands
########################################
# alias
alias ag="alias | grep"

# cat
# バージョン情報を表示
show-env-ver() {
    echo "---------- on Linux ----------"
    echo "$ cat /etc/os-release"
    cat /etc/os-release

    if uname -r | grep -i 'microsoft' > /dev/null ; then
        echo "---------- on Windows ----------"
        echo "PS > powershell.exe Get-WmiObject Win32_OperatingSystem"
        powershell.exe Get-WmiObject Win32_OperatingSystem

        echo "PS > powershell.exe wsl --version"
        powershell.exe wsl --version
    fi
}

# cd
alias dev="cd ~/works/develop"
alias dot="cd ~/dotfiles"
alias note="cd ~/works/notes"
alias gr='cd "$(git rev-parse --show-toplevel)"'

# clear
alias c="clear"

# curl
alias wttr="curl wttr.in/${WTTR_LOCALE}"
alias wttrs="curl 'wttr.in/${WTTR_LOCALE}?0Q'"

# date
alias dt="date +'%F %T'"         # 現在日時を yyyy-MM-dd hh:mm:ss 形式で表示
alias dts="date +'%Y%m%d%H%M%S'" # 現在日時を yyyyMMddhhmmss 形式で表示
alias dtss="date +'%Y%m%d'"      # 現在日時を yyyyMMdd 形式で表示

# env
# 言語を一時的に変更してコマンドを実行する
# $ ja man ls
alias ja="env LANG=ja_JP.UTF-8"
alias en="env LANG=en_US.UTF-8"

# diff
alias diffy="diff -ry --exclude=.git --color"
alias diffys="diffy --suppress-common-lines"

# grep
# 環境変数での色設定 (export GREP_OPTIONS="--color=auto") は
# サポートされなくなったそうなのでエイリアスで設定する
alias grep="grep --color=auto"
alias fgrep="fgrep --color=auto"
alias egrep="egrep --color=auto"

# note 配下を grep 検索
ng() {
    grep -rnI $1 ~/works/notes/notes/*
}

# history
alias h="history"
alias hg="history -800 | grep"

# ls
alias ll="ls -lhG --file-type --color=auto --time-style=long-iso --group-directories-first"
alias lla="ls -alhG --file-type --color=auto --time-style=long-iso --group-directories-first"

# seq
alias seq100="seq -w 1 100" # 001 ～ 100 を表示

# source
alias ss="source $XDG_CONFIG_HOME/zsh/.zshrc"

# 環境情報を表示
function showenv {
    set -x

    : ----------------------------------------
    : Display the current time
    : ----------------------------------------
    date

    : ----------------------------------------
    : Show System Information
    : ----------------------------------------
    uname -a

    : ----------------------------------------
    : Show OS Information
    : ----------------------------------------
    cat /etc/os-release

    : ----------------------------------------
    : Show current user name
    : ----------------------------------------
    whoami

    : ----------------------------------------
    : Show current shell
    : ----------------------------------------
    echo $SHELL

    : ----------------------------------------
    : Show Environment Variables
    : ----------------------------------------
    env

    : ----------------------------------------
    : Print Working Directory
    : ----------------------------------------
    pwd
}

########################################
# C
########################################
alias a="./a.out"


########################################
# Docker
########################################
alias dst="sudo service docker status"                              # Docker デーモンの起動状況を確認
alias dsta="sudo service docker start ; sudo service docker status" # Docker デーモンを起動
alias dsto="sudo service docker stop ; sudo service docker status"  # Docker デーモンを停止

alias d="docker"
alias dc="docker compose"
alias drmn="docker image prune -f" # <none> イメージを一括削除 https://codechord.com/2019/08/docker-images-none-dangling/


########################################
# Git
########################################
alias ga="git add -v"               # -v, --verbos      : add の内容を表示する
alias gaa="git add -vA"             # -A, --all         : 変更のあるファイルをすべてステージングする
alias gap="git add -vp"             # -p, --patch       : add の内容を表示する
alias gb="git branch"
alias gba="git branch -a"           # -a, --all         : リモートブランチも表示する
alias gcm="git commit -m"           # -m, --message     : コミットメッセージを作成する
alias gcma="git commit --amend -m"  # --amend           : 新しいブランチを作成してカレントブランチと入れ替える。-m オプションでメッセージも新たに設定する
alias gd="git diff"
alias gds="git diff --stat"         # --stat            : 差分のあるファイル名のみを表示
alias gf="git fetch"
alias gfp="git fetch -p"            # -p, --prune       : リモートに存在しない追跡ブランチを削除する
alias gl="git log --graph --all"
alias gll="git log --graph --all --date=format:'%Y-%m-%d %H:%M:%S' --pretty=format:'%C(auto)%h %C(cyan)%ad%C(auto)%d %s %C(#666666)by\"%an\"%Creset'"
alias gri="git rebase -i"           # -i, --interactive : 過去のコミットをまとめる $ git rebase -i HEAD~~
alias grs="git restore --staged ."  # -S, --staged      : ステージングを解除する。. をあらかじめ指定しておきカレント配下のステージングをすべて解除する
alias gpl="git pull"
alias gpoh="git push origin HEAD"   # https://git-scm.com/docs/git-push > git push origin HEAD
alias gs="git status"
alias gss="git status -s"           # -s, --short       : ステータスの短縮表示
alias gsw="git switch"
alias gswc="git switch -c"          # -c, --create      : 新しいブランチを作成して切り替える


########################################
# google-translator
########################################
# https://github.com/Neos21/google-translator

# $ gtr 'こんにちは世界'
# Hello World
alias gt="gtr"

# $ gtr -t ja 'Hello World'
# こんにちは世界
alias gtj="gtr -t ja"


########################################
# Jekyll
########################################
alias jkls="\
gr && \
cd docs && \
echo 'jekyll serve on:' && \
pwd && \
echo && \
bundle exec jekyll serve"


########################################
# Laravel Sail
########################################
alias sail="./vendor/bin/sail"


########################################
# pwgen
########################################
alias pg="pwgen -cnyB1" # $ pg 20 4 ... 20 桁のパスワード文字列を 4 行表示する


########################################
# rbenv
########################################
# rbenv-doctor
# https://github.com/rbenv/rbenv-installer?tab=readme-ov-file#rbenv-doctor
alias rbenv-doctor="curl -fsSL https://github.com/rbenv/rbenv-installer/raw/HEAD/bin/rbenv-doctor | bash"


########################################
# tree
########################################
alias tr="tree --dirsfirst -I '__pycache__'"                # 隠しファイル以外を表示
alias tra="tree -a --dirsfirst -I '__pycache__|.venv|.git'" # 隠しファイルを含めて表示（設定系のファイルは除外）
alias traa="tree -a --dirsfirst"                            # とにかくすべて表示


########################################
# venv
########################################
alias vmk="python3 -m venv .venv"                      # カレントディレクトリへ仮想環境を作成
alias vmks="sudo python3 -m venv --without-pip .venv"  # システムの py を使う場合はこちら
alias va="source .venv/bin/activate"                   # 仮想環境の有効化
alias vd="deactivate"                                  # 仮想環境の無効化
alias vrm="rm -r .venv"                                # 仮想環境の削除


########################################
# zsh
########################################
# zmv
alias zmvw="noglob zmv -W"   # 置換
alias zmvnw="noglob zmv -nW" # 置換プレビュー

# 配信モード
# theme.zsh で設定している zsh プロンプト表示について以下へ再設定する。
#
# - ユーザー名とホスト名を **** にする。
# - 表示するディレクトリパスをカレントディレクトリのみにする。
#
# 戻すときは ss で .zshrc を再読み込みする。
alias strmd='PROMPT="%F{179m%}****@****%F{black}%B:%F{white}%1~%b
%F{087m%}$%F{white} "'

# zsh で使用できる色を一覧表示
# [zsh で全 256 色を試しに表示みたい #Zsh - Qiita](https://qiita.com/k_ui/items/b02b93e3af13023c0bfd)
zsh-colors() {
    for c in {000..255}; do echo -n "\e[38;5;${c}m $c" ; [ $(($c%16)) -eq 15 ] && echo;done;echo
}


########################################
# 環境ごとの読込
########################################
case ${OSTYPE} in
    # Linux
    # msys は Win 環境上で Git Bash を立ち上げたときの $OSTYPE
    linux* | msys*)
        # apt
        alias upgrade="\
            set -x && \
            sudo apt-get update && \
            sudo apt-get upgrade -y && \
            sudo apt-get autoremove -y && \
            sudo apt-get autoclean -y && \
            set +x"

        alias dist-upgrade="\
            set -x && \
            sudo apt-get update && \
            sudo apt-get upgrade -y && \
            sudo apt-get dist-upgrade -y && \
            sudo apt-get autoremove -y && \
            sudo apt-get autoclean -y && \
            set +x"

        # WSL
        if uname -r | grep -i 'microsoft' > /dev/null ; then

            # Win 環境のホームディレクトリへ cd
            alias cdc="cd /mnt/c/Users/${USERNAME}"

            # Win 環境のパスへ cd
            # cd 'C:\Windows\path'
            cdw() {
                cd $(wslpath -u ${1})
            }

            # date & copy
            alias dt="date +'%F %T' | tee >(clip.exe)"         # 現在日時を yyyy-MM-dd hh:mm:ss 形式で表示 & クリップボードへ格納
            alias dts="date +'%Y%m%d%H%M%S' | tee >(clip.exe)" # 現在日時を yyyyMMddhhmmss 形式で表示 & クリップボードへ格納
            alias dtss="date +'%Y%m%d' | tee >(clip.exe)"      # 現在日時を yyyyMMdd 形式で表示 & クリップボードへ格納

            # hostname & copy
            alias hi="hostname -I | tee >(clip.exe)" # ホスト（WSL 環境）の IP アドレスを表示 & クリップボードへ格納

            # ls & copy
            # 作業ディレクトリのファイル一覧をコピーするエイリアス
            # WSL で標準出力したマルチバイト文字（UTF-8）を clip.exe へ渡すと文字化けしてしまうため Shift-JIS へ変換してから渡す
            # 参考: https://scrapbox.io/takker/clip.exeで日本語をコピーすると文字化けするようになった
            alias lc="ls -1A | iconv -f UTF8 -t SJIS | clip.exe"

            # seq & copy
            alias seq100="seq -w 1 100 | tee >(clip.exe)" # 001 ～ 100 を表示 & クリップボードへ格納

            # wslpath
            alias wpu="wslpath -u" # パス変換: Windows → WSL（Win のパスは '' で囲む）
            alias wpw="wslpath -w" # パス変換: WSL → Windows

            # Windows Apps
            alias clip="clip.exe" # '| clip' で Win 環境のクリップボードへ渡せる。例）$ echo 'neko' | clip
            alias open="explorer.exe"
            alias op="open"
            alias opr="open README.md"
            alias pwsh="powershell.exe"

            # ググる
            # https://osa.hatenablog.jp/entry/2020/02/24/121725
            # https://www.iplab.cs.tsukuba.ac.jp/~takakura/blog/20200715/
            gg() {
                local words

                # $words が値ありの場合は検索ワードを + 記号でつなぐ（AND 検索）
                if [ $# != 0 ]; then
                    for i in $*; do
                        words="${words}${words:++}${i}"
                    done
                fi

                # 既定のブラウザで URL を開く
                # 以下のメッセージが標準出力されるので /dev/null へ捨てる。
                #
                # $ gg ねこ
                # '\\wsl.localhost\Ubuntu\home\<username>'
                # 上記の現在のディレクトリで CMD.EXE を開始しました。
                # UNC パスはサポートされません。Windows ディレクトリを既定で使用します。
                cmd.exe /c start "http://www.google.co.jp/search?q=${words}" &>/dev/null
            }
        fi
    ;;

    # MacOS
    darwin*)
        # ls
        alias ll="ls -oF"
        alias lla="ll -a"

        # Homebrew
        BREWFILE_PATH="~/dotfiles/setup/macos/Brewfile"

        alias bbd="brew bundle dump --force --file $BREWFILE_PATH"       # Brewfile ファイルの生成
        alias bbl="brew bundle list --all --force --file $BREWFILE_PATH" # Brewfile ファイルから一括インストール
        alias bbc="cat $BREWFILE_PATH"                                   # Brewfile ファイルの表示

        # date & copy
        alias dt="date +'%F %T' | tee >(pbcopy)"         # 現在日時を yyyy-MM-dd hh:mm:ss 形式で表示 & クリップボードへ格納
        alias dts="date +'%Y%m%d%H%M%S' | tee >(pbcopy)" # 現在日時を yyyyMMddhhmmss 形式で表示 & クリップボードへ格納
        alias dtss="date +'%Y%m%d' | tee >(pbcopy)"      # 現在日時を yyyyMMdd 形式で表示 & クリップボードへ格納

        # open
        alias op="open"
    ;;

esac


########################################
# Init zsh-abbr
########################################
# alias.zsh の読み込み毎に $ABBR_USER_ABBREVIATIONS_FILE の記述をリセットする
# https://memo.yammer.jp/posts/zsh-abbr
# https://syohex.hatenablog.com/entry/20121006/1349487493
type "abbr" &>/dev/null && \
if [ -e "$ABBR_USER_ABBREVIATIONS_FILE" ]; then
    rm "$ABBR_USER_ABBREVIATIONS_FILE"
fi && \
abbr -q import-aliases
