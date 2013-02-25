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
}
