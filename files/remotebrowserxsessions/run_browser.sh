#!/bin/bash
/usr/bin/ratpoison &

/usr/bin/xbindkeys

/usr/bin/pulseaudio --start
SINKNAME=`pacmd dump | grep -i set-default-sink | awk '{print $2}'`
/usr/bin/pactl load-module module-native-protocol-tcp auth-anonymous=1
/usr/bin/pactl set-sink-mute $SINKNAME 0 
/usr/bin/pactl set-source-volume $SINKNAME 50%

ssh -i ~/.ssh/browserkey -c arcfour,blowfish-cbc -YC -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no browser /home/browser/browser.sh
