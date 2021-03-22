### location = etc/puppetlabs/code/environments/production/manifests/
class wazuh_module::agent {
  file {'/etc/puppet/modules/wazuh_module/files/agent.sh':
      ensure => 'file',
      source => 'puppet:///modules/wazuh_module/files/agent.sh',
      path => '/usr/local/bin/agent.sh',
      owner => 'root'
      group => 'root'
      mode  => '0700', 
      notify => Exec['run_my_script'],
  }
  exec {
    'run_my_script':
     command => '/usr/local/bin/agent.sh',
     refreshonly => true,
  }
}
