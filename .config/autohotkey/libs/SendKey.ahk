#Requires AutoHotkey v2.0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; SendKey 関数
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 押しっぱなし病対策
; 修飾キーの Send 後に修飾キーの up を送信する
;
; https://egg.5ch.net/test/read.cgi/software/1644313099/
; >>770

SendKey(str) {
    Send("{Blind}" str)
    Sleep(5)

    if InStr(str, "#")
        Send("{LWin Up}{RWin Up}")
    if InStr(str, "^")
        Send("{Ctrl Up}")
    if InStr(str, "+")
        Send("{Shift Up}")
    if InStr(str, "!")
        Send("{Alt Up}")
}
