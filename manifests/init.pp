# == Class: puppetmaster
#
# This class installs and configures Puppet Master
#
# === Parameters
#
# [*puppetmaster_package_ensure*]
#   Specify the package update state. Defaults to 'present'. Possible value is 'latest'.
#
# [*puppetmaster_service_ensure*]
#   Specify the service running state. Defaults to 'running'. Possible value is 'stopped'.
#
# [*puppetmaster_service_enable*]
#   Specify the service enable state. Defaults to 'true'. Possible value is 'false'.
#
# [*puppetmaster_server*]
#   Specify the Puppet Master server name.
#
# [*puppetmaster_certname*]
#   Specify the Puppet Master certificate name. It is usually the server hostname.
#
# [*puppetmaster_report*]
#   Send reports after every transction. Defaults to 'true'. Possible value is 'false'.
#
# [*puppetmaster_autosign*]
#   Whether to enable autosign. Defaults to 'false'. Possible value is 'true' or file path.
#
# [*puppetmaster_reports*]
#   List of reports to generate. See documentation for possible values.
#
# [*puppetmaster_reporturl*]
#   The URL used by the http reports processor to send reports.
#
# [*puppetmaster_facts_terminus*]
#   The node facts terminus. Default to facter. Possible value is 'PuppetDB'.
#
# [*puppetmaster_modulepath*]
#   Defines the module path.
#
# === Variables
#
# === Examples
#
#  class { puppetmaster:
#    puppetmaster_server               => 'puppet1.puppet.test',
#    puppetmaster_certname             => 'puppet1.puppet.test',
#    puppetmaster_report               => 'true',
#    puppetmaster_autosign             => 'true',
#    puppetmaster_reports              => 'store, http',
#    puppetmaster_reporturl            => 'http://puppet1.puppet.test:8080/reports/upload',
#    puppetmaster_facts_terminus       => 'PuppetDB',
#    puppetmaster_modulepath           => '$confdir/modules:$confdir/modules-0',
#  }
#
# === Authors
#
# Felipe Salum <fsalum@gmail.com>
#
# === Copyright
#
# Copyright 2012 Felipe Salum, unless otherwise noted.
#
class puppetmaster (
  $puppetmaster_package_ensure       = 'present',
  $puppetmaster_service_ensure       = 'running',
  $puppetmaster_service_enable       = 'true',
  $puppetmaster_server               = '',
  $puppetmaster_certname             = '',
  $puppetmaster_report               = 'true',
  $puppetmaster_autosign             = 'false',
  $puppetmaster_reports              = '',
  $puppetmaster_reporturl            = '',
  $puppetmaster_facts_terminus       = '',
  $puppetmaster_modulepath           = '',
) {

  include puppetmaster::params

  $puppetmaster_package_name = $puppetmaster::params::puppetmaster_package_name
  $puppetmaster_service_name = $puppetmaster::params::puppetmaster_service_name

  package { $puppetmaster_package_name:
    ensure  => $puppetmaster_package_ensure,
  }

  # We will need to restart the puppet master service if certain config
  # files are changed, so here we make sure it's in the catalog.
  if ! defined(Service[$puppetmaster_service_name]) {
    service { $puppetmaster_service_name:
      ensure     => $puppetmaster_service_ensure,
      enable     => $puppetmaster_service_enable,
      hasrestart => true,
      hasstatus  => true,
      require    => Package[$puppetmaster_package_name],
    }
  }

  Ini_setting {
    path    => '/etc/puppet/puppet.conf',
    ensure  => present,
  }

  if ($puppetmaster_modulepath) {
    ini_setting { 'puppetmaster_modulepath':
      section => 'main',
      setting => 'modulepath',
      value   => $puppetmaster_modulepath,
    }
  }

  if ($puppetmaster_server) {
    ini_setting { 'puppetmaster_server':
      section => 'main',
      setting => 'server',
      value   => $puppetmaster_server,
    }
  }

  if ($puppetmaster_report) {
    ini_setting { 'puppetmaster_report':
      section => 'agent',
      setting => 'report',
      value   => $puppetmaster_report,
    }
  }

  if ($puppetmaster_certname) {
    ini_setting { 'puppetmaster_certname':
      section => 'master',
      setting => 'certname',
      value   => $puppetmaster_certname,
    }
  }

  if ($puppetmaster_autosign) {
    ini_setting { 'puppetmaster_autosign':
      section => 'master',
      setting => 'autosign',
      value   => $puppetmaster_autosign,
    }
  }

  if ($puppetmaster_reports) {
    ini_setting { 'puppetmaster_reports':
      section => 'master',
      setting => 'reports',
      value   => $puppetmaster_reports,
    }
  }

  if ($puppetmaster_reporturl) {
    ini_setting { 'puppetmaster_reporturl':
      section => 'master',
      setting => 'reporturl',
      value   => $puppetmaster_reporturl,
    }
  }

  if ($puppetmaster_facts_terminus) {
    ini_setting { 'puppetmaster_facts_terminus':
      section => 'master',
      setting => 'facts_terminus',
      value   => $puppetmaster_facts_terminus,
    }
  }

}
