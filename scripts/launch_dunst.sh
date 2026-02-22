#!/bin/sh

if pgrep -x dunst > /dev/null; then
    killall -q dunst
fi

dunst &
