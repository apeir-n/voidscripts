# void scripts

### general notes

these are scripts that i use on my system running void linux. most of these were written by me, but those that weren't will be notated and probably given a link to the author's original script. but i usually have to or choose to edit other people's scripts to run best on my system anyway.

this readme is just notes on each script. it's laid out as the name of the script and then a bulleted list of information beneath it. i don't really like having excessive code comments, especially in the scripts i interact with and edit frequently, so i decided to put explanations and relevant info in this readme instead. i prefer to name my scripts without extensions so they're more natural to call from the command line. i symlink the ones i use frequently into my `$PATH` like `ln -s ~/scripts/hii ~/.local/bin`

>[!note]
> you may see coreutils prefixed with `sl`, like `slcat` and `slsetsid`, which is what i named the [sbase](http://core.suckless.org/sbase/) and [ubase](http://core.suckless.org/ubase/) versions of coreutils when i built them. i wanted to try them out without uninstalling my gnu coreutils or having any namespace conflicts. 

---

info on the 2 subdirectories in this repo:

`etc/`
- basically just what it sounds like
- stuff that i don't want to delete yet or other random shit
- there's an updater script for arch in there that i was pretty proud of when i was running arch, feel free to steal
- also an `/etc/assets` subdir for images

`status/`
- stuff mostly for my dwm status bar
- they're all explained in their own readme file

---

### scripts

`bcalc`
- a sketch for a dmenu calculator
- it probably won't get fleshed out

`binds`
- a pretty rockin keybindings script if i say so myself
- it parses the general keyboard input array in the config header files of suckless project folders
- it works because i keep all my suckless projects in a dedicated directory
- depends on:
    - a directory containing subdirs of source code for suckless programs
    - subdirs named after the program (eg `dwm`, `nsxiv`)
    - `config.def.h` files
    - dmenu
        - with the border patch (only because of `-bw 3` flag)
- an example of the dir structure would be like this:
```
~
└── .local
    └── src
        └── suckless
            ├── dwm
            │   ├── config.def.h      <- this is the only relevant file
            │   ├── config.h          <- this one is not parsed
            │   ├── config.mk             (i have my Makefiles configured
            │   ├── Makefile              to remove config.h files just
            │   ├── dwm.1                 to keep it simple, so i only ever
            │   └── dwm.c                 use config.def.h in my builds)
            ├── nsxiv
            │   └── config.def.h
            ├── st
            │   └── config.def.h
            ├── surf
            │   └── config.def.h
            ├── dmenu                 <- calling binds on dmenu will return
            │   └── config.def.h            nothing because it doesn't have
            └── tabbed                      a keys[] = { array }
                └── config.def.h
```
- all of the requirements can be easily changed though of course, it's a short script
- it formats the text from the array by removing commas, quotes, braces, the `XK_` keysym prefix, etc

`booksurf`
- this is just from the bookmarks patch for the surf browser
- it's supposed to be implemented as a macro called from within the binary, defined in `config.h`, which spawns a shell process with the commands
- i just extracted part of it and put it into a real external script so i could use an herbe notification with it

`brandr`
- this is a little cli brightness menu that changes the brightness with xrandr
- changing the brightness with xrandr is pure software rendering
    - doesn't interface with your hardware's normal brightness controls
- i made this because my thinkpad's screen is pretty dark and dull looking
    - but keeping it high all the time makes it look washed out in some contexts and makes some ui elements invisible
    - being able to dial it in and out with a menu instead of just running the raw commands is nice
- runs in a loop where the input line is overwritten, so it's more like an interface
- uses escape codes to color the text for fun
- awk does the floating point math to inc/dec the amount by 0.1
- changes the term settings with `stty` temporarily for a better ui
    - loads the original ones back before exiting
    - also loads the original settings back with a trap, in case of interruption or termination
- also a pretty rockin script that i'm proud of...

`climp`
- this script was originally written by [bread on penguins](https://github.com/BreadOnPenguins/scripts/blob/master/dmenu_cliphist)
- i tweaked it so i can try to run it on my setup
- unfinished

`ddo`
- this is the todo script from the [dmenu repo](https://tools.suckless.org/dmenu/scripts/todo)
- i tweaked it to keep the file at `~/.cache/scripts/todo`
- i think i made a couple more changes too

`dmoji`
- originally inspired by the [dmenumoji](https://github.com/valeriangalliat/dmenumoji) script
- but i didn't really like it so i basically completely rewrote it and made it simpler
- it just copies the emoji to clipboard instead of using xdotool to write it
- you can find the emoji.txt file in the repo linked above

`gessage`
- `[g]it m[essage]`
- just prints a cute message with date, time, and user, with no newline

`greppy`
- just a sketch for viewing system logs from `svlog`
- unfinished

`maim_slop`
- screenshot script using `maim` and `slop`
    - doesn't actually use `slop` directly because it's integrated as a flag in `maim` of course
    - but when i was on wayland it was called grim_slurp cuz you actually do have to manually call `slurp` for that
    - so i kept the naming convention because i love these stupid screenshot util names
- fullscreen vs selection is specified in the first argument as `maim_slop full` or `maim_slop select`
- sends herbe notification on completion

`mpc_watch`
- a loop for updating the status bar module `/status/play.sh`
- detailed info in `/status/README.md`

`obsidian_sync`
- syncs my obsidian vault's private git repo
- stages, commits, pushes, and pulls

`packup`
- updates and rebuilds binaries in lang build systems/package managers
- recently experimenting with `gum style`

`paper`
- finds random wallpaper from `~/Pictures/wallpapers`
- uses pywal16 to set the wallpaper
    - the `wal` call is run from `timeout 6s` because pywal doesn't like some wallpapers for some reason
        - if it's allowed to keep trying, it'll overwork my thinkpad and make the fan come on and shit
        - so i cut it off at 6 seconds
    - if `wal` succeeds, then:
        - the xresources database is updated with the new colors
        - dwm's colors are updated from the xrdb
            - needs the ipc patch which adds cli support to dwm
        - then the file gets logged as successful in `~/.cache/scripts`
    - if it doesn't succeed, the file gets logged so i can keep track of which files fuck pywal up

`paperfold`
- this makes a wallpaper menu if i want a specific wallpaper
- i have my wallpapers organized into subcategories:
```
~/Pictures
└── wallpapers
    ├── _b&w      # black and white
    ├── _in       # indoors
    ├── _out      # outdoors
    ├── _pxl      # pixel art
    ├── _txtr     # textures and abstract
    └── _wrd      # weird stuff, etc
```
- i have a whole system
- anyways, the subdirs are `ls`'ed and piped into dmenu to be selected
- on subdir selection, the images inside are opened in `nsxiv` in thumbnail mode
- if an image is selected from `nsxiv`, it gets passed to the next script...

`paperplane`
- the same logic as `paper`, but it accepts the image as the first argument instead of choosing a random one
- i split this script out from `paperfold` so it was easier to pass files into it outside of the `paperfold` menu interface
    - for instance, passing the image file name to the script from a file manager via a keybind to set the wallpaper instead

`pkglist`
- self explanatory
- uses `xpkg` from the `xtools` meta package for `xbps` and views them in dmenu

`power`
- simple logout/reboot/shutdown menu

`prompto/i/a`
- started as an attempt to rebuild my `oh-my-posh` prompt on my mac in pure zsh
- `prompto` is the one that gets pretty close
    - of course, omp lets you use a transient prompt instead of printing the whole thing every command, which you can't do in the native zsh prompt
    - omp also has more dynamically updatable modules like ram and exec time and stuff
    - but this has the aesthetic at least
- i honestly don't even like using omp... i literally only use it for the transient prompt aspect
    - if i can figure out a way to do that in pure zsh, i'll ditch it
- anyway, below is a picture of them
    - the first being a simple one defined in zshrc as `#PROMPT="${newline}%K{1}%F{15} %D{%I:%M} %K{3} %n %K{4} %m %K{5} %~ %f%k ❯ "`
        - this was inspired by [bread on penguin's](https://github.com/BreadOnPenguins/dots/blob/master/.config/zsh/.zshrc) prompt
    - then, listed in the order of prompt -a, -i, -o
    - then a pic of my `oh-my-posh` prompt on my mac
    - ![promptoia](/etc/assets/promptoia.png)
    - ![prompus](/etc/assets/prompus.png)
    - `zz` is an alias for `nvim ~/.zshrc` and `rz` is `source ~/.zshrc` if you were wondering
- implementing the prompt as a function with local variables makes it way easier to read and modify
    - i have one function for formatting the sections, `promptoid()`, which sets up the fg and bg colors and the zsh prompt escape code
    - then inside of `promptina()`, i lay out the little promptoids by calling `promptoid()` for each module i want in my prompt
        - such as username `%n`, hostname `%m`, date `%D{%I:%M}`, etc
        - all these are given as arg 3 to `promptoid()`, and the fg color given as arg 1, and bg as 2
    - then they're just delivered from an echo statement at the end to stdout as a string, and the whole string is passed to `PROMPT=$(promptina)`
    - `prompto` is slightly more complicated:
        - i use a half-circle delimiter thing and wrap it in a fg color declaration like `%F${color1}%f`
        - then for the body, i use `%K${color1}` to set the bg color to the same as the delim's fg color, and set the fg for the text
        - then, the text is given as the zsh prompt escape code which expands to whatever you're calling, like hostname or time, etc
        - having all of that formatting abstracted into a function makes it so much easier to work with
    - `prompti` is similar to `prompto` but without the modules separated out using the round delimiters
    - `prompta` is like `prompta` but with no icons

`randy`
- just an xrandr alt monitor shortcut

`rune`
- nothing currently, really
- but i was thinking of making a simpler way to call `runal` with a js file
- [runal](https://empr.cl/runal/) is a really sick ascii graphics program for livecoding btw

`symenu`
- menu for grabbing symbols from a file
- i have a couple files in `~/Documents/menus` that have various useful symbols that i'd otherwise have to hunt for online or something
- in particular, symbols for:
```
  ╔══════════════╗
┌─────────┐ <3   ║
│ drawing╭─────╮ ║
└────────│ fun │ ║
  ║ boxes╰─────╯ ║
  ╚══════════════╝
```
- it just uses dmenu to:
    - pick the file
    - cat the contents
    - select the symbols
    - and pass them to `xclip`

`voidup`
- my void updater script
- i recently refactored a little bit to use `gum` by charmbracelet for some stuff
- some things need to be fixed, but it just makes updating simpler
- also optionally calls `packup` for updating lang packages at the end

`xbps-slay`
- a stupid `xbps-src` wrapper script lol
- needs a lot of work still
- but the idea is to make building with `xbps-src` simpler
- it was my first script attempting to use `gum` so it's heavily saturated with gum

`xtra`
- extra x11 stuff to launch when i'm in a classic x wm like ctwm or fvwm
- i've been calling this manually instead of from `~/.xinitrc` because it was being glitchy for some reason
