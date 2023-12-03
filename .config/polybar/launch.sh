#!/usr/bin/env bash

# Terminate already running bar instances
polybar-msg cmd quit

polybar left --reload 2>&1 & disown
polybar center --reload 2>&1 & disown
polybar right --reload 2>&1 & disown
