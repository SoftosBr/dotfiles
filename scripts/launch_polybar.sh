#!/bin/sh

if pgrep -x polybar > /dev/null; then
  killall polybar
fi

for m in $(polybar --list-monitors | cut -d":" -f1); do
    MONITOR=$m polybar --reload skybar &
done
