#!/bin/bash

if [ "$SSH_CLIENT" = "" ] ; then
    PROFILE=`whoami`
else
    PROFILE=`echo $SSH_CLIENT| awk '{print $1}'`
fi

export PULSE_SERVER=${PROFILE}
paplay /home/browser/lrblast1.ogg &

TERMINAL=`who | awk '{print $2}'`

rm -Rf /home/`whoami`/profiles/${PROFILE}
rm -Rf /home/`whoami`/Downloads

if test -z "$DBUS_SESSION_BUS_ADDRESS" ; then
    eval 'dbus-launch --sh-syntax --exit-with-session'
fi

dbus-launch /usr/bin/google-chrome --user-data-dir="/home/`whoami`/profiles/${PROFILE}" 

kill `ps | grep dbus-launch | grep -v grep | awk '{print $1}'`

rm -Rf /home/`whoami`/profiles/${PROFILE}
rm -Rf /home/`whoami`/Downloads
