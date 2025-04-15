########################################
# fzf
########################################
export FZF_DEFAULT_OPTS="--height 80% --reverse --border"
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"


########################################
# gcloud
########################################
# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/google-cloud-sdk/path.zsh.inc"; fi
# The next line enables shell command completion for gcloud.
if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/google-cloud-sdk/completion.zsh.inc"; fi


########################################
# ls
########################################
# ファイルの種類で色分け
# Mac の場合にデフォルトで色分けがされないため設定する
export CLICOLOR=1

# zsh の色設定を変更
# WSL 上の zsh から Windows 環境のファイルを開いた場合に見づらいため色設定を変更する
#
# OTHER_WRITABLE 34;42 => 01;32 ... 書き込み権限が付与されたファイルを 背景緑;文字青 から ボールド;文字緑 へ変更
# EXEC           01;32 => 01;00 ... 実行属性が設定されているファイル (WSL から見た Win 側のファイル) を ボールド;文字緑 から ボールド;文字白 へ変更
#
# 参考:
# https://www.kwbtblog.com/entry/2019/04/27/023411
# https://blue-red.ddo.jp/~ao/wiki/wiki.cgi?page=ls%A5%B3%A5%DE%A5%F3%A5%C9%A4%CE%BF%A7%A4%F2%CA%D1%B9%B9%A4%B9%A4%EB
# https://www.fulldigit.co.jp/server_env/ls_colors.html
# https://qiita.com/minnsou/items/3e9f200f9f2cc9a92920
export LS_COLORS='ow=01;32:ex=01;00:';

# ディレクトリの色を ボールド;文字青 から 標準;文字黄 へ変更する場合
# export LS_COLORS='ow=00;33:ex=01;00:di=00;33:';


########################################
# nvm
########################################
# https://github.com/nvm-sh/nvm?tab=readme-ov-file#git-install
export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm


########################################
# pyenv
########################################
# https://github.com/pyenv/pyenv?tab=readme-ov-file#set-up-your-shell-environment-for-pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"


########################################
# rbenv
########################################
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init - zsh)"


########################################
# SDKMAN!
########################################
#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"


########################################
# zsh-autosuggestions
########################################
# 候補をデフォルトより暗く表示する
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=243"


########################################
# Volta
########################################
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"


########################################
# Load by environment
########################################
case ${OSTYPE} in
    # for Linux
    linux*)
        # for WSL
        if uname -r | grep -i 'microsoft' > /dev/null ; then
            # Win 環境の環境変数を WSL 環境へ複製
            # export PATH="$PATH:$Path"
        fi
    ;;

    # for MacOS
    darwin*)
        # bin_M1
        export PATH="$PATH:/opt/homebrew/bin:/opt/homebrew/sbin"

        # bin
        export PATH="$PATH:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin"

        # pyenv
        export PATH="$PATH:$HOME/.pyenv/shims"

        # Postgres.app
        export PATH="$PATH:/Applications/Postgres.app/Contents/Versions/latest/bin"
    ;;
esac
