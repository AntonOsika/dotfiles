# Commands
* `free -h` for ram usage
* `df -h` for disk usage
* `powertop` / `powerstat` to see if battery can be optimised
* `dpkg` handles installed packages. apt handles dependency chain.

## Setup
* Use 'intl. with dead keys' keyboard -> alt + qw = äå
* caps to esc through tweaks

## Power usage
* Uninstall e.g. habitlab (30% cpu usage)
* Suspend and should work out of the box. sudo systemctl suspend -i makes it suspend faster
* sudo tlp start and sudo pm-powersave true potentially help save power
* decided to not bother with complicated tpacpi-bat although recommended by medium tweak post
* Configure tlp with UI to save battery health. `sudo tlp fullcharge` before going remote. 
* Configure tlp to reset health thresholds every unplug.

## Workflow
* Shrink dock to minimal
* Rebind key theme to something similar to emacs (ask Viktor)
* Use gnomes bindings to switch between favorite apps
* Copyq for clipboard. 
* Copyq for pasting date (although formatting needs to be fixed)

## run as root on startup (fix IR webcam)
* Add it in /etc/init.d/rc.local
* configure default webcam by removing the incorrect one `rm -f /dev/video0`

## suspend on T480
* Can sometimes not restore after suspend
* Seems related to using an external monitor eetc
* Can disable suspend like so: https://askubuntu.com/questions/15520/how-can-i-tell-ubuntu-to-do-nothing-when-i-close-my-laptop-lid
* Created bindings of ss and hn to suspend and hibernate

