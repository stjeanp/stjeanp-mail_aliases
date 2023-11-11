# @summary The mail_aliases module manages /etc/aliases entries via hiera lookups.
#
# @example
# hiera usage
#
# mail_aliases:
#   root:
#     recipient: 'someone@somewhere.else.com'
#   user:
#     recipient: 'their@real.address'
#   olduser:
#     recipient: 'not@work.anymore'
#     ensure: absent
#
# @example
# Puppet usage
#
# include mail_aliases
#
# @author Pat St. Jean (stjeanp@pat-st-jean.com)
class mail_aliases {
  case $::facts['os']['family'] {
    'RedHat': {
      $aliases_file = '/etc/aliases'
      $newaliases = '/usr/bin/newaliases'
    }
    'Debian': {
      $aliases_file = '/etc/aliases'
      $newaliases = '/usr/bin/newaliases'
    }
    'Suse': {
      $aliases_file = '/etc/aliases'
      $newaliases = '/usr/bin/newaliases'
    }
    default: {
      fail("OS family '${::facts['os']['family']}' is not supported by this module.")
    }
  }

  # Our command to refresh the aliases database
  exec { 'newaliases':
    command     => $newaliases,
    refreshonly => true,
  }
  Mailalias { notify => Exec['newaliases'] }

  # We need a default hash in case there's no hiera data
  $not_found = { 'not found' => 'not found' }

  # Get all 'mail_aliases' data from hiera
  #$alias_hash = hiera_hash('mail_aliases', $not_found)
  $alias_hash = lookup('mail_aliases', undef, 'deep', $not_found)

  if 'not found' in $alias_hash {
    # If we didn't have any matches, print out an informational
    info('No aliases found.')
  } else {
    # Otherwise, process the resources...
    $defaults = {
      'ensure' => 'present',
    }
    create_resources(mailalias, $alias_hash, $defaults)
  }
}
