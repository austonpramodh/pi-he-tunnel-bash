#!/bin/sh

echo "Installing the HE Tunnel config file"
mkdir -p /etc/pi-he-tunnel-bash
cp ./config.cfg /etc/pi-he-tunnel-bash/config.cfg

echo "Setting up the HE Tunnel"

. ./config.cfg
cp /etc/network/interfaces /etc/network/interfaces.bak

echo "
auto he-ipv6
iface he-ipv6 inet6 v4tunnel
        address $CLIENT_IPV6_ADDRESS
        netmask 64
        endpoint $SERVER_IPV4_ADDRESS
        local $CLIENT_LOCAL_IPV4_ADDRESS
        ttl 255
        gateway $SERVER_IPV6_ADDRESS

iface eth0 inet6 static
        address ${ROUTED_IPV6_PREFIX}1
        netmask 64
" >>/etc/network/interfaces

echo "Installing the HE Tunnel IP updater service"

cp ./src/he-ip-updater-service.sh /etc/pi-he-tunnel-bash/he-ip-updater-service.sh
chmod +x /etc/pi-he-tunnel-bash/he-ip-updater-service.sh

cp ./src/he-ip-updater.service /etc/systemd/system/he-ip-updater.service

echo "Starting the HE Tunnel IP updater service"

systemctl daemon-reload
systemctl enable he-ip-updater.service
systemctl start he-ip-updater.service

echo "Installing the RADVD service"

echo "
interface eth0
{
    AdvSendAdvert on;
    AdvHomeAgentFlag off;
    MinRtrAdvInterval 30;
    MaxRtrAdvInterval 100;
    prefix $ROUTED_IPV6_PREFIX/64
    {
        AdvOnLink on;
        AdvAutonomous on;
        AdvRouterAddr on;
    };
};
" >/etc/radvd.conf
apt-get install radvd
systemctl enable radvd.service
systemctl start radvd.service

echo "HE Tunnel Service installed successfully"

echo "Please reboot"
