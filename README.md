Puppet Master Module for Puppet
===============================
[![Build Status](https://secure.travis-ci.org/fsalum/puppet-puppetmaster.png)](http://travis-ci.org/fsalum/puppet-puppetmaster)

Use this module to deploy a puppetmaster server via 'puppet apply' command and
avoid using a few manual steps.

Requirements
------------

It requires the PuppetLabs Repository added before using the module.

For *Debian* systems:

```bash
$ puppet module install puppetlabs-apt
```

And then add data below to your node resource:

      apt::source { 'puppetlabs':
        location   => 'http://apt.puppetlabs.com',
        repos      => 'main dependencies',
        key        => '4BD6EC30',
        key_server => 'pgp.mit.edu',
      }

For *RHEL* systems:

      yumrepo {
      'puppetlabs-products':
        name           => 'puppetlabs-products',
        descr          => 'Puppet Labs Products El 6 - $basearch',
        baseurl        => 'http://yum.puppetlabs.com/el/6/products/$basearch',
        priority       => '5',
        failovermethod => 'priority',
        enabled        => '1',
        gpgcheck       => '1',
        gpgkey         => 'http://yum.puppetlabs.com/RPM-GPG-KEY-puppetlabs';
       'puppetlabs-deps':
        name           => 'puppetlabs-deps',
        descr          => 'Puppet Labs Dependencies El 6 - $basearch',
        baseurl        => 'http://yum.puppetlabs.com/el/6/dependencies/$basearch',
        priority       => '5',
        failovermethod => 'priority',
        enabled        => '1',
        gpgcheck       => '1',
        gpgkey         => 'http://yum.puppetlabs.com/RPM-GPG-KEY-puppetlabs';
     }


Quick Start
-----------

```bash
$ puppet module install fsalum-puppetmaster
```

Include the following in your master.pp if you plan to install puppetmaster with passenger:

         include apache::mod::passenger

         class { puppetmaster:
           puppetmaster_service_ensure       => 'stopped',
           puppetmaster_service_enable       => 'false',
           puppetmaster_report               => 'true',
           puppetmaster_autosign             => 'true',
           puppetmaster_modulepath           => '$confdir/modules:$confdir/modules-0',
         }

And run: 

```bash
$ puppet apply --modulepath /etc/puppet/modules master.pp
```

Parameters
----------

You can also set some extra parameters to enable or disable a few options:

* `puppetmaster_package_ensure`

    Specify the package update state. Defaults to 'present'. Possible value is 'latest'.

* `puppetmaster_service_ensure`

    Specify the service running state. Defaults to 'running'. Possible value is 'stopped'.

* `puppetmaster_service_enable`

    Specify the service enable state. Defaults to 'true'. Possible value is 'false'.

* `puppetmaster_server`

    Specify the Puppet Master server name. 

* `puppetmaster_certname`

    Specify the Puppet Master certificate name. It is usually the server hostname. 

* `puppetmaster_report`

    Send reports after every transction. Defaults to 'true'. Possible value is 'false'.

* `puppetmaster_autosign`

   Whether to enable autosign. Defaults to 'false'. Possible value is 'true' or file path.

* `puppetmaster_reports`

   List of reports to generate. See documentation for possible values.

* `puppetmaster_reporturl`

   The URL used by the http reports processor to send reports.

* `puppetmaster_facts_terminus`

   The node facts terminus. Defaults to facter. Possible value is 'PuppetDB'.

* `puppetmaster_modulepath`

   Defines the module path.

* `puppetmaster_templatepath`

   Defines the template path.

Author
------
Felipe Salum <fsalum@gmail.com>
