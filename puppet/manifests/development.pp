stage { 'before-rvm': 
  before => Stage['rvm-install']
}

stage { 'second':
 require => Stage['main']
}

class requirements
{
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
  rvm::system_user { vagrant: }
}

class installrest
{
  include xvfb

  rvm_system_ruby {
    'ruby-1.9.3-p385':
    ensure => 'present';
  }

  rvm_gemset { "ruby-1.9.3-p385@processing-sinatra":
    ensure => present,
    require => Rvm_system_ruby['ruby-1.9.3-p385'];
  }

  rvm_gem { 'ruby-1.9.3-p385@processing-sinatra/bundler':
    require => Rvm_gemset['ruby-1.9.3-p385@processing-sinatra']
  }

  exec { 'bundle-install':
      command => '/usr/local/rvm/bin/rvm ruby-1.9.3-p385@processing-sinatra do bundle install  --without production',
      cwd => '/vagrant',
      logoutput => true,
      require => Rvm_gem['ruby-1.9.3-p385@processing-sinatra/bundler'],
      user => 'vagrant'
  }
}

class { 'requirements':, stage => "before-rvm" }

class { 'installrvm': }

class { 'installrest':, stage => "second" }