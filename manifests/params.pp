# == Class: docker::params
#
# Defaut parameter values for the docker module
#
class docker::params {
  $version                      = undef
  $ensure                       = present
  $tcp_bind                     = undef
  $socket_bind                  = 'unix:///var/run/docker.sock'
  $socket_group                 = undef
  $use_upstream_package_source  = true
  $service_state                = running
  $service_enable               = true
  $root_dir                     = undef
  $dns                          = undef
  $proxy                        = undef
  $no_proxy                     = undef
  $execdriver                   = undef
  $storage_driver               = undef
  $manage_package               = true
  $manage_kernel                = true
  case $::osfamily {
    'Debian' : {
      if $::operatingsystem == 'Ubuntu' {
        case $::operatingsystemrelease {
          '14.04' : { $package_name = 'docker.io' }
          default: { $package_name = 'lxc-docker' }
        }
      }
      $package_source_location = 'https://get.docker.io/ubuntu'
    }
    'RedHat' : {
      if versioncmp($::operatingsystemrelease, '6.5') < 0 {
        fail('Docker needs RedHat/CentOS version to be at least 6.5.')
      }
      $package_name = 'docker-io'
      $package_source_location = ''
    }
    default: {
      fail("${::osfamily} not supported.")
    }
  }
}
