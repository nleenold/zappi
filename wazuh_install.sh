#!/bin/sh

####### Check if CURL is installed
if ! rpm -qa | grep -qw curl; then
    dnf -y install curl 
fi


####### Download and run Wazuh All-In-One script
curl -so ~/all-in-one-installation.sh https://raw.githubusercontent.com/wazuh/wazuh-documentation/4.1/resources/open-distro/unattended-installation/all-in-one-installation.sh && bash ~/all-in-one-installation.sh


###### Reset Elasticsearch default password
curl -so wazuh-passwords-tool.sh https://raw.githubusercontent.com/wazuh/wazuh-documentation/4.1/resources/open-distro/tools/wazuh-passwords-tool.sh
bash wazuh-passwords-tool.sh -u admin -p Mys3curep@ssw0rd
bash wazuh-passwords-tool.sh -a > /usr/share/elasticsearch/plugins/opendistro_security/securityconfig/newpasswords.txt


######enable installed services
systemctl daemon-reload && systemctl enable wazuh-manager && systemctl start wazuh-manager
systemctl daemon-reload && systemctl enable elasticsearch && systemctl start elasticsearch
systemctl daemon-reload && systemctl enable kibana && systemctl start kibana


##########################   Method 1 ################################
####### Install puppet for configuration management
puppet module -y install wazuh-wazuh --version 4.0.4 
