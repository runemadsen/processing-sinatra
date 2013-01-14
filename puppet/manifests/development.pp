stage { 'req-install': before => Stage['rvm-install'] }

class requirements {
  group { "puppet": ensure => "present", }
  
  exec { "apt-update":
    command => "/usr/bin/apt-get -y update"
  }

  package { jdk:
    ensure  => installed, 
    name => $operatingsystem ? {
      centOS => "java-1.6.0-openjdk-devel",
      Ubuntu => "openjdk-6-jdk",
      default => "jdk",
    },
    require => Exec["apt-update"]
  }

  $packages = [
     "xfonts-100dpi",
     "xfonts-75dpi",
     "xfonts-scalable",
     "xfonts-cyrillic"
  ]

  package { 
     $packages : ensure => installed, 
     require => Exec["apt-update"],
  }
}

class installrvm {
  include rvm
  rvm::system_user { vagrant: ; }

  if $rvm_installed == "true" {
    rvm_system_ruby {
      'ruby-1.9.3-p362':
        ensure => 'present';
    }
  }
}

class doinstall {
  class { requirements:, stage => "req-install" }
  include installrvm
  include xvfb
}

include doinstall