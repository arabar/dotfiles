#!/bin/sh

if [ -d /etc/X11/xinit/xinitrc.d ]; then
	for f in /etc/X11/xinit/xinitrc.d/*; do
		[ -x "$f" ] && . "$f"
	done
	unset f
fi

xrdb -merge ~/.Xresources           # update X resources db

# font update
xset +fp /usr/share/fonts/local
xset fp rehash

xset -b                             # turn off the beeper
xscreensaver -no-splash &           # start xscreensaver daemon
sh ~/.fehbg &                       # set the background image
start-pulseaudio-x11 &
mpd &                               # start MPD server

#pidof mpdscribble >& /dev/null
#if [ $? -ne 0 ]; then
#	mpdscribble &
#fi

pidof mpdas >& /dev/null
if [ $? -ne 0 ]; then
	mpdas &
fi

export PANEL_FIFO=/tmp/panel-fifo   # FIFO

# bspwm stuff
sxhkd &                             # start X hotkey daemon
exec bspwm                          # start wm
