##### archive commit diff #####
# Git リポジトリ上の指定コミット間の差分ファイルを ZIP 形式で出力するシェル関数

# 参考:
# git コマンドで差分納品 zipを作る (かつ、不要ファイルは含めないようにしたい) ｜ Tips Note by TAM (https://www.tam-tam.co.jp/tipsnote/program/post12992.html)

function acd() {
    ##### 関数の定義 #####
    # 引数エラーを出力する関数
    function print_error_args() {
        echo "引数を受け取れませんでした。"
        echo "使い方を確認するには "\'"acd -h"\'" を送信してください。"
    }

    # コマンド実行エラーを出力する関数
    function print_error_git_archive() {
        echo "git archive コマンドの実行中にエラーが発生しました。"
        echo "コミットの指定方法が正しいか確認してください。"
        echo "使い方を確認するには "\'"acd -h"\'" を送信してください。"
    }

    # ヘルプを出力する関数
    function print_help() {
        cat \
<< msg_help
-----------------------------------------------------------------
                       Archive Commit Diff
-----------------------------------------------------------------
Git リポジトリ上で指定したコミット間の差分ファイルを ZIP 形式で出力します。

 使い方
--------
1. Git リポジトリのルートディレクトリへ移動する。
  $ cd foo_git_dir

2. 第 1 引数に変更前のコミット、第 2 引数に変更後のコミットを指定して送信する。
  $ acd from_commit to_commit

3. 差分をアーカイブ化した ZIP ファイルがカレントディレクトリに生成される。
  .
  ├── .git
  ├── bar_file
  ├── baz_file
  └── archive.zip ← 生成！

 使用例
--------
コミットの指定にはコミット ID もしくはブランチ名が使えます。
  $ acd 322d4b4 a11729d
  $ acd main feature/aaaaa

第 3 引数にファイルパスを指定すると、好みのファイル名やディレクトリへ出力を行えます。
  $ acd from_commit to_commit fuga.zip
  $ acd from_commit to_commit ../fuga.zip
  $ acd from_commit to_commit ~/aaa/fuga.zip

'--help' オプションでヘルプを表示します。
  $ acd --help
  $ acd -h

 補足
------
- 指定されたコミットが見つからなかった場合はエラーメッセージを表示しますが、
  その際に空の ZIP ファイルも出力されてしまいます。
  確認して削除をお願いします。
msg_help
    }

    # git archive コマンドを実行する関数
    function do_git_archive() {
        # $1 : 変更前のコミット
        # $2 : 変更後のコミット
        # $3 : 出力するファイルパス
        echo "変更前のコミット : ${1}"
        echo "変更後のコミット : ${2}\n"

        git archive --format=zip --prefix=root/ $2 `git diff --name-only ${1} ${2} --diff-filter=ACMR` -o $3
    }


    ##### メイン処理 #####
    # ローカル変数の宣言・初期化
    local \
        from_commit \
        to_commit \
        out_file_path="archive.zip" # デフォルトの出力ファイル名

    # 引数が 0 個のときは引数エラーを表示して終了
    if [ $# = 0 ]; then
        print_error_args
        return 1

    # 引数が -h, --help の場合はコマンド一覧を表示して終了
    elif [ $1 = "-h" ] || [ $1 = "--help" ]; then
        print_help
        return 0

    # 引数が 3 個の場合
    elif [ $# = 3 ]; then
        # 第 1 引数を「変更前のコミット」、第 2 引数を「変更後のコミット」として代入
        from_commit=$1
        to_commit=$2

        # 第3引数を「出力する ZIP のファイルパス」として格納
        out_file_path=$3

    # 引数が 2 個の場合
    elif [ $# = 2 ]; then
        # 第 1 引数を「変更前のコミット」、第 2 引数を「変更後のコミット」として代入
        from_commit=$1
        to_commit=$2

    # 引数指定に当てはまらなかったら引数エラーを表示して終了
    else
        print_error_args
        return 1
    fi

    # git archive コマンドを実行
    do_git_archive $from_commit $to_commit $out_file_path

    # 終了ステータスのチェック
    if [ $? -gt 0 ]; then
        # 直前に実行したコマンド（git archive）の終了ステータスが 0 を超える（成功ステータスではない）であればコマンド実行エラーを表示して終了
        print_error_git_archive
        return 1
    else
        # ステータスが 0（成功）であればファイルパスを表示
        echo "差分ファイルを出力しました。"
        echo $out_file_path
    fi
}
