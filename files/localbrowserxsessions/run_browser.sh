#!/bin/bash
/usr/bin/ratpoison &

TERMINAL=`who | awk '{print $2}'`

if test -z "$DBUS_SESSION_BUS_ADDRESS" ; then
        eval 'dbus-launch --sh-syntax --exit-with-session'
fi

rm -Rf /home/`whoami`/profile

dbus-launch /usr/bin/google-chrome --user-data-dir="/home/`whoami`/profile/"

kill `ps | grep dbus-launch | grep -v grep | awk '{print $1}'`
rm -Rf /home/`whoami`/profile
