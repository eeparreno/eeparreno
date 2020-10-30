#!/bin/bash

sudo iptables -N LOGGING 

sudo iptables -A INPUT -j DROP
sudo iptables -A INPUT -j REJECT

#TCP rules from lab 3:
sudo iptables -A INPUT -p tcp --dport 80 -j ACCEPT 
sudo iptables -A LOGGING -m limit --limit 2/min -j LOG --log-prefix 'vm2-web: '

#logging and rejecting rules in LOGGING chain
sudo iptables -I LOGGING 1 -p tcp --dport 22 -m limit --limit 2/min -j LOG --log-prefix 'SSH access attempts: '
sudo iptables -I LOGGING 3 -m limit --limit 2/min -j LOG --log-prefix 'Access attempts from any protocol: '

#Allowing DNS Queries from any network device
sudo iptables -A INPUT -s 192.168.0.0/16 -p udp --dport 53 -j ACCEPT
sudo iptables -A INPUT -s 172.16.0.1 -p udp --dport 53 -j ACCEPT

#Allowing ping from any network device 
sudo iptables -A INPUT -s 192.168.0.0/16 -p icmp --icmp-type echo-request -j ACCEPT 
sudo iptables -A INPUT -s 172.16.0.1 -p icmp --icmp-type echo-request -j ACCEPT

#SSH on any network device 
sudo iptables -A INPUT -s 192.168.24.1 -p tcp --dport 22 -m state --state NEW,ESTABLISHED -j ACCEPT
sudo iptables -A INPUT -s 172.16.0.1 -p tcp --dport 22 -m state --state NEW,ESTABLISHED -j ACCEPT

#INPUT chain logging (w/h lab3 rules)
sudo iptables -A INPUT -p tcp --dport 80 -j LOGGING
sudo iptables -A INPUT -p tcp --dport 22 -j LOGGING
sudo iptables -A INPUT -j LOGGING

