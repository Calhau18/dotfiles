#!/usr/bin/env bash

# Terminate already running bar instances
polybar-msg cmd quit

if [[ "$@" == "" ]]; then
    polybar left --log=error --reload 2>&1 & disown
    polybar center --log=error --reload 2>&1 & disown
    polybar right --log=error --reload 2>&1 & disown
else
    for bar in "$@"; do
	polybar $bar --reload 2>&1 & disown
    done
fi
