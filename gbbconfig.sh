#!/bin/sh

cd /etc/gbb
/usr/bin/git pull
/usr/bin/puppet apply /etc/gbb/manifests/localbrowser.pp

service lightdm restart

