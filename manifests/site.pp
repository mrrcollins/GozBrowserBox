
Exec { path => "/bin:/sbin:/usr/bin:/usr/sbin" }

import "/etc/gbb/manifests/classes/*"

case $gbb_role {
    'localbrowser' : {
        include basesettings
        include googlechrome
        include ssh
        include ratpoison
        include localbrowser
    }

    'remotebrowser' : {
        include basesettings
        include ssh
        include ratpoison
        include remotebrowser 
    }

    'serverbrowser' : {
        include basesettings
        include googlechrome
        include ssh
        include ratpoison
        include serverbrowser 
    }
}


