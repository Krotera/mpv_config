# what
My mpv config files (`input.conf` and `mpv.conf`) and an [AutoHotkey](https://www.autohotkey.com) script (`mpv media keys.ahk`) for controlling mpv with media keys while out of focus

E.g., you're doing something on monitor A and have mpv running on monitor B. Without tabbing out of the program on monitor A, holding Shift and scrolling up with the mouse wheel increases the volume of the mpv window on monitor B. Similarly, Ctrl + Alt + Left arrow will seek backwards in the file mpv's playing, Shift + Play/Pause will play or pause mpv's playback, etc.

As a bonus, Play/Pause without Shift will still interact with another player (e.g., Foobar) in the background as usual. AutoHotkey grabs the Shift + Play/Pause and sends it as another key input to the first available mpv window in the background (not to the currently-raised window). If *no* mpv window exists, Shift + Play/Pause will be sent to the currently-raised window as normal.

To do this on Linux, I instead use xdotool commands bound to keys through my desktop environment's shortcut settings. Some of the key bindings have to differ since they just don't work on Linux, but my key bindings and associated commands are:

mpv play, Ctrl + Play/Pause, `xdotool search --class mpv key space`

mpv stop, Ctrl + Stop, `xdotool search --class mpv key q`

mpv next, Ctrl + Next, `xdotool search --class mpv key greater`

mpv prev, Ctrl + Previous, `xdotool search --class mpv key less`

mpv vol up, Alt + Numpad Plus, `xdotool search --class mpv key KP_Multiply`

mpv vol down, Alt + Numpad Minus, `xdotool search --class mpv key KP_Divide`

mpv seek forward, Ctrl + Alt + Right arrow, `xdotool search --class mpv key Right`

mpv seek backward, Ctrl + Alt + Left arrow, `xdotool search --class mpv key Left`

# how
- Put `mpv.conf` and `input.conf` in `C:\Users\[USERNAME]\AppData\Roaming\mpv` on Windows or `~/.config/mpv` on Linux
- If on Windows, put `mpv media keys.ahk` anywhere and run it with AutoHotkey
- If on Linux, bind the list of xdotool commands above to keys through your desktop environment's shortcut manager
- **Strongly-recommended bonus:** get [`autoload.lua`](https://github.com/mpv-player/mpv/blob/master/TOOLS/lua/autoload.lua)! Put it in `C:\Program Files (x86)\mpv\scripts` on Windows or `~/.config/mpv/scripts` on Linux. This automatically compiles
a playlist in mpv of all relevant files in the directory of the file just opened so that the next file (in alphabetic order)
plays after the current file ends, which is the usual behavior of many players.

# license
[Mozilla Public License 2.0](https://mozilla.org/MPL/2.0/)
