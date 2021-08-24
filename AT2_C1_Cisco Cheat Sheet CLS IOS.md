Cisco Cheat Sheet CLS IOS

# BASIC CONFIGURATION COMMANDS

|Command|Purpose|Objectifs|
|:-----------:|:----------|:--------------|
|**enable**|Logs you into enable mode, which is also known as user exec mode or privileged mode|Vous connecte au mode d'activation, également appelé mode d'execution utilisateur ou mode privilégié|
|**configure terminal**|Logs you into configuration mode|Vous connecte au mode configuration|
|**interface** *FastEthernet/numéro*|Enters interface configuration mode for the specified fast ethernet interface|Entre en mode de configuration d'interface pour l'interface FastEthernet spécifié|
|**reload**|An exec mode command that reboots a Cisco switch or router| Une commande en mode exec qui redémarre un commutateur ou un routeur Cisco|
|**hostname**|Sets a host name to the current Cisco network device| Définit un nom d'hôte sur le périférique réseau Cisco actuel|
|**copy** *from-location to-location*|An enable mode command that copies files from one file location to another|Une commande de mode d'activation qui copie les fichiers d'un emplacement à un autre|
|**copy running-config startup-config**|An enable mode command that saves the active config, replacing the startup config when a Cisco network device initializes|Une commande de mode d'activation qui enregistre la configuration active, remplacant la configuration de démarrage lorsqu'un périphérique réseau Cisco s'initialise|
|**copy startup-config running-config**|An enable mode command that merges the startup config with the currently active config in RAM|Une commande de mode d'activation qui fusionne la configuration de démarrage avec la configuration actuellemen active dans la RAM|
|**write erase; erase startup-config**|An enable mode command that deletes the startup config|Une commande enable mode qui supprime la configuration au démarrage|
|**ip address**|Assigns an IP address and a subnet mask| Attribue une adresse IP et un netmask|
|**shutdown; no shutdown**|Used in interface configuration mode. “Shutdown” shuts down the interface, while “no shutdown” brings up the interface.| Utilisé en mode de configuration d'interface. "Shutdown" ferme l'interface, "No Shutdown" affiche l'interface|
|**ip default-gateway** *ip-address*|Sets the default gateway on a Cisco device|Définit la passerelle par défaut sur un appareil Cisco|
|**show running-config**|An enable mode command that displays the current configuration|Une commande enable mode qui affiche la configuration actuelle|
|**description** *name-string*|A config interface command to describe or name an interface|Une commande d'interface de configuration pour décrire ou nommer une interface|
|**show running-config interface**|An enable mode command to display the running configuration for a specific interface|Une commande enable mode pour afficher la configuration en cours pour une interface spécifique|
|**show ip interface**|	Displays the usability status of interfaces that are configured for IP|Affiche l'état d'utilisation des interfaces configurées pour IP|
|**ip name-server**|A configure mode command that sets the IP addresses of DNS servers|Une commande de mode de configuration qui définit les adresses IP des serveurs DNS|  

# TROUBLESHOOTING COMMANDS

|Command|Purpose|Objectif|  
|:-----------|:---------------|:--------|  
|**ping** *hostname / system-address [source source-address]*|Used in enable mode to diagnose basic network connectivity|Utilisé en mode activé pour diagnostiquer la connectivité réseau de base|  
|**speed** *10 / 100 / 1000 / auto*|An interface mode command that manually sets the speed to the specified value or negotiates it automatically|Une commande de mode d'interface qui définit manuellement la vitesse à la valeur spécifiée ou la négocie automatiquement|  
|**duplex** *auto / full / half*|An interface mode command that manually sets duplex to half, full or auto|	Une commande de mode d'interface qui définit manuellement le duplex à moitié, plein ou automatique|  
|**cdp run; no cdp run**|A configuration mode command that enables or disables Cisco Discovery Protocol (CDP) for the device|Une commande de mode de configuration qui active ou désactive le protocole de découverte Cisco (CDP) pour le périphérique|  
|**show mac address-table**|Displays the MAC address table|Affiche la table d'adresses MAC|  
|**show cdp**|Shows whether CDP is enabled globally|Indique si CDP est activé globalement|  
|**show cdp neighbors** *[detail]*|Lists summary information about each neighbor connected to this device; the *“detail”* option lists detailed information about each neighbor|Répertorie les informations récapitulatives sur chaque voisin connecté à cet appareil ; l'option "détail" répertorie des informations détaillées sur chaque voisin|  
|**show interfaces**|Displays detailed information about interface status, settings and counters|Affiche des informations détaillées sur l'état de l'interface, les paramètres et les compteurs|  
|**show interface status**|	Displays the interface line status|Affiche l'état de la ligne d'interface|  
|**show interfaces switchport**|Displays a large variety of configuration settings and current operational status, including VLAN trunking details.|Affiche une grande variété de paramètres de configuration et l'état de fonctionnement actuel, y compris les détails de jonction VLAN.|  
|**show interfaces trunk**|	Lists information about the currently operational trunks and the VLANs supported by those trunks|Répertorie les informations sur les trunks actuellement opérationnelles et les VLAN pris en charge par ces trunks|  
|**show vlan; show vlan brief**|Lists each VLAN and all interfaces assigned to that VLAN but does not include trunks|Répertorie chaque VLAN et toutes les interfaces attribuées à ce VLAN mais n'inclut pas les jonctions|  
|**show vtp status**|Lists the current VTP status, including the current mode|Répertorie l'état actuel du VTP, y compris le mode actuel|  

# ROUTING AND VLAN COMMANDS

|Command|Purpose|Objectif|
|:----|:------|:------|
|**ip route** *network-number network-mask (ip-address / interface)*|Sets a static route in the IP routing table|Définit une route statique dans la table de routage IP|
|**router rip**|Enables a Routing Information Protocol (RIP) routing process, which places you in router configuration mode|Active un processus de routage RIP (Routing Information Protocol), qui vous place en mode de configuration du routeur|
|**network ip-address**|In router configuration mode, associates a network with a RIP routing process|En mode configuration routeur, associe un réseau à un processus de routage RIP|  
|**version 2**|In router configuration mode, configures the software to receive and send only RIP version 2 packets|En mode de configuration du routeur, configure le logiciel pour recevoir et envoyer uniquement des paquets RIP version 2|  
|**no auto-summary**|In router configuration mode, disables automatic summarization|En mode de configuration du routeur, désactive la récapitulation automatique|  
|**default-information originate**|	In router configuration mode, generates a default route into RIP|En mode de configuration du routeur, génère une route par défaut dans RIP|  
|**passive-interface interface**|In router configuration mode, sets only that interface to passive RIP mode. In passive RIP mode, RIP routing updates are accepted by, but not sent out of, the specified interface.|  En mode de configuration du routeur, définit uniquement cette interface en mode RIP passif. En mode RIP passif, les mises à jour de routage RIP sont acceptées par l'interface spécifiée, mais pas envoyées depuis.|  
|**show ip rip database**|Displays the contents of the RIP routing database.|Affiche le contenu de la base de données de routage RIP|  
|**ip nat** *inside* | outside*|An interface configuration mode command to designate that traffic originating from or destined for the interface is subject to NAT|Une commande de mode de configuration d'interface pour désigner que le trafic provenant de ou destiné à l'interface est soumis à NAT|
|**ip nat inside source** *list{access-list-number / access-list-name} interface type number[overload]*|A configuration mode command to establish dynamic source translation. Use of the “list” keyword enables you to use an ACL to identify the traffic that will be subject to NAT. The “overload” option enables the router to use one global address for many local addresses.|Une commande de mode de configuration pour établir une traduction source dynamique. L'utilisation du mot-clé « list » vous permet d'utiliser une ACL pour identifier le trafic qui sera soumis au NAT. L'option « overload » permet au routeur d'utiliser une adresse globale pour plusieurs adresses locales.|  
|**ip nat inside source static** *local-ip global-ip*|A configuration mode command to establish a static translation between an inside local address and an inside global address|Une commande de mode de configuration pour établir une traduction statique entre une adresse locale interne et une adresse globale interne|
|**vlan**|Creates a VLAN and enters VLAN configuration mode for further definitions|Crée un VLAN et passe en mode de configuration VLAN pour d'autres définitions|  
|**switchport access vlan**|Sets the VLAN that the interface belongs to.|Définit le VLAN auquel appartient l'interface.|  
|**switchport trunk encapsulation dot1q**|Specifies 802.1Q encapsulation on the trunk link.|Spécifie l'encapsulation 802.1Q sur la liaison de jonction.|
|**switchport access**|Assigns this port to a VLAN|Attribue ce port à un Vlan|  
|**vlan vlan-id** *[name vlan-name]*|Configures a specific VLAN name (1 to 32 characters)|Configure un nom de VLAN spécifique (1 à 32 caractères)|
|**switchport mode** *{ access / trunk }*|Configures the VLAN membership mode of a port. The access port is set to access unconditionally and operates as a non-trunking, single VLAN interface that sends and receives non-encapsulated (non-tagged) frames. An access port can be assigned to only one VLAN. The trunk port sends and receives encapsulated (tagged) frames that identify the VLAN of origination. A trunk is a point-to-point link between two switches or between a switch and a router.|Configure le mode d'appartenance au VLAN d'un port. Le port d'accès est configuré pour accéder sans condition et fonctionne comme une interface VLAN unique sans agrégation qui envoie et reçoit des trames non encapsulées (non étiquetées). Un port d'accès ne peut être affecté qu'à un seul VLAN. Le port de jonction envoie et reçoit des trames encapsulées (marquées) qui identifient le VLAN d'origine. Une jonction est une liaison point à point entre deux commutateurs ou entre un commutateur et un routeur.|
|**switchport trunk** *{encapsulation { dot1q }*|Sets the trunk characteristics when the interface is in trunking mode. In this mode, the switch supports simultaneous tagged and untagged traffic on a port.|Définit les caractéristiques de jonction lorsque l'interface est en mode jonction. Dans ce mode, le commutateur prend en charge le trafic simultané balisé et non balisé sur un port.|  
|**encapsulation dot1q vlan-id**|A configuration mode command that defines the matching criteria to map 802.1Q frames ingress on an interface to the appropriate service instance|Une commande de mode de configuration qui définit les critères de correspondance pour mapper l'entrée de trames 802.1Q sur une interface à l'instance de service appropriée|  

# COMMANDES DHCP


|Command|Purpose|Objectif|
|:----|:------|:------|
|**ip address dhcp**|A configuration mode command to acquire an IP address on an interface via DHCP|Une commande en mode configuration pour acquérir une adresse IP sur une interface via DHCP|
|**ip dhcp pool name**|A configuration mode command to configure a DHCP address pool on a DHCP server and enter DHCP pool configuration mode|	Une commande de mode de configuration pour configurer un pool d'adresses DHCP sur un serveur DHCP et entrer en mode de configuration de pool DHCP|  
|**domain-name** *domain*|Used in DHCP pool configuration mode to specify the domain name for a DHCP client|	Utilisé en mode de configuration de pool DHCP pour spécifier le nom de domaine d'un client DHCP|  
|**network** *network-number [mask]*|Used in DHCP pool configuration mode to configure the network number and mask for a DHCP address pool primary or secondary subnet on a Cisco IOS DHCP server|Utilisé en mode de configuration de pool DHCP pour configurer le numéro de réseau et le masque pour un sous-réseau principal ou secondaire de pool d'adresses DHCP sur un serveur DHCP Cisco IOS|
|**ip dhcp excluded-address** *ip-address [last-ip-address]*|A configuration mode command to specify IP addresses that a DHCP server should not assign to DHCP clients|Une commande de mode de configuration pour spécifier les adresses IP qu'un serveur DHCP ne doit pas attribuer aux clients DHCP|
|**ip helper-address** *address*|An interface configuration mode command to enable forwarding of UDP broadcasts, including BOOTP, received on an interface|Une commande de mode de configuration d'interface pour activer le transfert des diffusions UDP, y compris BOOTP, reçues sur une interface|
|**default-router address** *[address2 ... address8]*|Used in DHCP pool configuration mode to specify the default router list for a DHCP client|Utilisé en mode de configuration de pool DHCP pour spécifier la liste de routeurs par défaut pour un client DHCP|

# SECURITY COMMANDS

|Command|Purpose|Objectif|
|:----|:------|:------|
|**password** *pass-value*|Lists the password that is required if the login command (with no other parameters) is conﬁgured|Répertorie le mot de passe requis si la commande login (sans autre paramètre) est configurée|
|**username name password pass-value**|A global command that deﬁnes one of possibly multiple user names and associated passwords used for user authentication. It is used when the login local line conﬁguration command has been used.|Une commande globale qui définit l'un des nombreux noms d'utilisateur et mots de passe associés utilisés pour l'authentification de l'utilisateur. Il est utilisé lorsque la commande de configuration de la ligne locale login a été utilisée.|
|**enable password pass-value**|A configuration mode command that deﬁnes the password required when using the enable command|Une commande de mode de configuration qui définit le mot de passe requis lors de l'utilisation de la   commande enable|
|**enable secretpass-value**|A configuration mode command that sets this Cisco device password that is required for any user to enter enable mode|Une commande de mode de configuration qui définit ce mot de passe de périphérique Cisco qui est requis pour tout utilisateur pour entrer en mode d'activation|
|**service password-encryption**|A configuration mode command that directs the Cisco IOS software to encrypt the passwords, CHAP secrets, and similar data saved in its configuration file|Une commande de mode de configuration qui demande au logiciel Cisco IOS de chiffrer les mots de passe, les secrets CHAP et les données similaires enregistrés dans son fichier de configuration|
|**ip domain-name** *name*|Conﬁgures a DNS domain name|	Configure un nom de domaine DNS|
|crypto key generate rsa|A configuration mode command that creates and stores (in a hidden location in ﬂash memory) the keys that are required by SSH|Une commande de mode de configuration qui crée et stocke (dans un emplacement caché dans la mémoire flash) les clés requises par SSH|  
|**transport input** *{telnet / ssh}*|Used in vty line conﬁguration mode, deﬁnes whether Telnet or SSH access is allowed into this switch. Both values can be specified in a single command to allow both Telnet and SSH access (default settings).|Utilisé en mode de configuration de ligne vty, définit si l'accès Telnet ou SSH est autorisé dans ce commutateur. Les deux valeurs peuvent être spécifiées dans une seule commande pour autoriser à la fois l'accès Telnet et SSH (paramètres par défaut).|  
|**access-list** *access-list-number *{deny / permit} source [source-wildcard] [log]*|A configuration mode command that defines a standard IP access list|Une commande de mode de configuration qui définit une liste d'accès IP standard|
|**access-class**|Restricts incoming and outgoing connections between a particular vty (into a basic Cisco device) and the addresses in an access list|Restreint les connexions entrantes et sortantes entre un vty particulier (dans un périphérique Cisco de base) et les adresses dans une liste d'accès|
|**ip access-list** *{standard / extended} {access-list-name / access-list-number}*|A configuration mode command that defines an IP access list by name or number|Une commande de mode de configuration qui définit une liste d'accès IP par nom ou numéro|  
|**permit source** *[source-wildcard]*|Used in ACL configuration mode to set conditions to allow a packet to pass a named IP ACL. To remove a permit condition from an ACL, use the “no” form of this command.|Utilisé en mode de configuration ACL pour définir des conditions permettant à un paquet de passer une ACL IP nommée. Pour supprimer une condition d'autorisation d'une liste de contrôle d'accès, utilisez la forme « non » de cette commande.|
|**deny source** *[source-wildcard]*|Used in ACL configuration mode to set conditions in a named IP ACL that will deny packets. To remove a deny condition from an ACL, use the “no” form of this command.|Utilisé en mode de configuration ACL pour définir des conditions dans une ACL IP nommée qui refusera les paquets. Pour supprimer une condition de refus d'une liste de contrôle d'accès, utilisez la forme « non » de cette commande.|
|**ntp peer** *<ip-address>*|Used in global configuration mode to configure the software clock to synchronize a peer or to be synchronized by a peer|Utilisé en mode de configuration globale pour configurer l'horloge logicielle pour synchroniser un pair ou pour être synchronisée par un pair|  
|**switchport port-security**|Used in interface configuration mode to enable port security on the interface|Utilisé en mode de configuration d'interface pour activer la sécurité des ports sur l'interface|
|**switchport port-security maximum maximum**|Used in interface configuration mode to set the maximum number of secure MAC addresses on the port|Utilisé en mode de configuration d'interface pour définir le nombre maximum d'adresses MAC sécurisées sur le port|  
|**switchport port-security mac-address** *{mac-addr / {sticky [mac-addr]}}*|Used in interface configuration mode to add a MAC address to the list of secure MAC addresses. The “sticky” option configures the MAC addresses as sticky on the interface.|Utilisé en mode de configuration d'interface pour ajouter une adresse MAC à la liste des adresses MAC sécurisées. L'option "sticky" configure les adresses MAC comme sticky sur l'interface.|
|**switchport port-security violation** *{shutdown / restrict / protect}*|	Used in interface configuration mode to set the action to be taken when a security violation is detected|Utilisé en mode de configuration d'interface pour définir l'action à entreprendre lorsqu'une violation de sécurité est détectée|  
|**show port security** *[interface interface-id]*|Displays information about security options configured on the interface|Affiche des informations sur les options de sécurité configurées sur l'interface|

# MONITORING AND LOGGING COMMANDS

|Command|Purpose|Objectif|
|:----|:------|:------|
|**logging** *ip address*|Configures the IP address of the host that will |receive the system logging (syslog) messages|Configure l'adresse IP de l'hôte qui recevra les messages de journalisation du système (syslog)|  
|**logging trap level**|Used in configuration mode to limit messages that are logged to the syslog servers based on severity. Specify the number or name of the desired severity level at which messages should be logged.|Utilisé en mode configuration pour limiter les messages consignés sur les serveurs syslog en fonction de leur gravité. Spécifiez le numéro ou le nom du niveau de gravité souhaité auquel les messages doivent être consignés.|  
|**show logging**|Enable mode command that displays the state of system logging (syslog) and the contents of the standard system logging buffer.|  
|**terminal monitor**|An enable mode command that tells Cisco IOS to send a copy of all syslog messages, including debug messages, to the Telnet or SSH user who issues this command|Une commande enable mode qui indique à Cisco IOS d'envoyer une copie de tous les messages syslog, y compris les messages de débogage, à l'utilisateur Telnet ou SSH qui émet cette commande|  

*source: [https://www.netwrix.com/cisco_commands_cheat_sheet.html](https://www.netwrix.com/cisco_commands_cheat_sheet.html)*