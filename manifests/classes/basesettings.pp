
class basesettings {
    Exec { path => "/bin:/sbin:/usr/bin:/usr/sbin" }

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
        require => File['/etc/apt/sources.list.d/google.list'],
        onlyif => "/bin/sh -c '[ ! -f /var/cache/apt/pkgcache.bin ] || /usr/bin/find /etc/apt/* -cnewer /var/cache/apt/pkgcache.bin | /bin/grep . > /dev/null'",
    }


    file { '/home/browser/profiles':
        ensure          => directory,
        owner           => "browser",
        group           => "browser",
        mode            => 755,
        require		=> User['browser'],
    }

}
