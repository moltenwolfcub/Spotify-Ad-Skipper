#!/bin/bash

spotifyID="Spotify"
workspace=4
debug=false

if $debug
then
	echo "Started"
fi

wmctrl -x -c $spotifyID
until ! wmctrl -l |  grep -q -w $spotifyID; do
	sleep 0.1
done

if $debug
then
	echo "Closed"
fi

spotify &
until wmctrl -l | grep -q -w $spotifyID; do
	sleep 0.1
done

if $debug
then
	echo "Opened Again"
fi

wmctrl -x -r $spotifyID -t $workspace

if $debug
then
	echo "Set Workspace"
fi

dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Play 1>/dev/null

if $debug
then
	echo "Started Playing"
fi
