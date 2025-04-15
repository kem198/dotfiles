<!-- omit in toc -->
# dotfiles

```shell
curl -fsSL https://raw.githubusercontent.com/kem198/dotfiles/main/setup/linux/setup.sh | bash
```

<!-- omit in toc -->
## TOC

- [Setup](#setup)
    - [Ubuntu](#ubuntu)
    - [Arch Linux](#arch-linux)
    - [Windows and WSL](#windows-and-wsl)
    - [MacOS](#macos)
- [Tips](#tips)
    - [ホワイトリスト形式の .gitignore](#ホワイトリスト形式の-gitignore)
    - [Git のキャッシュ削除手順](#git-のキャッシュ削除手順)
    - [PowerShell でスクリプトを実行する](#powershell-でスクリプトを実行する)
    - [Windows Terminal の GUID 復元手順](#windows-terminal-の-guid-復元手順)
- [Reference](#reference)

## Setup

### Ubuntu

```shell
# 必須パッケージの存在を確認する
type "sudo" ; type "curl" ; type "git"

# 存在しなければインストールする
# sudo
apt-get update && apt-get upgrade -y
apt-get install -y sudo

# curl git
sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install -y curl
sudo apt-get install -y git

# セットアップ用スクリプトを実行する
curl -fsSL https://raw.githubusercontent.com/kem198/dotfiles/main/setup/linux/setup.sh | bash
```

### Arch Linux

```shell
# 必須パッケージの存在を確認する
type "sudo" ; type "curl" ; type "git"

# 存在しなければインストールする
# sudo
pacman -Syu --noconfirm
pacman -S --noconfirm sudo

# curl git
sudo pacman -Syu --noconfirm
sudo pacman -S --noconfirm curl
sudo pacman -S --noconfirm git

# セットアップ用スクリプトを実行する
curl -fsSL https://raw.githubusercontent.com/kem198/dotfiles/main/setup/linux/setup.sh | bash
```

### Windows and WSL

1. Windows PowerShell を管理者権限で起動し、次のコマンドを実行して WSL をセットアップする。

    ```powershell
    wsl --install
    ```

    - 参考) [WSL のインストール | Microsoft Learn](https://learn.microsoft.com/ja-jp/windows/wsl/install)

2. (Arch Linux のみ) [yuk7/ArchWSL](https://github.com/yuk7/ArchWSL) を使用して WSL へ Arch Linux をインストール・初期設定する。
    - 参考) [インストール方法 | ArchWSL official documentation](https://wsldl-pg.github.io/ArchW-docs/locale/ja-JP/How-to-Setup/)

3. [.wslconfig](.config/WSL/.wslconfig) を `%UserProfile%` ( `C:\Users\[username]` ) へ配置する。

4. WSL 環境のホームディレクトリ上で各環境ごとのセットアップ手順を実行する。

5. [setup/windows/](setup/windows) 配下のスクリプトを順次実行する。

### MacOS

次触った時に書く。

## Tips

### ホワイトリスト形式の .gitignore

```shell
.
└── .gitignore
```

当 dotfiles 用の `.gitignore` はホワイトリスト形式での記述を行い、`.gitignore` で指定したファイルのみしか Git の管理下に入らないようにしている。

こうすることで、新しく追加したファイルに秘匿すべき情報が含まれていた際に、誤ってコミットしてしまうミスを防げる。

### Git のキャッシュ削除手順

- `.gitignore_global` を設定する前にコミットをしてしまった。
- 過去に追跡対象としてコミットしたファイルを `.gitignore` で追跡対象外にしたい。
- `.gitignore` を整理したので追跡対象の設定が問題ないか確認したい。

これらに該当する場合は Git のキャッシュ削除が必要になる。

次のコマンドを順に実行して対応する。

```shell
# cd
cd ~/dotfiles

# Git のキャッシュをすべてのファイルから削除する
git rm --cached -r .

# 全てのファイルをステージングする
git add -vA

# コミット対象のファイルが変更を加えたファイルのみであるか確認する
git status -s

# コミットする
git commit -m '[commit comments]'
```

### PowerShell でスクリプトを実行する

PowerShell はネットワークから取得したスクリプトファイル `***.ps1` がデフォルトで実行できない。このため、スクリプトの実行前に実行ポリシーの変更が必要となる。

一時的に実行ポリシーを変更する場合は下記の手順で行う。

1. 管理者権限で PowerShell を実行する。
2. 現在の実行ポリシーを確認する。

    ```powershell
    # 実行ポリシーを確認する
    > Get-ExecutionPolicy
    Restricted # 既定の実行ポリシー。構成ファイルのロードやスクリプトの実行が行えない
    ```

3. 実行ポリシーを一時的に変更する。

    ```powershell
    # そのプロセスでのみ有効にする
    # Set-ExecutionPolicy -ExecutionPolicy [実行ポリシー] -Scope [スコープ]
    # RemoteSigned ... 署名されたスクリプトが実行できる実行ポリシー
    # Process      ... 実行ポリシーを現在の PowerShell プロセスのみに影響させる
    > Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope Process

    実行ポリシーの変更
    実行ポリシーは、信頼されていないスクリプトからの保護に役立ちます。実行ポリシーを変更すると、about_Execution_Policies のヘルプ トピック
    (https://go.microsoft.com/fwlink/?LinkID=135170) で説明されているセキュリティ上の危険にさらされる可能性があります。実行ポリシーを変更しますか?
    [Y] はい(Y)  [A] すべて続行(A)  [N] いいえ(N)  [L] すべて無視(L)  [S] 中断(S)  [?] ヘルプ (既定値は "N"): y

    # 確認する
    > Get-ExecutionPolicy
    RemoteSigned

    # スクリプトを実行する
    > hoge.ps1
    ```

### Windows Terminal の GUID 復元手順

Windows Terminal の設定ファイルを上書きする際、環境によっては WSL を Windows Terminal で実行できなくなる場合がある。Ubuntu のバージョンに紐づけられた GUID が上書き前後で変わってしまったため。（※ 理解が正確でないかも）

この場合、下記の手順で上書き前の GUID を復元する。

1. `Ctrl + ,` で設定を開く。
2. `新しいプロファイルを追加します` を選択する。
3. `プロファイルを複製する` から `Ubuntu` など目的のプロファイルを選んで `複製` をクリックする。
4. 複製されたプロファイルの GUID を既存のプロファイルへ記述する。

## Reference

<!-- omit in toc -->
### dotfiles

- [ようこそdotfilesの世界へ \#Vim - Qiita](https://qiita.com/yutkat/items/c6c7584d9795799ee164)
- [Windows と Mac で開発環境を揃える Tips 集 - Neo's World](https://neos21.net/tech/programming/windows-mac-environment.html)
- [dotfilesのこだわりを晒す - エムスリーテックブログ](https://www.m3tech.blog/entry/dotfiles-bonsai)
- [dotfilesのすゝめ \| kouki’s blog > CI](https://blog.kmdkuk.com/2022/07/16/dotfilesのすゝめ.html)

<!-- omit in toc -->
### XDG Base Directory

- [XDG Base Directory - ArchWiki](https://wiki.archlinux.jp/index.php/XDG_Base_Directory)
- [Dotfiles の整頓とバージョン管理：XDG Base Directory Specification と YADM の活用ガイド \#dotfiles - Qiita](https://qiita.com/LuckyWindsck/items/ef8ae12a3450344d8902)

<!-- omit in toc -->
### zsh

- [Introduction - sheldon docs](https://sheldon.cli.rs/Introduction.html)
- [高速で設定しやすいZsh/BashプラグインマネージャーSheldonの紹介](https://zenn.dev/ganta/articles/e1e0746136ce67)
- [zsh で使う plugin manager を sheldon に移行 – ぶっちろぐ](https://bucci.bp7.org/archives/48515/)
- [zsh設定ファイル（.zshrc）を分割する - fnwiya's quine](https://fnwiya.hatenablog.com/entry/2015/11/03/191902)

<!-- omit in toc -->
### shell script

- [シェルスクリプトを高級言語のような書き味に近づける Tips 集](https://sousaku-memo.net/php-system/1817)
- [使いやすいシェルスクリプトを書く \| Taichi Nakashima](https://deeeet.com/writing/2014/05/18/shell-template/)
- [初心者向け、「上手い」シェルスクリプトの書き方メモ \#初心者 - Qiita](https://qiita.com/m-yamashita/items/889c116b92dc0bf4ea7d)
- [bashのヒアドキュメントを活用する \#Bash - Qiita](https://qiita.com/take4s5i/items/e207cee4fb04385a9952)

<!-- omit in toc -->
### Windows PowerShell

- [実行ポリシーについて - PowerShell \| Microsoft Learn](https://learn.microsoft.com/ja-jp/powershell/module/microsoft.powershell.core/about/about_execution_policies?view=powershell-7.3)
- [Set-ExecutionPolicy (Microsoft.PowerShell.Security) - PowerShell \| Microsoft Learn](https://learn.microsoft.com/ja-jp/powershell/module/microsoft.powershell.security/set-executionpolicy?view=powershell-7.3)
- [PowerShellでこのシステムではスクリプトの実行が無効になっているため、ファイル hoge.ps1 を読み込むことができません。となったときの対応方法 \#Windows10 - Qiita](https://qiita.com/ponsuke0531/items/4629626a3e84bcd9398f)
- [PowerShellの.bashrc的な設定ファイルこと$Profileについての紹介 \#PowerShell - Qiita](https://qiita.com/smicle/items/0ca4e6ae14ea92000d18)

<!-- omit in toc -->
### Git

- [Git - Git の設定](https://git-scm.com/book/ja/v2/Git-のカスタマイズ-Git-の設定)
- [github/gitignore: A collection of useful .gitignore templates](https://github.com/github/gitignore)
- [gitignoreのホワイトリストの書き方 \#Git - Qiita](https://qiita.com/sventouz/items/574bd67c7e43fff10546)
- [最低限しておくといいgitconfigの設定 \#Git - Qiita](https://qiita.com/hayamofu/items/d8103e789196bcd8b489)
- [.gitconfigにinclude書くと捗る - 時計を壊せ](https://techblog.karupas.org/entry/2012/07/19/190313)

<!-- omit in toc -->
### AutoHotKey v2

- [クイックリファレンス｜AutoHotkey v2](https://ahkscript.github.io/ja/docs/v2/)
- [k-ayaki/IMEv2.ahk](https://github.com/k-ayaki/IMEv2.ahk/tree/master)
- [AutoHotKey : Google Chrome専用スクリプト - imani-cの日記](https://imani-c.hatenablog.com/entry/2023/01/29/141328)
- [IME制御 - eamat @Cabinet - atwiki（アットウィキ）](https://w.atwiki.jp/eamat/pages/17.html)
- [Autohotkey v2.0のIME制御用 関数群 IMEv2.ahk \#AutoHotkey - Qiita](https://qiita.com/kenichiro_ayaki/items/d55005df2787da725c6f)
- [WindowsのAlt空打ちで日本語入力(IME)を切り替えるツールを作った - karakaram-blog](https://www.karakaram.com/alt-ime-on-off/)
- [kskmori/US-AltIME.ahk](https://github.com/kskmori/US-AltIME.ahk/tree/main)
- [AutoHotkey：キー押しっぱなし病・ホットキーすり抜け病対策の研究](https://did2memo.net/2013/10/03/autohotkey-ctrl-key-is-stuck/)
- [快適キーボード操作のためのキーカスタマイズ 〜AutoHotKeyのキー押しっぱなし問題とScrollLockの非推奨～ \| さくらのナレッジ](https://knowledge.sakura.ad.jp/25827/#F13F24)
- [AutoHotkey スレッド part30](https://egg.5ch.net/test/read.cgi/software/1644313099/) > `>>770`

<!-- omit in toc -->
### xremap

- [k0kubun/xremap: Key remapper for X11 and Wayland](https://github.com/k0kubun/xremap)
    - [xremap/example/emacs.yml at master · k0kubun/xremap](https://github.com/k0kubun/xremap/blob/master/example/emacs.yml)
- [Linux用キーリマッパーxremapをRustで書き直した - k0kubun's blog](https://k0kubun.hatenablog.com/entry/xremap)
- [evdev/src/scancodes.rs at 1d020f11b283b0648427a2844b6b980f1a268221 · emberian/evdev](https://github.com/emberian/evdev/blob/1d020f11b283b0648427a2844b6b980f1a268221/src/scancodes.rs#L26-L572)
- [SandSをLinuxでやってる人はxremapを導入してxmodmapとxcapeを捨ててください - Lambdaカクテル](https://blog.3qe.us/entry/2023/12/25/201605)
- [xremapを利用して特殊なショートカットをマッピングしてみる（Alt+c → Shift+Ctrl+c など ) – Roguer](https://roguer.info/2023/02/12/9136/)
- [xremap + wayland + KDE6でキーリマップしよう \#Linux - Qiita](https://qiita.com/ys-clarry/items/9d5c20dc9d62a5f88ffd)

<!-- omit in toc -->
### CI

- [GitHub Actions のクイックスタート - GitHub Docs](https://docs.github.com/ja/actions/quickstart)
- [dotfilesのすゝめ \| kouki’s blog > CI](https://blog.kmdkuk.com/2022/07/16/dotfilesのすゝめ.html#ci)

この他、処理ごとの参考文献は各スクリプトにコメントで記載しています。
