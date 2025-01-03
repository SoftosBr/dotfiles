#!/bin/sh

if pgrep -x dunst > /dev/null; then
    killall -q dunst
fi

ln -sf ~/.cache/wal/dunstrc ~/.config/dunst/dunstrc                       
dunst &