
class basesettings {

    case $lsbmajdistrelease {
    12: { exec { '/usr/lib/lightdm/lightdm-set-defaults -s browser -i false -m true -l false':
                 require     => [ File['/usr/share/xsessions'],
                 Package['lightdm'], ],
                 unless      => [ "test `cat /etc/lightdm/lightdm.conf | grep 'user-session=browser'` && test `cat /etc/lightdm/lightdm.conf | grep 'allow-guest=false'` && test `cat /etc/lightdm/lightdm.conf | grep 'greeter-show-manual-login=false'`"]
    } }

    13: { exec { '/usr/lib/lightdm/lightdm-set-defaults -s browser -i false -m true -l false -R false':} }

    14: { file { '/usr/share/lightdm/lightdm.conf.d/50-GozBrowserBox':
        ensure  => present,
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        content => ' [SeatDefaults]
        user-session=browser
        greeter-show-manual-login=false
        greeter-show-remote-login=false
        allow-guest=false
        ',
      }
    }
    }


    user { "browser":
        ensure     	=> present,
        shell      	=> '/bin/bash',
        home       	=> '/home/browser',
        managehome 	=> true,
        password 	=> '$1$ADUODeAy$eCJ1lPSxhSGmSvrmWxjLC1',
        groups      => ['audio'],
    }

    if $architecture == "ppc" {
        exec { 'apt-get update':
            alias   => "aptupdate",
            command => '/usr/bin/apt-get update',
            onlyif => "/bin/sh -c '[ ! -f /var/cache/apt/pkgcache.bin ] || /usr/bin/find /etc/apt/* -cnewer /var/cache/apt/pkgcache.bin | /bin/grep . > /dev/null'",
        }
   } else {
        exec { 'apt-get update':
            alias   => "aptupdate",
            command => '/usr/bin/apt-get update',
            require => File['/etc/apt/sources.list.d/google.list'],
            onlyif => "/bin/sh -c '[ ! -f /var/cache/apt/pkgcache.bin ] || /usr/bin/find /etc/apt/* -cnewer /var/cache/apt/pkgcache.bin | /bin/grep . > /dev/null'",
        }

        file { '/etc/apt/sources.list.d/google.list':
            alias           => "googlelist",
            ensure          => file,
            owner           => root,
            group           => root,
            mode            => 0644,
            source          => "/etc/gbb/files/google.list",
            require         => Exec["getgooglekey"],
        }

         exec { 'wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -':
            alias           => "getgooglekey",
            onlyif          => ["test `apt-key list | grep -i google | wc -l` -ne 1"],
        }
    }

    file { '/home/browser/profiles':
        ensure          => directory,
        owner           => "browser",
        group           => "browser",
        mode            => 755,
        require		=> User['browser'],
    }

# Base applications
    package { 'lightdm':
        ensure => installed,
        require => Exec['aptupdate'],
    }

    package { 'vim':
        ensure => installed,
        require => Exec['aptupdate'],
    }

    package { 'jwm':
        ensure => latest,
        require => Exec['aptupdate'],
    }

    file {'/home/browser/.jwmrc':
        ensure => file,
        owner => "browser",
        group => "browser",
        mode => 0755,
        source => "/etc/gbb/files/jwmrc",
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
}
