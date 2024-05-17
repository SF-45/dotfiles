#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/ssh-agent.socket"
# export PATH="${PATH}:/home/sf/bin"
#export GTK_OVERLAY_SCROLLING=0 #Нужно для работы Eclipse

#setxkbmap -model pc105 -layout us,ru -variant , -option grp:alt_shift_toggle -option terminate:ctrl_alt_bksp

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then

    xmodmap $sysmodmap

fi

if [ -f "$userresources" ]; then

    xrdb -merge "$userresources"

fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi


# dbus-update-activation-environment --all &
# ssh-agent &
# numlockx &
exec i3
