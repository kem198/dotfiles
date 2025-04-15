#Requires AutoHotkey v2.0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Include
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
#Include ../libs/SendKey.ahk

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Function keys
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
F13 & 1:: SendKey("{F1}")
F13 & 2:: SendKey("{F2}")
F13 & 3:: SendKey("{F3}")
F13 & 4:: SendKey("{F4}")
F13 & 5:: SendKey("{F5}")
F13 & 6:: SendKey("{F6}")
F13 & 7:: SendKey("{F7}")
F13 & 8:: SendKey("{F8}")
F13 & 9:: SendKey("{F9}")
F13 & 0:: SendKey("{F10}")
F13 & -:: SendKey("{F11}")
F13 & =:: SendKey("{F12}")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Emacs keybindings
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Cursor
F13 & b:: SendKey("{Left}")
F13 & n:: SendKey("{Down}")
F13 & p:: SendKey("{Up}")
F13 & f:: SendKey("{Right}")
; Beginning/End of line
F13 & a:: SendKey("{HOME}")
F13 & e:: SendKey("{END}")
; Page Up/Down
F13 & u:: SendKey("{PgUp}")
F13 & v:: SendKey("{PgDn}")
; Newline
F13 & m:: SendKey("{Enter}")
F13 & j:: SendKey("{Enter}")
F13 & o::
{
    SendKey("{End}")
    SendKey("{Enter}")
    SendKey("{Home}")
    SendKey("{Left}")
    return
}
; Copy
; F13 & w:: SendKey("^x")
F13 & y:: SendKey("^v")
; Delete
F13 & d:: SendKey("{Del}")
F13 & h:: SendKey("{BS}")
; Kill line
F13 & k::
{
    SendKey("+{END}")
    SendKey("^x")
    return
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; for 60% Layout
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
F13 & Left:: SendKey("{HOME}")
F13 & Down:: SendKey("{PgDn}")
F13 & Up:: SendKey("{PgUp}")
F13 & Right:: SendKey("{END}")

F13 & '::`
; F13 & \::SendKey("{PrintScreen}")
F13 & BS:: SendKey("{Del}")

!BS::Del

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Mouse
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Back & Forward
F13 & LButton:: SendKey("{XButton1}")
F13 & RButton:: SendKey("{XButton2}")
F13 & q:: SendKey("{XButton1}")
F13 & w:: SendKey("{XButton2}")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Shortcuts
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Convert to Katakana
F13 & i:: SendKey("{F7}")
; Kill
!q:: SendKey("!{F4}")
; Search
F13 & Space::
{
    SendKey("#s")
    return
}
; fzf
F13 & t:: SendKey("^t") ; fzf-file-widget
F13 & r:: SendKey("^r") ; fzf-history-widget
F13 & c:: SendKey("!c") ; fzf-cd-widget
