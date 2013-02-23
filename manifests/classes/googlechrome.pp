
class googlechrome {
    file { '/opt/google/chrome/master_preferences':
        ensure  => file,
        owner   => "root",
        group   => "root",
        mode    => 0644,
        source  => "/etc/gbb/files/chrome_master_preferences",
        require => Package["google-chrome-stable"],
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
        require		=> [ Exec['aptupdate'] ];
    }



}
