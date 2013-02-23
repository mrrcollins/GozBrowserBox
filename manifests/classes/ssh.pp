
class ssh {
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
