#### create the manifest for wazuh-agent
## location /etc/puppetlabs/code/environments/production/manifests/wazuh_agent.pp
node "client.test.com" {

  class { "wazuh::agent":
    wazuh_register_endpoint => "192.168.2.2",
    wazuh_reporting_endpoint => "192.168.2.1"
  }

}
