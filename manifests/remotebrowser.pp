# /etc/gbb/manifests/localbrowser.pp
#

Exec { path => "/bin:/sbin:/usr/bin:/usr/sbin" }

import "/etc/gbb/manifests/classes/*"

include basesettings
include ssh
include ratpoison

exec { '/usr/lib/lightdm/lightdm-set-defaults -s browser -m false -l false':
    require		=> File['/usr/share/xsessions'],
    unless		=> [ "test `cat /etc/lightdm/lightdm.conf | grep 'user-session=browser'` && test `cat /etc/lightdm/lightdm.conf | grep 'allow-guest=false'` && test `cat /etc/lightdm/lightdm.conf | grep 'greeter-show-manual-login=false'`"]
}

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
}

file {'/home/browser/toggle-mute':
   ensure => file,
   owner => "browser",
   group => "browser",
   mode => 0755,
   source => "/etc/gbb/files/toggle-mute",
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
}

