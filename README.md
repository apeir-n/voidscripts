# void scripts

### general notes

- most of these are scripts i wrote
- some of them are unfinished or sketches
- the scripts i didn't write will be notated here
- i usually have to edit scripts that other people write anyway to work on my system

etc/
- what it sounds like
- stuff that i don't want to delete yet or other random shit
- there's an updater script for arch in there that i was pretty proud of when i was running arch, feel free to steal

status/
- stuff for my dwm status bar, see the readme in there

---

### scripts

bcalc
- a sketch for a dmenu calculator
- it probably won't get fleshed out

binds
- a pretty rockin keybindings script if i say so myself
- it parses the general keyboard input array in the config header files of suckless project folders
- it works because i keep all my suckless projects in a dedicated directory
- depends on:
    - a directory containing subdirs of source code for suckless programs
    - subdirs named after the program (eg `dwm`, `nsxiv`)
    - `config.def.h` files
    - dmenu
        - with the border patch (only because of `-bw 3` flag)
- all of that stuff can be easily changed though of course, it's a short script
- it formats the text from the array by removing commas, quotes, braces, the `XK_` keysym prefix, etc

booksurf
- this is just from the bookmarks patch for the surf browser
- it's supposed to be implemented as a macro called from within the binary, which spawns a shell process with the commands
- i just extracted part of it and put it into a real external script so i could use an herbe notification wit it

brandr
- this is a little cli brightness menu that changes the brightness with xrandr
- changing the brightness with xrandr is pure software rendering
    - doesn't interface with your hardware's normal brightness controls
- i made this because my thinkpad's screen is pretty dark and dull looking
    - it gets washed out and makes some ui elements in gui apps difficult to see
    - being able to dial it in with a menu instead of just running the raw commands is nice
- runs in a loop where the input line is overwritten, so it's more like an interface
- uses escape codes to color some of the text
- awk does the floating point math to inc/dec the amount by 0.1
- changes the term settings with `stty` temporarily for a better ui
    - loads the original ones back before exiting
    - also loads the original settings back in case of interrupt or termination
- also a pretty rockin script that i'm proud of...

climp
- this script was originally written by [bread on penguins](https://github.com/BreadOnPenguins/scripts/blob/master/dmenu_cliphist)
- i tweaked it so i can try to run it on my setup
- unfinished

ddo
- this is the todo script from the [dmenu repo](https://tools.suckless.org/dmenu/scripts/todo)
- i tweaked it to keep the file at `~/.cache/scripts/todo`
- i think i made a couple more changes too

greppy
- just a sketch for viewing system logs from `svlog`
- unfinished

maim_slop
- screenshot script using `maim` and `slop`
    - doesn't actually use `slop` directly because it's integrated as a flag in `maim` of course
    - but when i was on wayland it was called grim_slurp cuz you actually do have to manually call `slurp` for that
    - so i kept the naming tradition because i love these stupid screenshot util names
- fullscreen vs selection is specified in the first argument as `maim_slop full` or `maim_slop select`
- sends herbe notification on completion

mpc_watch
- a loop for updating the status bar module `./status/play.sh`
- detailed info in `./status/README.md`

packup
- updates and rebuilds binaries in lang build systems/package managers
- recently experimenting with `gum style`
- optionally called from `./voidup`

paper
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

paperfold
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
- then the images in the subdirs are opened in `nsxiv` in thumbnail mode
- if an image is selected from `nsxiv`, it gets passed to the next script...

paperplane
- the same logic as `paper`, but it accepts the image as the first argument instead of choosing a random one
- i split this script out from `paperfold` so it was easier to pass files into it outside of the `paperfold` menu interface
    - for instance, passing the image file name from my file manager via a keybind to set the wallpaper instead

pkglist
- self explanatory
- uses `xpkg` from the `xtools` meta package for `xbps`

power
- simple logout/reboot/shutdown menu

prompto/i/a
- started as an attempt to rebuild my oh-my-posh prompt on my mac in pure zsh
- prompto is the one that gets pretty close
    - of course, omp lets you use a transient prompt instead of printing the whole thing every command
    - cant do that in native zsh prompt
    - also has more dynamically updatable modules like ram and exec time and stuff
    - but this has the aesthetic there at least
- below is a picture of them
    - the first being a simple one defined in zshrc as `#PROMPT="${newline}%K{1}%F{15} %D{%I:%M} %K{3} %n %K{4} %m %K{5} %~ %f%k ❯ "`
    - then in order of prompt -a, -i, -o
    - then a pic of oh my posh on my mac
    - ![promptoia](/etc/assets/promptoia.png)
    - ![ompmac](/etc/assets/ompmac.png)

recent
- unfinished sketch
- meant to view recent files in dmenu but it's fucked up

symenu
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
- it just uses dmenu to pick the file, cat the contents, select the symbols, and pass them to `xclip`

