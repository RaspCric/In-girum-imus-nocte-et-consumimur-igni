#!/bin/sh

# On créé les règles
:INPUT ACCEPT [0:0]
:FORWARD ACCEPT [0:0]
:OUTPUT ACCEPT [0:0]

iptables -t filter -F
iptables -t filter -X

iptables -t filter -X
iptables -t filter -P FORWARD DROP
iptables -t filter -P OUTPUT DROP

iptables -t filter -A INPUT -p icmp -j ACCEPT
iptables -t filter -A INPUT -p tcp -m tcp --dport 21 -j ACCEPT
iptables -t filter -A INPUT -p tcp -m tcp --dport 22 -j ACCEPT
iptables -t filter -A INPUT -p tcp -m tcp --dport 80 -j ACCEPT
iptables -t filter -A INPUT -p tcp -m tcp --dport 443 -j ACCEPT
iptables -t filter -A INPUT -p tcp -m tcp --dport 10000 -j ACCEPT
iptables -t filter -A INPUT -p tcp -m tcp --dport 990 -j ACCEPT
iptables -t filter -A INPUT -p tcp -m tcp --dport 137 -j ACCEPT
iptables -t filter -A INPUT -p tcp -m tcp --dport 139 -j ACCEPT
iptables -t filter -A INPUT -p tcp -m tcp --dport 445 -j ACCEPT
iptables -t filter -A INPUT -p tcp -m tcp --dport 65000:65500 -j ACCEPT

iptables -t filter -A INPUT -p udp -m udp --dport 137 -j ACCEPT
iptables -t filter -A INPUT -p udp -m udp --dport 138 -j ACCEPT
iptables -t filter-A INPUT -p udp -m udp --dport 445 -j ACCEPT

iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -t filter -A INPUT -i lo -j ACCEPT
iptables -t filter -A INPUT -j DROP

# On les ajoute de manière récurente
iptables-save > /etc/fw.conf
cat "pre-up iptables-restore </etc/fw.conf" > /etc/network/interfaces