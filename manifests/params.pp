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

  case $::operatingsystem {
    'centos', 'redhat', 'fedora': {
      $puppetmaster_package_name  = 'puppet-server'
      $puppetmaster_service_name  = 'puppetmaster'
      $puppetmaster_passenger_package = 'puppetmaster-passenger'
      package { 'puppetlabs-release':
        ensure   => present,
        source   => "http://yum.puppetlabs.com/el/6/products/x86_64/puppetlabs-release-${puppetmaster::puppetmaster_repo_version}.noarch.rpm",
        provider => rpm,
      }
    }
    'ubuntu', 'debian': {
      $puppetmaster_package_name  = 'puppetmaster'
      $puppetmaster_service_name  = 'puppetmaster'
      $puppetmaster_passenger_package = 'puppetmaster-passenger'
    }
    default: {
      fail("Unsupported osfamily: ${::osfamily} operatingsystem: ${::operatingsystem}, module ${module_name} only support osfamily RedHat and Debian")
    }
  }

}
