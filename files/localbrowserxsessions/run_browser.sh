#!/bin/bash
/usr/bin/jwm &

/usr/bin/xbindkeys

#/usr/bin/pulseaudio --start
SINKNAME=`pacmd dump | grep -i set-default-sink | awk '{print $2}'`
#/usr/bin/pactl load-module module-native-protocol-tcp auth-anonymous=1
/usr/bin/pactl set-sink-mute $SINKNAME 0 
/usr/bin/pactl set-source-volume $SINKNAME 75%
paplay /home/browser/lrblast1.ogg &

TERMINAL=`who | awk '{print $2}'`

if test -z "$DBUS_SESSION_BUS_ADDRESS" ; then
        eval 'dbus-launch --sh-syntax --exit-with-session'
fi

PROFILE="/home/`whoami`/profiles/localuser"
DOWNLOADS="/home/`whoami`/profiles/localuser/Downloads"

rm -Rf "${PROFILE}"
rm -Rf "${DOWNLOADS}"

dbus-launch /usr/bin/google-chrome --user-data-dir="${PROFILE}"

kill `ps | grep dbus-launch | grep -v grep | awk '{print $1}'`

rm -Rf "${DOWNLOADS}"
rm -Rf "${PROFILE}"
