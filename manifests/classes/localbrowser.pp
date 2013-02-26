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
    }

    file {'/home/browser/toggle-mute':
       ensure => file,
       owner => "browser",
       group => "browser",
       mode => 0755,
       source => "/etc/gbb/files/toggle-mute",
    }

}
