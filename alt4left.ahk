#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir%

<^<!z::
GetKeyState, state, Shift
if state = D
    Send, Ż
else
    Send, ż
return

<^<!c::
GetKeyState, state, Shift
if state = D
    Send, Ć
else
    Send, ć
return

<^<!e::
GetKeyState, state, Shift
if state = D
    Send, Ę
else
    Send, ę
return

<^<!a::
GetKeyState, state, Shift
if state = D
    Send, Ą
else
    Send, ą
return

<^<!s::
GetKeyState, state, Shift
if state = D
    Send, Ś
else
    Send, ś
return
