#!/usr/bin/env bash

thereIsAnotherInstanceRunning=`ps aux | grep start-rotating-wallpapers | grep -v grep| wc -l`

if [ $thereIsAnotherInstanceRunning -eq 2 ]; then
    while true; do
        find ~/Images/wallpaper/ -type f \( -name '*.jpg' -o -name '*.png' \) -print0 |
        shuf -n2 -z | xargs -0 ~/.set-wallpapers.sh
        sleep 1m
    done
fi
