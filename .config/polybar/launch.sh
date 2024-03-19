#!/usr/bin/env bash

# Terminate already running bar instances
polybar-msg cmd quit

if [[ "$@" == "" ]]; then
    polybar left --reload 2>&1 & disown
    polybar center --reload 2>&1 & disown
    polybar right --reload 2>&1 & disown
else
    for bar in "$@"; do
	polybar $bar --reload 2>&1 & disown
    done
fi
