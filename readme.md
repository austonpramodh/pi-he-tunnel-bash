# Pi HE Tunnel Installer

Install Hurricane IPv6 Tunnel easily


## Steps to install

1. Register on Tunnel broker and create new tunnel at https://tunnelbroker.net/

1. Setup the config.cfg file
   ```bash
    SERVER_IPV4_ADDRESS="244.66.67.30"
    SERVER_IPV6_ADDRESS="2001:1234:1234:194::1"
    CLIENT_IPV6_ADDRESS="2001:1234:1234:194::2"
    CLIENT_LOCAL_IPV4_ADDRESS="2001:1234:1234:194::2"
    ROUTED_IPV6_PREFIX="2001:1234:1234:194::"
    UPDATEURL="https://username:apikey@ipv4.tunnelbroker.net/nic/update?hostname=hostid"
    UPDATE_INTERVAL="30"
    ```


2. Install the service
    
    sudo chmod +x ./install.sh
    sudo ./install.sh

