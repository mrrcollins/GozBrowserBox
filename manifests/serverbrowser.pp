# Sets up the machine to be a Browser server
#

Exec { path => "/bin:/sbin:/usr/bin:/usr/sbin" }

import "/etc/gbb/manifests/classes/*"

include basesettings
include googlechrome
include ssh
include ratpoison


# I've had issues with apparmor conflicting with Chrome's built in Flash. I
# just stop and remove it for right now. :-)

package { 'apparmor':
    ensure  => absent,
}
package { 'apparmor-utils':
    ensure  => absent,
}

#exec { 'stopapparmor':
#    command => '/usr/sbin/update-rc.d -f apparmor remove',
#}

file { '/usr/share/xsessions':
    ensure          => directory,
    recurse          => true,
    purge           => true,
    force           => true,
    owner           => "root",
    group           => "root",
    mode            => 755,
    source          => "/etc/gbb/files/localbrowserxsessions",
}

exec { 'su browser -c "ssh-keygen -t rsa -f /home/browser/.ssh/browserkey -N \'\'"; \
        cp /home/browser/.ssh/browserkey /etc/gbb/files/browserkey; \
        chown 999 /etc/gbb/files/browserkey': 
    alias   =>  'browserkeys',
    creates =>  '/home/browser/.ssh/browserkey',
}

