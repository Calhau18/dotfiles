#!/bin/sh

userresources=$HOME/.Xresources
sysresources=/etc/X11/xinit/.Xresources

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

[ -f ~/.xprofile ] && . ~/.xprofile

test -f ~/.Xkeymap && xkbcomp ~/.Xkeymap $DISPLAY

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# allow custom scripts
export PATH=$HOME/bin:$PATH

change_bg &					  # change background
picom --config $HOME/.config/picom/picom.conf &   # compositor
redshift &                                        # set screen color temperature
xss-lock -n dim_screen -- lock &                  # lock screen when idle
i3-battery-popup -n -i "battery-low" -t 1m &      # notification when battery is low

xbindkeys &            # set keyboard shortcuts
xset r rate 250 30 &   # set keyboard repeat rate
xset m 2/1 4 &         # set mouse acceleration
xset s 360 240 &       # set screen saver timeout

dunst &                # notification daemon
touchegg &             # touchscreen and touchpad motion daemon

exec i3

sync_desktop
