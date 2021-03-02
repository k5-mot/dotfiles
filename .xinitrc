#!/bin/sh
#
#	~/.xinitrc
#

## Not sleep display.
#xset s off
#xset -dpms
xset s noblank

## Load locale settings.
#export LANG="ja_JP.UTF-8"
#export LANGUAGE="eu_US.UTF-8"
#export LC_ALL="ja_JP.UTF-8"
export LANG="en_US.UTF-8"
#export LANGUAGE="eu_US.UTF-8"
export LC_ALL="en_US.UTF-8"

## Load ibus setting.
export XMODIFIERS="@im=ibus"
export GTK_IM_MODULE="ibus"
export QT_IM_MODULE="ibus"
#export GTK_IM_MODULE="xim"
#export QT_IM_MODULE="xim"
exec ibus-daemon -drx &

## Load default settings.
#if [ -d /etc/X11/xinit/xinitrc.d ]; then
#  for f in /etc/X11/xinit/xinitrc.d/*; do
#    [ -x "$f" ] && . "$f"
#  done
#  unset f
#fi

## Configuration file for xterm.
sysXresources=/etc/X11/cinit/.Xresources
userXresources=$HOME/.Xresources

## Load configuration file for xterm.
if [ -f "$sysXresources" ]; then
  xrdb -merge "$sysXresources"
fi
if [ -f "$userXresources" ]; then
  xrdb -merge "$userXresources"
fi

## Start Desktop environment.
exec gnome-session
#exec startxfce4
#exec startkde
#exec twm

