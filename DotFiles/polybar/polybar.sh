#!/bin/bash
killall polybar
polybar -c ~/.config/polybar/config.ini principal &
polybar -c ~/.config/polybar/config.ini tocando &
