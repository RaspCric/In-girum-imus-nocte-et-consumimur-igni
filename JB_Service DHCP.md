# Service DHCP

## Questionnaire

**1. Que signifie l’acronyme DHCP ?**  
   Dynamic Host Configuration Protocol

**2. De quel protocole vient il ?**  
    Il vient du protocole BootP, BootSrap.  
    [Page wiki](https://en.wikipedia.org/wiki/Bootstrap_(front-end_framework))  
    
**3. Quelle RFC définit en premier ce protocole ?**  
    La [RFC 1531](https://datatracker.ietf.org/doc/html/rfc1531)
    La [RFC 2131](https://datatracker.ietf.org/doc/html/rfc2131)

**4. A quel numéro de port est il lié ?**  
    Port 67 coté serveur
    Port 68 coté client

**5. Est ce qu’il travaille en TCP ou en UDP ?**    
    Il travaille en UDP  

**6. Qu’est ce qu’un LEASE ?**  
    C'est un bail  

**7. Combien y a t il de secondes dans une heure, une journée, une semaine ?**  
    Une heure = 60 * 60 = 3600s  
    Une journée = 24 * 3600 = 86400s  
    Une semaine = 7 * 86400 = 604800s  

**8. Qu’est ce qu’un bail statique?**  
    Le bail statique, c'est la même adresse attribuée à chaque fois au même périphérique suivant l'identification par l'adresse mac de celui-ci.  

**9.  Qu’est ce que du multipool?**  
    *Pool = Etendu*  
    C'est quand le serveur DHCP gère plusieurs espace d'adressage.  

**10. Qu’est ce qu’une whitelist en MAC filtering?**   
    C'est la liste des adresses mac autorisés, lors d'un filtrage par adresse mac.  

**11. Le DHCP traverse t il les routeurs?**  
    Non, il ne peut pas traverser un router (fonctionne par broadcast), sauf exception.

**12. Qu’est ce qu’un DHCP relay?**   
    Le relais DHCP est une caractéristique qui est utilisée par un commutateur, également connu sous le nom d'agent de relais, pour permettre la transmission DHCP entre les hôtes et les serveurs DHCP distants qui ne sont pas sur le même réseau.  

**13. Quels sont les trois modes d’allocations d’une adresse?**   
    *- Allocation dynamique :* Un administrateur réseau réserve une plage d'adresses IP pour DHCP, et chaque client DHCP sur le réseau local est configuré pour demander une adresse IP au serveur DHCP lors de l'initialisation du réseau. Le processus de demande et d'octroi utilise un concept de bail avec une période de temps contrôlable, permettant au serveur DHCP de récupérer puis de réaffecter les adresses IP qui ne sont pas renouvelées.  
    *- Attribution automatique :* Le serveur DHCP attribue en permanence une adresse IP à un client demandeur à partir d'une plage définie par un administrateur. C'est comme l'allocation dynamique, mais le serveur DHCP conserve une table des attributions d'adresses IP passées, de sorte qu'il puisse attribuer de préférence à un client la même adresse IP que le client avait précédemment.  
    *- Attribution manuelle :* Cette méthode est également appelée allocation DHCP statique , allocation d'adresse fixe , réservation et liaison d'adresse MAC/IP . Un administrateur mappe un identifiant unique (un identifiant client ou une adresse MAC ) pour chaque client à une adresse IP, qui est proposée au client demandeur. Les serveurs DHCP peuvent être configurés pour recourir à d'autres méthodes en cas d'échec.  

**14.   DHCP supporte t il IPv6?**  
    Oui il supporte l'IPv6 via le DHCPV6  

**15.  Quel est la première information poussée par le serveur ? La seconde ? La troisième ? La quatrième ?**   
    D'abord, il pousse l'adresse IP. Ensuite, le Netmask. Après, la Gateway. Enfin, le serveur DNS. Après il peut pousser plein d'options, le serveur de temps est une options très importantes, [ici](https://www.pool.ntp.org/zone/fr)  
    *{Les opérations DHCP se divisent en quatre phases : découverte du serveur, offre de bail IP, demande de bail IP et accusé de réception du bail IP. Ces étapes sont souvent abrégées en DORA pour Discovery, Offer, Request et Acknowledge.}*  
![](https://upload.wikimedia.org/wikipedia/commons/thumb/e/e4/DHCP_session.svg/390px-DHCP_session.svg.png)

**16. Donner quelques options poussées par le serveur ?**  
    Options disponibles via [RFC 2132](https://datatracker.ietf.org/doc/html/rfc2132) ou [IANA](https://www.iana.org/assignments/bootp-dhcp-parameters/bootp-dhcp-parameters.xhtml)  
|Tag|Name| DataLength |Meaning |Reference |
|:-:|:-:|:-:|:-:|:-:|
|0	|Pad	|0	|None	|[RFC2132]
|1	|Subnet Mask	|4	|Subnet Mask Value	|[RFC2132]
|2	|Time Offset	|4	|Time Offset in Seconds from UTC (note: deprecated by 100 and 101)	|[RFC2132]
|3	|Router	|N	|N/4 Router addresses	|[RFC2132]
|4	|Time Server	|N	|N/4 Timeserver addresses	|[RFC2132]
|5	|Name Server	|N	|N/4 IEN-116 Server addresses	|[RFC2132]
|6	|Domain Server	|N	|N/4 DNS Server addresses	|[RFC2132]
|7	|Log Server	|N	|N/4 Logging Server addresses	|[RFC2132]
|8	|Quotes Server	|N	|N/4 Quotes Server addresses	|[RFC2132]
|9	|LPR Server	|N	|N/4 Printer Server addresses	|[RFC2132]
|10	|Impress Server	|N	|N/4 Impress Server addresses	|[RFC2132]
    Option sur ce [site](http://www.networksorcery.com/enp/protocol/bootp/options.htm).  

**17. Qu’est ce qu’un SCOPE ?**  
    Scope = Portée (distance hein, pas pour les chiens n'est ce pas John)  
    Un [scope](https://documentation.solarwinds.com/en/success_center/ipam/content/ipam-create-dhcp-scopes.htm) est une plage d'adresses IP qu'un serveur DHCP peut assigner aux clients d'un sous-réseau.  
    Un [superscope](https://docs.microsoft.com/en-us/openspecs/windows_protocols/ms-dhcpm/4b3dafe4-70e5-4085-969e-4bb402d9c68b) est une plage d'adresses IP qui couvre plusieurs sous-réseaux. Le serveur DHCP peut assigner ces adresses aux clients qui sont sur plusieurs sous-réseaux.  

**18. Quand est t il intéressant d’avoir des baux courts ?**  
    Quand le réseau est ouvert au public, par exemple Macdonalds. Q
    Avec beaucoup de turn-over.

**19. Qu’est ce que l’adresse 255.255.255.255 en lien avec le DHCP ?**  
    C'est l'adresse de diffusion du DHCP.  

**20. Décrivez le processus d’attribution d’une adresse DHCP ?**  
    [Attribution IPv4 via DHCP](https://cisco.goffinet.org/ccna/services-infrastructure/attribution-adresses-dhcp-ipv4/)

![*](https://d33wubrfki0l68.cloudfront.net/efe59db8cd65ed72164b31e5b60ec487612a09e9/941fa/assets/images/ccna/dhcp-1.gif)  

**21. Capturer des paquets DHCP à l’aide d’un outil de capture, effectuer une analyse.**   
    Lancer Wireshark avec analyse de la connection WiFi
    Dans l'invite de commande faire `ipconfig/release` pour liberer le bail DHCP
    Et ensuite faire `ipconfig/renew` pour recuperer ton bail.  
    Et dans Wireshark, on peut voir le **DORA**.  
![](Screen/wireshark.png)  

**22. Qu’est ce que l’ISC ?**  
    ISC = Internet Systems Consortium
    Un consortium public à but non lucratif dont le but est d'aider à la mise en œuvre d'un « Internet universel auto-organisé ». Il s'agit d'une structure indépendante, les développeurs y participant créent et maintiennent notamment des logiciels comme une distribution DHCP (serveur et client), BIND (serveur DNS) ou encore d'InterNetNews (INN).  

**23. Quel produit est développé par cet organisme en lien avec ce protocole ?**  
    DHCP server program : [ISC DHCP](https://en.wikipedia.org/wiki/DHCPD) ou [KEA](https://en.wikipedia.org/wiki/Kea_(software))
    Un slideshare pour KEA [ici](https://fr.slideshare.net/MenandMice/kea-dhcp-the-new-open-source-dhcp-server-from-isc)  

**24. Trouvez un tutorial en ligne sur l’installation du produit**  
    [Manuel pour l'installation de KEA](https://kea.readthedocs.io/en/latest/)  
    [Manuel pour l'installation de DHCPD](http://oob.freeshell.org/nzwireless/dhcpd.html)  
    [DHCP Debian](https://wiki.debian.org/fr/DHCP_Server)  

**25.  Qu’est ce qu’une rogue DHCP ?**  
    [Lien Wikipedia](https://en.wikipedia.org/wiki/Rogue_DHCP)
    Il s'agit d'un serveur DHCP malveillant en tant que serveur DHCP sur un réseau qui n'est pas sous le contrôle administratif du personnel du réseau. Il s'agit d'un périphérique réseau, tel qu'un modem ou un routeur, connecté au réseau par un utilisateur qui n'est pas conscient des conséquences de ses actions ou qui l'utilise sciemment pour des attaques réseau telles que les attaques de type "man in the middle". Certains types de virus informatiques ou de logiciels malveillants ont été découverts pour mettre en place un DHCP malveillant, notamment pour ceux classés dans la catégorie.  
  
**26.  Qu’est ce que le 802.1x ?**  
    [Lien Wikipedia](https://fr.wikipedia.org/wiki/IEEE_802.1X)
    [802.1X](https://www.ieee802.org/1/pages/802.1x.html) est un standard lié à la sécurité des réseaux informatiques, mis au point en 2001 par l'IEEE (famille de la norme IEEE 802).
    Il permet de contrôler l'accès aux équipements d'infrastructures réseau (et par ce biais, de relayer les informations liées aux dispositifs d'identification).
    802.1x est synonyme de Radius.  

**27.  Le DHCP est il conseillé dans des infrastructures type TPE ?**  
    Oui, il l'est !!! ***N'est ce pas Romain !!!!***

**28.  Le DHCP est il conseillé dans des grosses infrastructures ?**  
    Oui, il l'est.

**32. Expliquez ZEROCONF?**  
    [Lien Wikipedia](https://fr.wikipedia.org/wiki/Zeroconf)
    [Lien Ubuntu](https://doc.ubuntu-fr.org/zeroconf)
    ZeroConf est une collection d'outils et de protocoles servant à l'autoconfiguration des réseaux. Cette technologie est appelée Bonjour (ou encore RendezVous) par Apple et est utilisée intensivement par Mac OS X. 

**33. Donnez la plage d’adressage de l’APIPA**  
    [Lien Wikipedia](https://fr.wikipedia.org/wiki/Automatic_Private_Internet_Protocol_Addressing)
    [It-Connect](https://www.it-connect.fr/adresse-apipa-169-154-quest-ce-que-cest/)
    Il arrive parfois sur les machines clientes attendant une configuration DHCP  que l'on se retrouve après un délai d'attente avec une adresse de type 169.254.X.X. Ces adresses nous font souvent dire qu'il y a un problème au niveau de l'attribution des adresses IP mais on n'en sait rarement plus à leur sujet.

**34. Expliquer le DHCP snooping ?**  
    [Ressource Ionos](https://www.ionos.fr/digitalguide/serveur/securite/dhcp-snooping/)
    [Ressource FormIP](https://formip.com/dhcp-snooping/)
    [FS Community](https://community.fs.com/fr/blog/what-is-dhcp-snooping-and-how-it-works.html)
    [Ressource autre](https://le-guide-du-sysops.fr/index.php/2020/06/01/le-dhcp-snooping-pour-contrer-les-attaques-dhcp-spoofing/)
    Le DHCP Snooping est une technique permettant d’empêcher de connecter un serveur DHCP indésirable sur un réseau. Celle-ci s’implémente exclusivement sur des switchs. Le principe consiste à filtrer les requêtes DHCP de type « DHCP OFFER » non autorisées. Pour cela, tous les ports du switch doivent filtrer les requêtes DHCP à l’exception du port correspondant à celui du serveur DHCP légitime du réseau.
    [Ressources Thomas](https://istacee.wordpress.com/2010/03/08/dhcp-snooping-defense-contre-le-dhcp-spoofing/)  
![](https://lh6.googleusercontent.com/bYaowEVF3YuR9W1jKuEVK7f2uxvNVaXM87KsqDFZlJnb5-Y5Tz1jfhz-7HLIrSCgdw-F42awvRBt2ppS0yoKBgqs6EAcCmhmv1zS5h1kZbFMAGwlv4CT3QD5KcqTMoYA9fuivJI1)

**RESSOURCES:**  
- [Microsoft - L'adresse source](https://docs.microsoft.com/fr-fr/windows-server/troubleshoot/dynamic-host-configuration-protocol-basics#:~:text=L'adresse%20source%20est%20l,r%C3%A9seau%20dans%20le%20client%20demandeur.)  
- [FrameIp - DHCP](https://www.frameip.com/dhcp/#:~:text=DHCP%20signifie%20Dynamic%20Host%20Configuration,'administration%20d'un%20r%C3%A9seau.)  
- [IONOS - DHCP](https://www.ionos.fr/digitalguide/serveur/configuration/dhcp-le-protocole-reseau-client-serveur/)


## Exo Packet Tracer  

- Mettre en place les PC, Switch et Routeur.
- Cabler toutes les devices, allumer les ports si besoin et attendre que tout passe vert.  
- Ajouter les différentes adresses IP.  
- Créer les routes dans les routeurs.  
- Ajouter un serveur DHCP.
- Paramêtrer le serveur DHCP.
- Ajouter dans les routeurs le parêmetre faire en faire des relay.

[Sources](https://www.it-connect.fr/mise-en-place-dun-agent-relais-dhcp/)

![](image)