#Requires AutoHotkey v2.0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Include
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
#Include ../libs/SendKey.ahk
#Include ../libs/IMEv2.ahk

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Alt to switch IME
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; メニューバー起動を抑制する
; 未予約のキー (vkE8) を Alt down 時に同時に送信して Alt キー単体機能であるメニューバー起動を無効化する
; https://ahkscript.github.io/ja/docs/v2/lib/A_MenuMaskKey.htm
; https://ahkscript.github.io/ja/docs/v2/lib/Send.htm#blind
; https://ahkscript.github.io/ja/docs/v2/Hotkeys.htm#Tilde
~LAlt:: SendKey("{Blind}{vkE8}")
~RAlt:: SendKey("{Blind}{vkE8}")

; IME OFF
LAlt up:: IME_SET(0)
; IME ON
RAlt up:: IME_SET(1)
