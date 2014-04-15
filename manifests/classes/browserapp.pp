
class browserapp {

   if $architecture == "ppc" {
        package { 'midori':
            ensure  => latest,
            require => Exec['aptupdate'],
        }
    } else {
        file { '/opt/google/chrome/master_preferences':
            ensure  => file,
            owner   => "root",
            group   => "root",
            mode    => 0644,
            source  => "/etc/gbb/files/chrome_master_preferences",
            require => Package["google-chrome-stable"],
        }

        package { 'google-chrome-stable':
            ensure 		=> latest,
            require		=> [ Exec['aptupdate'] ];
        }
    }
}
