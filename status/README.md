# status modules

the scripts in this directory are mostly used in my dwm status bar, but they can easily be adapted to be used in other status bars or for other stuff that takes standard input.the scripts are run on signals managed by dwmblocks (see `/builds/dwmblocks/` in my [voiddots repo](https://github.com/apeir-n/voiddots) if you're interested).

---

### general

the delimiter in dwmblocks is configured to be ` ][ `, so i manually add the open and closing brackets to the first and last modules in the bar
- specifically:
    - `[` for void.sh
    - for time.sh `]`
    - becomes:
    - `[ void ][ ...etc... ][ 03:26pm ]`

an example of the whole bar would look like:
- `[ void ][   85° ][   76% ][   10% ][ 󰁿  65% ][   250921 ][ 󱑁  03:26pm ]`
- you'll need a nerd font to view the icons here
- unfortunately github's default monospace font renders them as weird ugly blocks
- but there's an alternative one for tty use in the script below...

---

### scripts

`a4.sh`
- this is just a pure text-mode emulation of my dwm status bar for use in the a4 multiplexer or dvtm
- i didn't use regular icons so that it could be used in a non-graphical console or in a terminal not using a nerd font
- the symbols i chose work in terminus font, at least
- my a4 config is configured to look like dvtm, which is meant to look like dwm
- eg:
    - `[ tty ][ |▒| 66% ][ |.:| 250921 ][ (-) 03:26pm ]`
- you can find my `a4.ini` config file in my [voiddots repo](https://github.com/apeir-n/voiddots)

`notify.sh`
- herbe is what i use for notifications, and it doesn't support changing settings via cli arguments
- i tried to write something in manually that could provide that functionality but couldn't get it to work
- so instead, i exploit the functionality of the xresources patch, which gives you access to all the settings at runtime
- currently, the only setting i wanted to dynamically alter is the width of the message box
    - `xrdb -query > /tmp/xres.bak` to save the current settings to a tmp file
    - `grep -v` everything but the width line, and echo a dynamic width into the database, given as the first arg to the function
    - run the message with the tmp settings
    - load back in the old settings
- this is implemented as a function and sourced into the other scripts
- this allows each module to run a cli program on left click, and to display the output as an herbe notification

`bat.sh`
- my thinkpad has 2 batteries, and i didn't like viewing the charge and status of each of them individually
    - so i just take the average of both of their charges with a bash math expression
    - then i get the icon through an if block
- i also wanted to get a notification if the charge gets below 20%, but if i put that in the if block it would notify me at every time increment from dwmblocks
    - so i have a separate if block that checks for a tmp file
    - if the file exists, then don't notify
    - if the file doesn't exist, then notify and then make the file afterwards
    - otherwise, if the charge is above 20%, delete the file for next time so i can be notified again once it drops below 20%
- but i also put another notification in main if block if the charge drops below 10%
    - this is so it notifies me at every time increment in dwmblocks, purposefully being annoying
    - i'm very forgetful so it's necessary lol
- currently no right click option
    - i was using battop on arch, but its not available in the void repos and i dont really care enough to build it

`date.sh`
- self explanatory
- also an excuse to use my favorite cli command, `cal`
    - super cute as a notification

`mem.sh`
- pretty self explanatory
- `awk` to mathify/format the output of `free`
    - (used) / (total) memory to get a percent
    - format it to 0 decimal places to get a round number

`play.sh`
- displays current system volume and play/pause/stop status of mpd
- it's run by a manual signal instead of a timer, so several methods are needed to cover all the bases
- heres the breakdown, as far as i understand:
    - dwmblocks works by running scripts by a signal number specified in blocks.h
    - usually the signals are managed by dwmblocks itself, providing a timer for each signal
    - when you want to run things manually and not timer-based, you need to send a signal to dwmblocks corresponding to the desired block
    - in my case, play.sh is given by signal 5 in blocks.h
- the icon in this script denotes the play status in mpd, and the percentage denotes the volume
- so i need to handle both of those things on a signal in order for the icon and percentage to update in real time
- this is achieved by running `pkill -RTMIN+5 dwmblocks`:
    - whenever i change the volume
        - currently handled in ~/.xbindkeysrc, but i might change that at some point
            - increase: `amixer set Master 5%+ unmute && pkill -RTMIN+5 dwmblocks`
            - decrease: `amixer set Master 5%- unmute && pkill -RTMIN+5 dwmblocks`
    - whenever the play status changes in mpd
        - handled in the script `mpc_watch`
            - a loop that executes the signal when `mpc idle player` returns any event
    - so both of of those events are what update the block
    - also, `pkill -RTMIN+5 dwmblocks` just sends 'signal #5' to dwmblocks, telling it to 'run play.sh'
- that's the main functionality. aside from that,
    - left click sends herbe notification with artist and song title
    - middle click toggles play/pause
    - right click opens my tui mpd client, rmpc
- additionally, an herbe notification is sent on song change
- the animal icons are just for fun because they're what i use in rmpc

`time.sh`
- self explanatory
- analog clock icon updates according to the current hour
    - got this idea from luke smith
    - he used emojis but i kinda hate the way they look in stuff like bars and terminals
    - i prefer nerd font icons

`void.sh`
- i just put the name of the os/environment i'm running dwm on in this block
- i also use dwm on freebsd and openbsd
- left click currently opens `wtfutil` for a system dashboard
- right click is a dmenu script with options to:
    - logout
    - reboot
    - poweroff

`weather.sh`
- previously entirely used wttr.in for the temperature/icon, left mouse click, and right mouse click
    - status: `curl -s 'https://wttr.in/?format=1'`
        - single line output, parsed and slightly reformatted for icon and temp
    - left click: `curl -s 'https://wttr.in/?0&T'`
        - small ascii art/conditions sent to herbe for notification
    - right click: `curl -s https://wttr.in`
        - full 3 day report, spawned in a terminal and hung with `read -n 1`
- i love wttr.in, but it's really bad for scripting
    - the server seems to go down a lot
    - really slow
    - sometimes just fails and glitches
- switched to a better (but not perfect) stack
- all are local binaries that happen to be written in go
    - status: `yr now --json`
        - pretty versatile weather cli, optional json output parsed with `jq`
    - left click: `stormy --compact`
        - small ascii weather report, sent to herbe as notification
    - right click: `wego`
        - output almost identical to wttr.in, again spawned in terminal and hung with `read`
- much faster and more reliable
- unfortunately `yr`'s json output for icons (`"codeSymbol"`) has an insane amount of options
- i put them all in an array in `wearray.sh` with lots of repetition and test against it for the icon
- still, much happier with this setup
