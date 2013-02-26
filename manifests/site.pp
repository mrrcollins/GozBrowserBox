
Exec { path => "/bin:/sbin:/usr/bin:/usr/sbin" }

import "/etc/gbb/manifests/classes/*"

case $gbb_role {
    'localbrowser' : {
        notify{'Localbrowser setup':}
        include basesettings
        include browserapp
        include localbrowser
    }

    'remotebrowser' : {
        notify{'Remotebrowser setup':}
        include basesettings
        include remotebrowser 
    }

    'serverbrowser' : {
        notify{'Serverbrowser setup':}
        include basesettings
        include browserapp
        include serverbrowser 
    }
}


