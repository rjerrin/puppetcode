# == Function: nfs::functions::create_export
#
# This Function exists to
#  1. manage export creation
#
# === Parameters
#
# [*clients*]
#   String. Sets the clients allowed to mount the export with options.
#
# [*ensure*]
#   String. Sets if enabled or not.
#
# [*owner*]
#   String. Sets the owner of the exported directory.
#
# [*group*]
#   String. Sets the group of the exported directory.
#
# [*mode*]
#   String. Sets the permissions of the exported directory.
#
# === Examples
#
# This Function should not be called directly.
#
# === Links
#
# * {Puppet Docs: Using Parameterized Classes}[http://j.mp/nVpyWY]
#
#
# === Authors
#
# * Daniel Klockenkaemper <mailto:dk@marketing-factory.de>
#

define nfs::functions::create_export (
  $clients,
  $ensure = 'present',
  $owner  = undef,
  $group  = undef,
  $mode   = undef,
) {
  if $ensure != 'absent' {
    $line = "${name} ${clients}\n"

    concat::fragment { $name:
      target  => '/etc/exports',
      content => $line,
    }

    if ! defined(File[$name]) {
      file { $name:
        ensure => directory,
        owner  => $owner,
        group  => $group,
        mode   => $mode,
      }
    }
  }
}
