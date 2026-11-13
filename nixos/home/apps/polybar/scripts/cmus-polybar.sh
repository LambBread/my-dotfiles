#!/bin/sh

if ! status=$(playerctl metadata --format '{{ status }}' 2>/dev/null); then
    echo "[No music player connected]"
    exit
fi

info=$(playerctl metadata --format '{{ artist }} - {{ title }}' 2>/dev/null)


case "$status" in
    Playing) echo "$info" ;;
    Paused) echo "[Paused] $info" ;;
    *) echo "" ;;
esac
