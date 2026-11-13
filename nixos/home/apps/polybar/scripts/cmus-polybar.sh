#!/bin/sh

playerctl metadata --format '{{ status }}|{{ artist }} - {{ title }}' \
    --follow 2>/dev/null | while IFS='|' read -r status info; do
    case "$status" in
        Playing) echo "$info" ;;
        Paused) echo "[Paused] $info" ;;
        *) echo "" ;;
    esac
done
    
