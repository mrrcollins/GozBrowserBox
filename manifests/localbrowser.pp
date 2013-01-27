# /etc/gbb/manifests/localbrowser.pp

class localbrowser {
    user { "browser":
        ensure     	=> present,
        shell      	=> '/bin/bash',
        home       	=> '/home/browser',
        managehome 	=> true,
        password 	=> '$1$ADUODeAy$eCJ1lPSxhSGmSvrmWxjLC1',
    }

    exec { 'apt-get update':
        alias   => "aptupdate",
        command => '/usr/bin/apt-get update',
        onlyif => "/bin/sh -c '[ ! -f /var/cache/apt/pkgcache.bin ] || /usr/bin/find /etc/apt/* -cnewer /var/cache/apt/pkgcache.bin | /bin/grep . > /dev/null'",
    }

    package { 'openssh-server':
        ensure => installed,
        require => Exec['aptupdate'],
    }

    service { 'ssh':
        ensure => running,
        enable => true,
        hasstatus => true,
        hasrestart => true,
        require => Package['openssh-server'],
    }

    package { 'ratpoison':
        ensure => latest,
        require => Exec['aptupdate'],
    }

    file {'/home/browser/.ratpoisonrc':
        ensure => file,
        owner => "browser",
        group => "browser",
        mode => 0755,
        source => "/etc/gbb/files/ratpoisonrc",
    }

    exec { '/usr/lib/lightdm/lightdm-set-defaults -s browser -m false -l false':
        require		=> File['/usr/share/xsessions'],
        unless		=> [ "test `cat /etc/lightdm/lightdm.conf | grep 'user-session=browser'` && test `cat /etc/lightdm/lightdm.conf | grep 'allow-guest=false'` && test `cat /etc/lightdm/lightdm.conf | grep 'greeter-show-manual-login=false'`"]
    }

    file { '/home/browser/profiles':
        ensure          => directory,
        owner           => "browser",
        group           => "browser",
        mode            => 755,
        require		=> User['browser'],
    }

    file { '/opt/google/chrome/master_preferences':
        ensure  => file,
        owner   => "root",
        group   => "root",
        mode    => 0644,
        source  => "/etc/gbb/files/chrome_master_preferences",
    }

    exec { 'wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -':
        alias		=> "getgooglekey",
        onlyif		=> ["test `apt-key list | grep -i google | wc -l` -ne 1"],
    }

    file { '/etc/apt/sources.list.d/google.list':
        alias		=> "googlelist",
        ensure		=> file,
        owner		=> root,
        group		=> root,
        mode		=> 0644,
        source		=> "/etc/gbb/files/google.list",
        require		=> Exec["getgooglekey"],
    }

    package { 'google-chrome-stable':
        ensure 		=> latest,
        require		=> File['/etc/apt/sources.list.d/google.list'];
    }

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
}
