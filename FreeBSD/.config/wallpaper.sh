#!/bin/sh

while true; do
	if (which -s shuffle) then
		shuffle -p 1 ~/wallpaper/* | feh --bg-fill -f -
	else
		feh --randomize --bg-fill ~/wallpaper/*
	fi
	sleep 1200
done
