/* 
This script enables media key functionality for mpv via AutoHotkey
while preserving it for other players while the script is running. 
It lets you:
- Use media keys to control mpv, in or out of focus
- Use media keys to control other players when mpv isn't running
- Use Shift+media keys to control players in the background when mpv is running
- Use Shift+scroll wheel to control mpv volume, in or out of focus
- Use Ctrl+Alt+right/left arrow to control mpv track seek (skip forward or backward in the file being played) out of focus

Make sure no keybindings in %APPDATA%\mpv\input.conf overwrite those used
in the ControlSend commands below. 

Also, I use autoload (https://github.com/mpv-player/mpv/blob/master/TOOLS/lua/autoload.lua),
which goes in C:\Program Files (x86)\mpv\scripts on Windows and ~/.config/mpv/scripts on Linux. It automatically compiles 
a playlist in mpv of all relevant files in the directory of the file just opened so that the next file (in alphabetic order) 
plays after the current file ends (without this, mpv just closes after it reaches the  end of the current file).
By default, however, I set mpv to loop the current file after playback with

    loop=inf

in the file mpv.conf, and I toggle this vs. playing the next file (per autoload) by hitting the 'L' key with

    L cycle_values loop no inf

in the file input.conf. Both of these files are in C:\Users\[USERNAME]\AppData\Roaming\mpv on Windows and ~/.config/mpv on Linux.
*/
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force ; Prevents annoying dialog on startup

;;;; MPV MEDIA CONTROLS ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; PLAY/PAUSE
Media_Play_Pause::
/*
If mpv is running, send the translated media command to mpv.
*/
if (WinExist("ahk_class mpv")) {
	ControlSend,, {Space}, ahk_class mpv
	return
} 
/* 
Else, if mpv isn't running, send Shift+Media_Key to everything.

I use this to be able to control Foobar on the side.
If mpv isn't running, some programs like Foobar will
apparently not accept unshifted media input, maybe 
because AutoHotkey is intercepting media input, so 
Windows does not pass it on to anything else.
E.g., if +Media_Play_Pause (Shift+Play) was a hotkey 
in this script, Foobar would no longer respond to it 
either because AutoHotkey is intercepting it too.

This is a workaround to having to manually
hold Shift when mpv isn't even open to use media commands 
in other players.

When mpv IS open, holding Shift WILL be necessary to
manipulate other players, but that's true of two
player programs running simultaneously in general. 
*/
else {
	Send +{Media_Play_Pause}
	return
}

;; NEXT
Media_Next::
if (WinExist("ahk_class mpv")) {
	ControlSend,, {>}, ahk_class mpv
	return
}
else {
	Send +{Media_Next}
	return
}

;; PREV
Media_Prev::
if (WinExist("ahk_class mpv")) {
	ControlSend,, {<}, ahk_class mpv
	return
}
else {
	Send +{Media_Prev}
	return
}

;; STOP
Media_Stop::
if (WinExist("ahk_class mpv")) {
	ControlSend,, {q}, ahk_class mpv
	return
}
else {
	Send +{Media_Stop}
	return
}

;;;; MPV MISC ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; VOLUME UP
+WheelUp::
if (WinExist("ahk_class mpv")) {
	ControlSend,, {0}, ahk_class mpv
	return
}

;; VOLUME DOWN
+WheelDown::
if (WinExist("ahk_class mpv")) {
	ControlSend,, {9}, ahk_class mpv
	return
}

;; SEEK BACK
^!Left::
if (WinExist("ahk_class mpv")) {
	ControlSend,, {Left}, ahk_class mpv
	return
}

;; SEEK FORWARD
^!Right::
if (WinExist("ahk_class mpv")) {
	ControlSend,, {Right}, ahk_class mpv
	return
}
