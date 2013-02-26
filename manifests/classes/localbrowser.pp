# /etc/gbb/manifests/classes/localbrowser.pp
#

class localbrowser {
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

    file {'/home/browser/lrblast1.ogg':
       ensure => file,
       owner => "browser",
       group => "browser",
       mode => 0755,
       source => "/etc/gbb/files/lrblast1.ogg",
        require => User['browser'],
    }


}
