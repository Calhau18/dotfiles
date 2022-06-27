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

polybar --reload CalhauBar &
change_bg
picom --config $HOME/.config/picom/picom.conf &
xbindkeys
redshift &
xss-lock lock &
exec i3
