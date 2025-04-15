#Requires AutoHotkey v2.0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Include
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
#Include ../libs/SendKey.ahk
#Include ../libs/IMEv2.ahk

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Change right side keys
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; ; ¥ で Backspace を送信
; sc07D:: SendKey("{BS}")

; ; \ で右の Shift を送信
; sc073:: SendKey("{RShift down}")
; sc073 up:: SendKey("{RShift up}")

; sc02B:: {
;     if (GetKeyState("Shift", "P")) {
;         ; Shift + ] で Shift + Enter を送信
;         Send("+{Enter}")
;     } else {
;         ; ] で Enter を送信
;         Send("{Enter}")
;     }
; }

; ; F13 + ] でバックスラッシュを送信
; #HotIf GetKeyState("F13", "P")
; sc02B:: SendKey("\")
; #HotIf

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Switch IME
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
sc07B:: IME_SET(0)   ; 無変換キーで IME を OFF
sc079:: IME_SET(1)   ; 変換キーで IME を ON
sc070:: IME_SET(1)   ; ひらがなカタカナキーで IME を ON

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Shortcuts
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
sc07B & Tab::AltTab ; 無変換キーでも AltTab
