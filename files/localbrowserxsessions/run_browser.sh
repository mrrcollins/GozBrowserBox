#!/bin/bash
/usr/bin/ratpoison &

TERMINAL=`who | awk '{print $2}'`

if test -z "$DBUS_SESSION_BUS_ADDRESS" ; then
        eval 'dbus-launch --sh-syntax --exit-with-session'
fi

dbus-launch /usr/bin/google-chrome --disable-bundled-ppapi-flash  
#dbus-launch /usr/bin/google-chrome --user-data-dir="/home/browser/profiles/${PROFILE}" --no-default-browser-check chrome://signin/?source=0&next_page=http%3A%2F%2Fwww.kentoncityschools.org%2F
#dbus-launch /usr/bin/google-chrome --user-data-dir="/home/browser/profiles/${PROFILE}" --no-first-run --no-default-browser-check --disable-file-system

#dbus-launch /usr/bin/firefox

kill `ps | grep dbus-launch | grep -v grep | awk '{print $1}'`

