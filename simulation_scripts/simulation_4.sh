#!/bin/bash

# Network interface to target (commonly eth0 or ens33, check with 'ip a')
INTERFACE="eth0"

# Simulate network issue by dropping all incoming and outgoing packets
sudo iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
sudo iptables -A INPUT -i $INTERFACE -j DROP
sudo iptables -A OUTPUT -o $INTERFACE -j DROP

echo "Network packets are now being dropped on interface $INTERFACE."
echo "This simulates a network connectivity issue."
echo "Use 'sudo iptables -F' to clear the rules when done."
