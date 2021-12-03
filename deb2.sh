#!/bin/bash

##################
##################
##################
## Softs Debian ##
##################
##################
##################

echo "On commence par installer les softs essentiels :"

secs=$((1 * 10))
while [ $secs -gt 0 ]; do
   echo -ne "$secs\033[0K\r"
   sleep 1
   : $((secs--))

#####################
## Baseline Debian ##
#####################

apt update -y && apt upgrade -y

# Gestionnaires de paquets, de dépendances & de versions
echo -e "OS tools :"
apt install -y -f --quiet aptitude composer debconf debconf-utils dpkg git ivy rpm snapd yum4

# Outils langage de programmation
echo -e "Prog tools :"
apt install -y -f --quiet perl python3 python3-pip

# Utilitaires système
echo -e "OS utilitaries :"
apt install -y -f --quiet apparmor debarchiver file reprepro screen sudo tar ttf-* tzdata unzip vim wget zip

# Outils réseaux
echo -e "Network tools :"
apt install -y -f --quiet asp bwm-ng doscan dnsutils dsniff etherwake ethstats ethstatus fping hunt ifmetric ifstat iftop netdiag net-tools nmap tcpdump traceroute winbind

# Outils http
echo -e "http tools :"
apt install -y -f --quiet curl lynx

# Outils sécurité (proxy, ssl, fw)
echo -e "Security tools :"
apt install -y -f --quiet e2guardian fail2ban gnupg2 iptables openssl squid ssh ufw
snap install -y -f core
snap install -y -f --classic certbot
ln -s /snap/bin/certbot /usr/bin/certbot

# Outils transfert de fichiers
echo -e "FTPS tools :"
apt install -y -f --quiet samba vsftpd

# Librairies de dépendances
echo -e "Librairies :"
cd /root
apt install -y -f libnet-ssleay-perl libauthen-pam-perl libio-pty-perl libodbc1 libopenipmi0 libssh-4

# On lance un petit refresh et on corrige s'il y a des erreurs
apt update -f && apt upgrade -f
apt --fix-broken install

#####################
## Outils serveurs ##
#####################

# Outils Web Serveur (lamps)
echo -e "LAMPS tools :"
apt install -y -f --quiet apache2 libapache2-mod-php mariadb-client mariadb-server php php-{apcu,bcmath,bz2,cas,cli,curl,dev,gd,imagick,intl,json,ldap,mysql,mbstring,memcache,snmp,soap,sqlite3,ssh2,tcpdf,twig,xml,zip} phpmyadmin rrdtool snmp snmpd
cd /root
wget https://prdownloads.sourceforge.net/webadmin/webmin_1.982_all.deb
dpkg -i webmin_1.982_all.deb
apt update
apt install -y -f --quiet webmin
rm -f webmin_1.982_all.deb

# Outils serveurs DNS 
echo -e "DNS tools :"
apt install -y -f --quiet bind9

# Outils serveurs DHCP
echo -e "DNS tools :"
apt install -y -f --quiet isc-dhcp-client #isc-dhcp-server

# Outils configuration de serveurs esclaves
echo -e "Puppet :"
cd /root
wget https://apt.puppet.com/puppet7-release-focal.deb
dpkg -i puppet7-release-focal.deb
apt update
apt install -y -f --quiet puppet
rm -f puppet7-release-focal.deb

#######################
## Outils monitoring ##
#######################

# Cacti
echo -e "Cacti install :"
cd /root
wget -P /root https://files.cacti.net/cacti/linux/cacti-1.2.19.tar.gz
tar -xzvf cacti-1.2.19.tar.gz
tar xvf cacti-1.2.19.tar
cp -r /root/cacti-1.2.19 /etc
cd /root
rm -f cacti-1.2.19.tar.gz
rm -f cacti-1.2.19.tar
rm -rf /root/cacti-1.2.19

# Zabbix
echo -e "Zabbix install :"
cd /root
wget https://repo.zabbix.com/zabbix/5.4/debian/pool/main/z/zabbix-release/zabbix-release_5.4-1+debian11_all.deb
dpkg -i zabbix-release_5.4-1+debian11_all.deb
apt update
apt install -y -f --quiet zabbix-server-mysql zabbix-frontend-php zabbix-apache-conf zabbix-sql-scripts zabbix-agent
apt --fix-broken install
rm -f zabbix-release_5.4-1+debian11_all.deb

################
## Containers ##
################

# Docker
# echo -e "Docker install :"
# cd /root
# apt install -y -f --quiet libslirp0 slirp4netns
# wget https://download.docker.com/linux/debian/dists/bullseye/pool/stable/amd64/containerd.io_1.4.12-1_amd64.deb
# wget https://download.docker.com/linux/debian/dists/bullseye/pool/stable/amd64/docker-ce-cli_20.10.11~3-0~debian-bullseye_amd64.deb
# wget https://download.docker.com/linux/debian/dists/bullseye/pool/stable/amd64/docker-ce-rootless-extras_20.10.11~3-0~debian-bullseye_amd64.deb
# wget https://download.docker.com/linux/debian/dists/bullseye/pool/stable/amd64/docker-ce_20.10.11~3-0~debian-bullseye_amd64.deb
# wget https://download.docker.com/linux/debian/dists/bullseye/pool/stable/amd64/docker-scan-plugin_0.9.0~debian-bullseye_amd64.deb
# dpkg -i containerd.io_1.4.12-1_amd64.deb
# dpkg -i docker-ce-cli_20.10.11~3-0~debian-bullseye_amd64.deb
# dpkg -i docker-ce-rootless-extras_20.10.11~3-0~debian-bullseye_amd64.deb
# dpkg -i docker-ce_20.10.11~3-0~debian-bullseye_amd64.deb
# dpkg -i docker-scan-plugin_0.9.0~debian-bullseye_amd64.deb
# apt update
# apt install -y -f --quiet containerd.io docker-ce docker-ce-cli docker-ce-rootless-extras docker-scan-plugin dbus-user-session slirp4netns
# apt --fix-broken -y install
# sudo docker run hello-world
# cd /root
# rm -f containerd.io_1.4.12-1_amd64.deb
# rm -f docker-ce-cli_20.10.11~3-0~debian-bullseye_amd64.deb
# rm -f docker-ce-rootless-extras_20.10.11~3-0~debian-bullseye_amd64.deb
# rm -f docker-ce_20.10.11~3-0~debian-bullseye_amd64.deb
# rm -f docker-scan-plugin_0.9.0~debian-bullseye_amd64.deb

####################
####################
####################
## Configurations ##
####################
####################
####################

echo "Minatenant un peu de configuration :"

secs=$((1 * 10))
while [ $secs -gt 0 ]; do
   echo -ne "$secs\033[0K\r"
   sleep 1
   : $((secs--))

# FTP & FTPS
echo "On commence par le FTPS :"
cd /etc
openssl req -x509 -nodes -days 365 -newkey rsa:4096 -out /etc/vsftpd_cert.pem -keyout /etc/vsftpd_key.pem
mv vsftpd.conf vsftpd.conf.bak
wget https://github.com/RaspCric/In-girum-imus-nocte-et-consumimur-igni/raw/lamps/vsftpd.conf.new
mv vsftpd.conf.new vsftpd.conf
service vsftpd restart

cd /etc/samba/
mv smb.conf smb.conf.bak
wget https://github.com/RaspCric/In-girum-imus-nocte-et-consumimur-igni/raw/lamps/samba.conf.new
mv samba.conf.new smb.conf
service nmbd restart
service smbd restart

# Apache2
echo "Puis une config de base pour Apache2 en attendant let's encrypt :"
cd /etc/apache2/sites-available
systemctl enable apache2
a2enmod ssl rewrite headers
a2ensite default-ssl
openssl req $@ -new -x509 -days 3560 -nodes -out /etc/apache2/apache2.pem -keyout /etc/apache2/apache2.pem
touch /etc/apache2/sites-available/backup.conf
cat /etc/apache2/sites-available/000-default.conf > backup.conf
cat /etc/apache2/sites-available/default-ssl.conf >> backup.conf
a2dissite 000-default.conf defaul-ssl.conf
rm -f /etc/apache2/sites-available/000-default.conf
rm -f /etc/apache2/sites-available/default-ssl.conf
wget htps://github.com/RaspCric/In-girum-imus-nocte-et-consumimur-igni/raw/lamps/apache2.conf
a2ensite apache2.conf
wget https://github.com/RaspCric/In-girum-imus-nocte-et-consumimur-igni/raw/lamps/bookstack.conf
wget https://github.com/RaspCric/In-girum-imus-nocte-et-consumimur-igni/raw/lamps/wordpress.conf
wget https://github.com/RaspCric/In-girum-imus-nocte-et-consumimur-igni/raw/lamps/mediawiki.conf
wget https://github.com/RaspCric/In-girum-imus-nocte-et-consumimur-igni/raw/lamps/nextcloud.conf
systemctl restart apache2

# FW: iptables
cd /root
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
iptables -t filter -A INPUT -p udp -m udp --dport 445 -j ACCEPT

iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -t filter -A INPUT -i lo -j ACCEPT
iptables -t filter -A INPUT -j DROP

iptables-save > /etc/fw.conf

echo "pre-up iptables-restore </etc/fw.conf" >> /etc/network/interfaces

##############
## Finition ##
##############

## On clot
apt update -y && apt upgrade -y
