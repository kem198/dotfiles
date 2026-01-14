<########################################
シンボリックリンク作成用 PowerShell スクリプト

クラウド環境や WSL 環境のディレクトリ・設定ファイルを Win 環境から利用できるようにする。
WSL2 のディレクトリ上にある bat ファイルを Win 側から実行する場合、
このシンボリックリンク設定を行った上で Win 側からその bat ファイルを実行したりショートカットを作成する。

参考:
[PowerShellで苦労して作るシンボリックリンク - Qiita](https://qiita.com/tokky_se/items/128a04e861b2863e2c99)
[Googleドライブのパスを英語に変更したい - 日日是好日](https://siromiuo.hateblo.jp/entry/2021/11/03/133144)
[PowerShellの配列と連想配列 | 晴耕雨読](https://tex2e.github.io/blog/powershell/array)
[PowerShellでのシンボリックリンク判定について](https://teratail.com/questions/184340)
[ハッシュテーブルについて知りたかったことのすべて - PowerShell | Microsoft Learn](https://learn.microsoft.com/ja-jp/powershell/scripting/learn/deep-dives/everything-about-hashtable?view=powershell-7.3)
[PowerShell のエラーハンドリングを（今度こそ）理解する - Qiita](https://qiita.com/mkht/items/24da4850f9d000b35fc4)

########################################>


# エラーが発生した時点で処理を中断する
$ErrorActionPreference = 'Stop'

function main {
    ########################################
    # 連想配列を宣言
    ########################################
    $linkHash = [ordered]@{}

    # 下記のコマンドで追加する
    # $linkHash['原本ファイルのパス'] = 'シンボリックリンクのパス'


    ########################################
    # 配列へ追加: クラウドストレージ
    ########################################
    # Files
    # $linkHash['~\GoogleDrive\Documents\Files'] = '~\Documents\Files'

    # works
    $linkHash['~\GoogleDrive\kenkenpa198\works\create'] = '~\works\create'
    # $linkHash['~\GoogleDrive\kenkenpa198\works\notes']  = '~\works\notes'
    $linkHash['~\GoogleDrive\kenkenpa198\works\workbench'] = '~\works\workbench'


    ########################################
    # 配列へ追加: WSL 環境
    ########################################
    # WSL 側のホームディレクトリパスを初期化
    $WSL_HOME = "\\wsl.localhost\Ubuntu\home\${env:USERNAME}"
    $DOTFILES_HOME = "$WSL_HOME\dotfiles"

    # .bashrc
    $linkHash["${DOTFILES_HOME}\.config\zsh\alias.zsh"] = '~\.bashrc'

    # develop
    # $linkHash["${WSL_HOME}\works\develop"] = '~\works\develop'

    # Code
    $linkHash["${DOTFILES_HOME}\.config\Code\User\snippets"]         = '~\AppData\Roaming\Code\User\snippets'
    $linkHash["${DOTFILES_HOME}\.config\Code\User\keybindings.json"] = '~\AppData\Roaming\Code\User\keybindings.json'
    $linkHash["${DOTFILES_HOME}\.config\Code\User\settings.json"]    = '~\AppData\Roaming\Code\User\settings.json'

    # Microsoft.WindowsTerminal
    $linkHash["${DOTFILES_HOME}\.config\Microsoft.WindowsTerminal\LocalState\settings.json"] = '~\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json'

    # WindowsPowerShell
    $linkHash["${DOTFILES_HOME}\.config\WindowsPowerShell\Microsoft.PowerShell_profile.ps1"] = '~\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1'

    # autohotkey
    $linkHash["${DOTFILES_HOME}\.config\autohotkey\kems-ahk.ahk"] = '~\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\kems-ahk.ahk'

    # azuredatastudio
    $linkHash["${DOTFILES_HOME}\.config\azuredatastudio\User\settings.json"] = '~\AppData\Roaming\azuredatastudio\User\settings.json'

    # git
    $linkHash["${DOTFILES_HOME}\.config\git\config"] = '~\.config\git\config'
    $linkHash["${DOTFILES_HOME}\.config\git\ignore"] = '~\.config\git\ignore'
    $linkHash["${DOTFILES_HOME}\.config\git\local"]  = '~\.config\git\local'


    ########################################
    # 配列へ追加: その他の環境
    ########################################
    # [Win] ~\Videos\Capture ---> [D ドライブ] ~\Videos\Capture
    # $linkHash["D:\${env:USERNAME}\Videos\Capture"] = '~\Videos\Capture'

    # [Win] ~\works\notes\.obsidian ---> [Win] ~\works\notes-secret\.obsidian
    $linkHash["~\works\notes\.obsidian"] = '~\works\notes-secret\.obsidian'
    $linkHash["~\works\notes\.gitignore"] = '~\works\notes-secret\.gitignore'
    $linkHash["~\works\notes\templates"] = '~\works\notes-secret\templates'
    $linkHash["~\works\notes\HOME.md"] = '~\works\notes-secret\HOME.md'


    ########################################
    # シンボリックリンクを作成
    ########################################
    foreach ($key in $linkHash.Keys) {
        # 連想配列のキーを原本ファイルパスとして初期化
        $originPath = $key

        # 連想配列の値をリンク先のパス、ディレクトリパス、リンク名として初期化
        $linkPath = $($linkHash[$key])
        $linkDir  = Split-Path -Path $($linkHash[$key]) -Parent
        $linkName = Split-Path -Path $($linkHash[$key]) -Leaf

        # 原本ファイルパスが存在しなかったらループをスキップする
        if (!(Test-Path $originPath)) {
            Write-Host "SKIP    : $originPath is not found."
            continue
        }

        # 作成先へリンク以外のファイルが存在していたらバックアップする
        # リンクである場合は分岐せずに New-Item の処理で上書きする
        if ((Test-Path $linkPath) -and (!((Get-ItemProperty $linkPath).Mode.Substring(5, 1) -eq 'l'))) {
            $linkPathBackup = $linkPath + '.org'

            Write-Host "BACKUP  : $linkPath is found. Copied to $linkPathBackup"
            Move-Item $linkPath $linkPathBackup

            # FIXME:
            # バックアップ処理には Copy-Item ではなく Move-Item を使用している。
            # Copy-Item でバックアップ対象のファイルを複製後にシンボリックリンクで上書きする処理工程にしたかったが、
            # New-Item は -Force オプションでディレクトリを上書きできないようなため。
        }

        # シンボリックリンクを作成
        New-Item -Value $originPath -Path $linkDir -Name $linkName -ItemType SymbolicLink -Force > $null
        Write-Host "COMPLETE: Linked $linkPath => $originPath"
    }
}

main
