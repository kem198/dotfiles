<########################################
アプリケーションやそのインストーラーを curl.exe でダウンロードする PowerShell スクリプト。

winget のソースに登録がないアプリケーションはこちらをつかってインストールする。
ユーザーのダウンロードフォルダへ保存される。

現行は指定されたバージョンをダウンロードする。
そのため一旦リリースページを確認し、最新バージョンがあればそちらを優先してダウンロードする。

########################################>


########################################
# ユーザーのダウンロードフォルダへ移動
########################################
cd ~\Downloads


########################################
# アプリケーション
########################################
# Change Key v1.50
# http://satoshi3.sakura.ne.jp/f_soft/dw_win.htm
# https://forest.watch.impress.co.jp/library/software/changekey/
curl.exe -OL https://dforest.watch.impress.co.jp/library/c/changekey/10668/ChgKey15.LZH

# サクラエディタ v2.4.2
# https://sakura-editor.github.io/
# https://github.com/sakura-editor/sakura/releases
curl.exe -OL https://github.com/sakura-editor/sakura/releases/download/v2.4.2/sakura-tag-v2.4.2-build4203-a3e63915b-Win32-Release-Installer.zip

# Free Video Compressor v1.0
# https://www.gigafree.net/media/me/FreeVideoCompressor.html
# http://www.freevideocompressor.com/
curl.exe -OL http://file1.softsea.com/download/9a21a475/581d90138b5eb64e91f75495e3a359b7/Video_Utility/freevideocompressor_setup.exe

# すじこ v4.1
# http://blog.livedoor.jp/yamma_ma/archives/susico.html
# https://ux.getuploader.com/softwares_yamma_ma/download/62
curl.exe -OL https://downloadx.getuploader.com/g/63b8fe5a-1464-40cd-b21a-6ef7a010e467/softwares_yamma_ma/62/susico-4.1.zip


########################################
# ドライバー
########################################
# Wacom driver v6.4.0-11
# https://tablet.wacom.co.jp/download/
curl.exe -OL https://tablet.wacom.co.jp/download/driver/WacomTablet_6.4.0-11.exe


########################################
# フォント
########################################
# HackGen v2.9.0
# https://qiita.com/tawara_/items/374f3ca0a386fab8b305
# https://github.com/yuru7/HackGen/releases
curl.exe -OL https://github.com/yuru7/HackGen/releases/download/v2.9.0/HackGen_v2.9.0.zip

# Noto Sans Japanese
# https://fonts.google.com/noto/specimen/Noto+Sans+JP
curl.exe -OL https://fonts.google.com/download?family=Noto%20Sans%20JP


########################################
# 手動インストール
########################################
# DaVinci Resolve
# https://www.blackmagicdesign.com/jp/products/davinciresolve
