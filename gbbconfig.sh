#!/bin/bash

if [[ `hostname` =~ ^sb-.* ]]; 
then 
    export FACTER_gbb_role="serverbrowser"
elif [[ `hostname` =~ ^rb-.* ]]; 
then 
    export FACTER_gbb_role="remotebrowser"
else 
    export FACTER_gbb_role="localbrowser"
fi

cd /etc/gbb
/usr/bin/git pull
/usr/bin/puppet apply /etc/gbb/manifests/site.pp

service lightdm restart

