
class ratpoison {
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

}
