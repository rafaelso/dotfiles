#!/usr/bin/env bash

xrdb -load ~/.Xresources
trayer --edge top --align right --SetDockType true --SetPartialStrut true --expand true --width 6 --transparent true --alpha 0 --tint 0x000000 --height 16 --monitor 1 &
exec xmonad
