#!/bin/sh

export FACTER_gbb_role=`cat /etc/gbb/role`

cd /etc/gbb
/usr/bin/git pull
/usr/bin/puppet apply /etc/gbb/manifests/site.pp

service lightdm restart

