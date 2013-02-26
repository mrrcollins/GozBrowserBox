# /etc/gbb/manifests/localbrowser.pp
#

class remotebrowser {

    file { '/usr/share/xsessions':
        ensure          => directory,
        recurse          => true,
        purge           => true,
        force           => true,
        owner           => "root",
        group           => "root",
        mode            => 755,
        source          => "/etc/gbb/files/remotebrowserxsessions",
    }

    package { 'pulseaudio':
       ensure => installed,
       require => Exec['aptupdate'],
    }
       package { 'xbindkeys':
       ensure => latest,
       require => Exec['aptupdate'],
    }

    file {'/home/browser/.xbindkeysrc':
       ensure => file,
       owner => "browser",
       group => "browser",
       mode => 0755,
       source => "/etc/gbb/files/xbindkeysrc",
        require => User['browser'],
    }

    file {'/home/browser/toggle-mute':
       ensure => file,
       owner => "browser",
       group => "browser",
       mode => 0755,
       source => "/etc/gbb/files/toggle-mute",
        require => User['browser'],
    }

    file { "/etc/default/mouseemu":
       ensure  => file,
       owner   => "root",
       group   => "root",
       mode    => 755,
       source  => "/etc/gbb/files/mouseemu",
    }

    package { 'pulseaudio-utils':
        ensure => installed,
        require => Exec['aptupdate'],
    }

    file { '/home/browser/.ssh':
        ensure          => directory,
        recurse         => true,
        purge           => true,
        force           => true,
        owner           => "browser",
        group           => "browser",
        mode            => 600,
        source          => "/etc/gbb/files/ssh",
        require => User['browser'],
    }
}
