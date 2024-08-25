#!/usr/bin/env bash
#
export dnsServers=("8.8.8.8" "4.4.4.4")
export dnsSearch=("my.local")
export interface="eth0"

ipAddress="10.0.0.0"
netMark="255.255.255.0"

IFS=. read -r i1 i2 i3 i4 <<< "$ipAddress"
IFS=. read -r m1 m2 m3 m4 <<< "$netMark"

cidr=$(echo "obase=2; $(( (m1 << 24) + (m2 << 16) + (m3 << 8) + m4 ))" | bc | tr -d '\n' | sed 's/0*$//' | wc -c)

# added to /etc/netplan/01-netcfg.yaml
cat <<EOF | tee /tmp/01-netcfg.yaml
network:
  version: 2
  ethernets:
    $interface:
      dhcp4: false
      dhcp6: false
      addresses: [$ipAddress/$cidr]
      routes:
      - to: default
        via: $defaultGateway
      nameservers:
        search: [$(echo "${dnsSearch[@]}" | tr ' ' ',')]          
        addresses: [$(echo "${dnsServers[@]}" | tr ' ' ',')]
EOF
