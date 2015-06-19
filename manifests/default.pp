
# update-locale LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8
# locale-gen

exec { 'apt-get update':
    command => "/usr/bin/apt-get update",
}

Package {
    require => Exec["apt-get update"]
}

package {
    ["build-essential",
     "bundler",
     "gcc",
     "gettext",
     "git",
     "jed",
     "libfreetype6-dev",
     "libicu-dev",
     "libjpeg-dev",
     "libssl-dev",
     "libxml2-dev",
     "libxslt1-dev",
     "make",
     "mercurial",
     "nginx-full",
     "npm",
     "python-dev",
     "python-lxml",
     "python-m2crypto",
     "python-pip",
     "python-virtualenv",
     "swig",
     "vim",
     "zlib1g"]:
    ensure => installed;
}

file { "/run/local":
    ensure => directory,
    owner => "vagrant",
    group => "vagrant";
}

file { "/etc/nginx/local":
    ensure => symlink,
    target => "/etc/nginx/sites-enabled";
}

file { "/etc/nginx/sites-enabled":
    ensure => directory,
    owner => "vagrant",
    group => "vagrant";
}

# sed -i 's#sites-enabled/\*;#sites-enabled/*.conf;#' /etc/nginx/nginx.conf


file { ["/etc/nagios",
        "/etc/nagios/nrpe",
        "/etc/nagios/nrpe/local"]:
    ensure => directory,
    owner => "vagrant",
    group => "vagrant";
}

file { "/home/vagrant/.ssh/config":
    content => "\
Host bitbucket.org
    UserKnownHostsFile /dev/null
    StrictHostKeyChecking no
Host github.com
    UserKnownHostsFile /dev/null
    StrictHostKeyChecking no
",
    owner => "vagrant",
    group => "vagrant";
}

file { "/usr/bin/node":
    ensure => symlink,
    target => "/usr/bin/nodejs";
}

exec { 'apt-get autoremove':
    command => "/usr/bin/apt-get -y autoremove"
}
