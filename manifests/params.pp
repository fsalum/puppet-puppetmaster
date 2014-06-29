# Class: puppetmaster::params
#
# This class configures parameters for the puppet-puppetmaster module.
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class puppetmaster::params {

  case $::osfamily {
    'RedHat': {
      $puppetmaster_packages_name = [ 'puppet-server' ]
      $puppetmaster_service_name  = 'puppetmaster'
      if ! defined(Package['puppetlabs-release']) {
        package { 'puppetlabs-release':
          ensure   => present,
          source   => 'http://yum.puppetlabs.com/puppetlabs-release-el-6.noarch.rpm',
          provider => rpm,
        }
      }
    }
    'Debian': {
      $puppetmaster_packages_name = [ 'puppetmaster', 'puppetmaster-common' ]
      $puppetmaster_service_name  = 'puppetmaster'
    }
    default: {
      fail("Unsupported osfamily: ${::osfamily} operatingsystem: ${::operatingsystem}, module ${module_name} only support osfamily RedHat and Debian")
    }
  }

}
