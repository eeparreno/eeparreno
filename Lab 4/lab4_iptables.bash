#!/bin/bash


#logging and rejecting rules in LOGGING chain
sudo iptables -I LOGGING 1 -p tcp --dport 22 -m limit --limit 2/min -j LOG --log-prefix 'SSH access attempts: '
sudo iptables -I LOGGING 2 -p tcp --dport 22 -j REJECT --reject-with icmp-port-unreachable
sudo iptables -I LOGGING 3 -m limit --limit 2/min -j LOG --log-prefix 'Access attempts from any protocol: '
sudo iptables -I LOGGING 4 -j REJECT --reject-with icmp-port-unreachable
#Allowing DNS Queries from any network device
sudo iptables -A INPUT -s 192.168.24.0/24 -p udp --dport 53 -j ACCEPT
sudo iptables -A INPUT -s 172.16.0.0/16 -p udp --dport 53 -j ACCEPT

#Allowing ping from any network device 
sudo iptables -A INPUT -s 192.168.24.0/24 -p icmp --icmp-type echo-request -j ACCEPT 
sudo iptables -A INPUT -s 172.16.0.0/16 -p icmp --icmp-type echo-request -j ACCEPT

#SSH on any network device 
sudo iptables -A INPUT -s 192.168.24.0/24 -p tcp --dport 22 -m state --state NEW,ESTABLISHED -j ACCEPT
sudo iptables -A INPUT -s 172.16.0.1 -p tcp --dport 22 -m state --state NEW,ESTABLISHED -j ACCEPT

#INPUT chain logging
sudo iptables -A INPUT -p tcp --dport 22 -j LOGGING
sudo iptables -A INPUT -j LOGGING

