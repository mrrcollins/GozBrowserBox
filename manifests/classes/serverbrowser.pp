# Sets up the machine to be a Browser server
#

class serverbrowser {

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

    exec { '/usr/lib/lightdm/lightdm-set-defaults -s browser -m false -l false':
        require     => File['/usr/share/xsessions'],
        unless      => [ "test `cat /etc/lightdm/lightdm.conf | grep 'user-session=browser'` && test `cat /etc/lightdm/lightdm.conf | grep 'allow-guest=false'` && test `cat /etc/lightdm/lightdm.conf | grep 'greeter-show-manual-login=false'`"]
    }

    #exec { 'su browser -c "ssh-keygen -t rsa -f /home/browser/.ssh/browserkey -N \'\'"; \
    #        cp /home/browser/.ssh/browserkey /etc/gbb/files/browserkey; \
    #        chown 999 /etc/gbb/files/browserkey; \
    #        cp /home/browser/.ssh/browserkey.pub /home/browser/.ssh/authorized_keys': 
    #    alias   =>  'browserkeys',
    #    creates =>  '/home/browser/.ssh/browserkey',
    #}
    file { '/home/browser/.ssh':
        ensure          => directory,
        recurse         => true,
        purge           => true,
        force           => true,
        owner           => "browser",
        group           => "browser",
        mode            => 600,
        source          => "/etc/gbb/files/ssh",
    }


    file { '/home/browser/browser.sh':
        ensure  => file, 
        owner   => "browser",
        group   => "browser",
        mode    => 755,
        source  => "/etc/gbb/files/browser.sh",
    }

}
