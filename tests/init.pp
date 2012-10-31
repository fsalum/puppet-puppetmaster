node 'puppet' {
  class { 'puppetmaster':
    puppetmaster_report               => 'true',
    puppetmaster_autosign             => 'true',
    puppetmaster_reports              => 'store, http',
    puppetmaster_reporturl            => 'http://puppet1.puppet.test:8080/reports/upload',
  }
}
