#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

*CapsLock::
    Send {Blind}{Ctrl Down}
    cDown := A_TickCount
Return

*CapsLock up::
    If ((A_TickCount-cDown) < 200)  ; Modify press time as needed (milliseconds)
        Send {Blind}{Ctrl Up}{Esc}
    Else
        Send {Blind}{Ctrl Up}
Return

; Toggle CapsLock when both Shift keys are pressed together
+Shift::
    KeyWait, RShift, D T0.2  ; Wait for the other shift key to be pressed within 0.2 seconds
    If GetKeyState("RShift", "P")  ; If the right shift is also pressed
    {
        SetCapsLockState, % (GetKeyState("CapsLock", "T")) ? "Off" : "On"
        KeyWait, RShift  ; Wait until the right shift key is released to avoid repeated toggling
    }
Return

Shift & RShift::  ; Same as above, but for the other shift key
    KeyWait, LShift, D T0.2
    If GetKeyState("LShift", "P")
    {
        SetCapsLockState, % (GetKeyState("CapsLock", "T")) ? "Off" : "On"
        KeyWait, LShift
    }
Return