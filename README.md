# mail\_aliases

## Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with mail\_aliases](#setup)
    * [What mail\_aliases affects](#what-mail_aliases-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with mail\_aliases](#beginning-with-mail_aliases)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)

## Description

The mail\_aliases module manages mail aliases on the target systems using data stored in hiera. It is capable of both creating and removing aliases, with the default being to create them.

## Setup

### Setup Requirements

This will only work if sendmail or postfix is installed on the target system. Please ensure that one of those packages is installed, otherwise you're going to get failures.

Please ensure that the puppetlabs/mailalias\_core module is installed.

### Beginning with mail\_aliases

Configure your hiera data however you would like, following the example below. Then update your Puppetfile to install stjeanp/mail\_aliases and puppetlabs/mailalias\_core modules.

## Usage

```yaml
 mail_aliases:
   root:
     recipient: 'someone@somewhere.else.com'
   user:
     recipient: 'their@real.address'
   olduser:
     recipient: 'not@work.anymore'
     ensure: absent
```

The default behavior is to create an alias, so if you need to remove one, make sure to include the 'ensure: absent' line.

```puppet
include mail_aliases
```

## Limitations

Due to testing VM availability, it only supports systems whose OS Family fact is RedHat, Debian, or SUSE.

## Development

Issues, merge requests, and feedback are always welcome.
