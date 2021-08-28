
![cefim](https://metiersculture.fr/wp-content/uploads/2016/04/logo-cefim-tours.jpg)<br/>
*Cours 2021-2022, à l'aide des informations du cours et de JB*

---

# **ADMINISTATION RESEAU**

---

**Semaine 1**
1. DNS
2. DHCP
3. Web : HTTP + HTTPs
4. FTP + FTPs

**Semaine 2**
1. AD
2. WServer

<u>Deux protocoles essentiels</u> : [**BGP**](https://fr.wikipedia.org/wiki/Border_Gateway_Protocol) (protocole de routage, interco de routers) + **DNS** (protocole sur lequel se base tous les autres services)

---

# Table des matières

1. [Protocole DNS](#1)
    1. [Introduction](#2)
        1. [Domain Name System (ou DNS, système de noms de domaine)](#3)
        2. [Principe du DNS](#4)
        3. [Serveurs DNS racine](#5)
        4. [Qualified Domain Name](#6)
        5. [Hiérarchie du DNS](#7)
        6. [Résolution du nom par un hôte](#8)
        7. [Résolution Inverse](#9)
        8. [Les différents types d'enregistrements du DNS](#10)
        9. [Quelques Considérations Opérationnelles sur le DNS](#11)
        10. [Sécurité du DNS](#12)
    2. [Le DNS par Stéphane Bortzmeyer](#13)
    3. [Questionnaire](#14)
    4. [Exercices](#15)
        1. [Windows Server 2019](#16)
        2. [Debian9 et Bind](#17)
        3. [Packet Tracer et DNS](#18)

2. [Protocole DHCP](#19)
    1. [Introduction](#20)
        1. [Questionnaire](#21)
    2. [Exerices](#22)
        1. [Packet Tracer](#23)
        2. [Mise en Oeuvre sous Linux Debian](#24)

---

![logo1](https://kayamaga.com/wp-content/uploads/2019/07/DNS.jpg)

## Protocole DNS <a name="1"></a>

- Protocole le plus important pour TSSR
- Logiciel : [**BIND_9**](https://doc.ubuntu-fr.org/bind9) (sezvice DNS le plus utilisé)
- Logiciels bis : dig, nslookup...
- tout équipement connecté sur le web a besoin d'un nom qualifié (y compris routers)
- Au niveau DNS que l'on fait du meilleur filtrage
- Couche 7 OSI
- Fonctionne via [UNICODE](https://fr.wikipedia.org/wiki/Unicode)

Le Système de Nom de Domaine est un système distribué, hiérarchisé, robuste et pouvant être sécurisé qui à fait ses preuves.
Il constitue maintenant l'épine dorsale d'internet et des réseaux.
Beaucoup de services réseaux repose sur ce système et ne peuvent fonctionner sans le DNS (Serveur Mail, Serveur Ldap...)
Il facilite aussi beaucoup la vie des internautes qui préfère retenir www.google.fr 209.85.229.147, ils ne pourrait plus s'en passer. Les utilisateurs préfère d'ailleurs les noms en toute lettres au chiffre. Tout le monde fait sont propre "« DNS »" avec ses contact dans son téléphone portable.

### **Ressources web**

- [Neptunet : DNS](https://neptunet.fr/category/systeme/roles-et-services/dns/)
- [Neptunet : mise en pratique](https://neptunet.fr/dns-cache-windows/)
- [FrameIP](https://www.frameip.com/dns/)
- [Cisco](https://cisco.goffinet.org/ccna/services-infrastructure/protocole-resolution-noms-dns/)
- [Wikipedia](https://fr.wikipedia.org/wiki/Domain_Name_System)
- [OpenClassroom DNS](https://openclassrooms.com/fr/courses/857447-apprenez-le-fonctionnement-des-reseaux-tcp-ip/857163-le-service-dns)
- [Dernière RFC de 2019](https://datatracker.ietf.org/doc/html/rfc8499)
- [It-connect](https://www.it-connect.fr/chapitres/dns-presentation-et-definitions/)
- [Cloudflare](https://www.cloudflare.com/fr-fr/learning/dns/what-is-dns/)

### **Ressources téléchargeables**

- [le fonctionnement du système DNS](https://cefimeu-my.sharepoint.com/:b:/g/personal/rdelmas_cefim_eu/ETfpnqjKSFdPvgPneWauhKYB3Uek0j-GCvmD4y4A39Urkw?e=tpb0bF)
- [Cours du CNAM](https://cefimeu-my.sharepoint.com/:b:/g/personal/rdelmas_cefim_eu/EWU-5P6Y069AoIY2zi18doQB8drMMJPGtTAekMqglq2TSg?e=nmakUJ)
- [Cours univ](https://cefimeu-my.sharepoint.com/:b:/g/personal/rdelmas_cefim_eu/EU8AbCYkvShBqMKMwKgokSsB0CwIj6WYKhvDT99KXTXOPQ?e=i8Vjbb)

---

### **Introduction** <a name="2"></a>

- Avant : juste fichier Host
- Ensuite : DNS

Avant le DNS, la résolution d'un nom sur Internet devait se faire grâce à un fichier texte appelé HOSTS.TXT ([RFC 608](https://datatracker.ietf.org/doc/html/rfc608)) maintenu par le NIC du Stanford Research Institute (SRI) et recopié sur chaque ordinateur par transfert de fichier.  

En 1982, ce système centralisé montre ses limites et plusieurs propositions de remplacement voient le jour, parmi lesquelles le système distribué Grapevine de Xerox et IEN 116.   

Le premier est jugé trop compliqué tandis que le second est insuffisant.   

La tâche de développer un autre système revient à [Paul Mockapetris](https://fr.wikipedia.org/wiki/Paul_Mockapetris) qui publie le design du système dans les [RFC 882](https://datatracker.ietf.org/doc/html/rfc882) et [RFC 883](https://datatracker.ietf.org/doc/html/rfc883) en 1983. La norme correspondante est publiée dans les [RFC 1034](https://datatracker.ietf.org/doc/html/rfc1034) et [RFC 1035](https://datatracker.ietf.org/doc/html/rfc1035) en 1987. En 1987, le fichier HOSTS.TXT contenait 5500 entrées, tandis que 20000 hôtes étaient définis dans le DNS.  


#### **Domain Name System (ou DNS, système de noms de domaine)** <a name="3"></a>

C'est un service permettant d'établir une **correspondance** entre une adresse IP et un nom de domaine et, plus généralement, de trouver une information à partir d'un nom de domaine. C'est un **système hiérarchisé**, il part d'un Domaine générale qui se divise en sous domaine.

> protocole DNS avant de se connecter au web <br/>
> système de correspondance entre humains et machines (binaires)<br/>
> avant on utilisait des *hostnames* mais problème avec la multiplication des hôtes<br/>
> www.google.fr.(=root, fin de l'arbre)<br/>

#### **Principe du DNS** <a name="4"></a>

Les ordinateurs connectés à un réseau IP, comme Internet, possèdent une adresse IP. Ces adresses sont numériques afin d'être plus facilement traitées par une machine. En IPv4, elles sont représentées sous la forme xxx.xxx.xxx.xxx, où xxx est un nombre variant entre 0 et 255 (en système décimal). En IPv6, les IP sont de la forme xxxx:xxxx:xxxx:xxxx:xxxx:xxxx:xxxx:xxxx, où x représente un caractère au format hexadécimal. Pour faciliter l'accès aux systèmes qui disposent de ces adresses, un mécanisme a été mis en place pour permettre **d'associer un nom à une adresse IP**, plus simple à retenir, appelé nom de domaine. Résoudre un nom de domaine consiste à trouver l'adresse IP qui lui est associée.

![schema](https://www.nameshield.com/wp-content/uploads/2020/03/DNS.png)

Les noms de domaines peuvent être également associés à d'autres informations que des adresses IP.

#### **Serveurs DNS racine** <a name="5"></a>

Il existe **13 serveurs racine**, nommés de ***A à M*** *.root-servers.net*. Ces serveurs sont gérés par douze organisations différentes : deux sont européennes, une japonaise et les neuf autres sont américaines. 10 de ces serveurs sont en réalité distribués dans le monde grâce à la technique anycast et 12 disposent d'une adresse IPv6. Grâce à anycast, plus de 900 serveurs répartis dans 50 pays du monde assurent ce service. Le serveur k reçoit par exemple de l'ordre de 20 000 requêtes par seconde.

Le DNS ne fournit pas de mécanisme pour découvrir la liste des serveurs racine, chacun des serveurs doit donc connaître cette liste au démarrage grâce à un encodage explicite. Cette liste est ensuite mise à jour en consultant l'un des serveurs indiqués. La mise à jour de cette liste est peu fréquente de façon à ce que les serveurs anciens continuent à fonctionner.

![root-servers](https://thehackernews.com/images/-Y_AY6xG9D3o/T3YI0b-vEeI/AAAAAAAAFdE/pF3lGt7qbVw/s640/DNS+root+servers.gif)


> Site qui recense tous les servers racines : https://root-servers.org/ <br/>
> Stats dispos (ex) : ipv4 > ipv6 + udp > tcp <br/>
> [IANA](https://www.iana.org/) -> [ICANN](https://www.icann.org/fr) (gère les noms de domaines (nom, .com, .fr...) et adresses IP (5 regional registar : RIPE, WIDE...)) <br/>

|IANA|->|ICANN|
|:-:|:-:|:-:|
|IP| |Nom|
|IPV4 / IPV6| |.fr / .com|
|5 régional Register| | ccTLD / gTLD |
|RIPE / WIDE| |**C**ountry **C**ode / **G**eneric | 


#### **Fully Qualified Domain Name (FQDN)** <a name="6"></a>

On entend par Fully qualified domain name (FQDN), ou Nom de domaine pleinement qualifié un **nom de domaine écrit de façon absolue**, y compris tous les domaines jusqu'au domaine de premier niveau (TLD), il est ponctué par un point final, par exemple *fr.wikipedia.org.*

La norme prévoit qu'un élément d'un nom de domaine (appelé label) ne peut dépasser 63 caractères, un FQDN ne pouvant dépasser 253 caractères.

> point (.), nom de domaine de 1er niveau (=TLD, org), nom de domaine de second niveau (wikipedia), nom de domaine de troisième niveau (fr)... <br/>

![schema](https://www.cloudflare.com/img/learning/dns/glossary/dns-root-server/dns-root-server.png)

> "www" = on cherche à joindre via le WorldWildWeb la machine... (on ne pointe que des machines/ressources, pas de servers) <br/>
> [TLD](https://fr.wikipedia.org/wiki/Domaine_de_premier_niveau) = [CCTLD](https://en.wikipedia.org/wiki/Country_code_top-level_domain) (*.fr*, country code) + [gTLD](https://en.wikipedia.org/wiki/Generic_top-level_domain) (nnom de domaine generic) <br/>
> jeux de noms de domaine : [domain hac](https://en.wikipedia.org/wiki/Domain_hack) <br/>

![TLD](https://audytorium.xyz/wp-content/uploads/2019/01/domeny.jpg)
- Liste des TLD disponible sur [Wikipedia](https://en.wikipedia.org/wiki/List_of_Internet_top-level_domains)


#### **Hiérarchie du DNS** <a name="7"></a>

Le système des noms de domaines consiste en une hiérarchie dont le sommet est appelé la racine. On représente cette dernière par un point. Dans un domaine, on peut créer un ou plusieurs sous-domaines ainsi qu'une délégation pour ceux-ci, c'est-à-dire une indication que les informations relatives à ce sous-domaine sont enregistrées sur un autre serveur. Ces sous-domaines peuvent à leur tour déléguer des sous-domaines vers d'autres serveurs.

![schema](https://upload.wikimedia.org/wikipedia/commons/thumb/9/91/Dns-raum.svg/400px-Dns-raum.svg.png)

Tous les sous-domaines ne sont pas nécessairement délégués. Les délégations créent des zones, c'est-à-dire des ensembles de domaines et leurs sous-domaines non délégués qui sont configurés sur un serveur déterminé. Les zones sont souvent confondues avec les domaines.

Les domaines se trouvant immédiatement sous la racine sont appelés domaine de premier niveau (TLD : Top Level Domain). Les noms de domaines ne correspondant pas à une extension de pays sont appelés des domaines génériques (gTLD), par exemple .org ou .com. S'ils correspondent à des codes de pays (fr, be, ch...), on les appelle ccTLD (country code TLD).

On représente un nom de domaine en indiquant les domaines successifs séparés par un point, les noms de domaines supérieurs se trouvant à droite. Par exemple, le domaine org. est un TLD, sous-domaine de la racine. Le domaine wikipedia.org. est un sous-domaine de .org.. Cette délégation est accomplie en indiquant la liste des serveur DNS associée au sous-domaine dans le domaine de niveau supérieur.

**Les noms de domaines sont donc résolus en parcourant la hiérarchie depuis le sommet et en suivant les délégations successives**, c'est-à-dire en parcourant le nom de domaine de droite à gauche.

Pour qu'il fonctionne normalement, un nom de domaine doit avoir fait l'objet d'une délégation correcte dans le domaine de niveau supérieur.

> ```tracert``` (permet de voir tous les sauts) <br/>
> Le gouvernement des USA gère sur la racine "." en 1998 <br/>
> ICAAN délégué par les USA pour la gestion quotidienne de la racine <br/>

#### **Résolution du nom par un hôte** <a name="8"></a>

Les hôtes n'ont qu'une connaissance limitée du système des noms de domaine. Quand ils doivent résoudre un nom, ils s'adressent à un ou plusieurs serveurs de noms dits récursifs, c'est-à-dire qui vont parcourir la hiérarchie DNS et faire suivre la requête à un ou plusieurs autres serveurs de noms pour fournir une réponse. Les adresses IP de ces serveurs récursifs sont souvent obtenues via DHCP ou encore configurés en dur sur la machine hôte. Les fournisseurs d'accès à Internet mettent à disposition de leurs clients ces serveurs récursifs. Il existe également des serveurs récursifs ouverts comme ceux de Google Public DNS ou OpenDNS et encore plus récemment Quad9 ou One.

Quand un serveur DNS récursif doit trouver l'adresse IP de fr.wikipedia.org, un processus itératif démarre pour consulter la hiérarchie DNS. Ce serveur demande aux serveurs DNS appelés serveurs racine quels serveurs peuvent lui répondre pour la zone org. Parmi ceux-ci, le serveur va en choisir un pour savoir quels serveurs sont capables de lui répondre pour la zone wikipedia.org. C'est un de ces derniers qui pourra lui donner l'adresse IP de fr.wikipedia.org. S'il se trouve qu'un serveur ne répond pas, un autre serveur de la liste sera consulté.

Pour optimiser les requêtes ultérieures, les serveurs DNS récursifs font aussi office de DNS cache : ils gardent en mémoire (cache) la réponse d'une résolution de nom afin de ne pas effectuer ce processus à nouveau ultérieurement. Cette information est conservée pendant une période nommée Time to live et associée à chaque nom de domaine.

Un nom de domaine peut utiliser plusieurs serveurs DNS. Généralement, les noms de domaines en utilisent au moins deux : un primaire et un secondaire. Il peut y avoir plusieurs serveurs secondaires.

L'ensemble des serveurs primaires et secondaires font autorité pour un domaine, c'est-à-dire que la réponse ne fait pas appel à un autre serveur ou à un cache. Les serveurs récursifs fournissent des réponses qui ne sont pas nécessairement à jour, à cause du cache mis en place. On parle alors de réponse ne faisant pas autorité (non-authoritative answer).

Cette architecture garantit au réseau Internet une certaine continuité dans la résolution des noms. Quand un serveur DNS tombe en panne, le bon fonctionnement de la résolution de nom n'est pas remis en cause dans la mesure où des serveurs secondaires sont disponibles.

![schema](https://d33wubrfki0l68.cloudfront.net/350a2c406907f37c5f12cfda3095b82cc150a30c/a2a00/assets/images/ccna/external/1126px-dns_iterations.svg.png)

> ```nslookup``` ([recherche d'infos dans le DNS](https://fr.wikipedia.org/wiki/Nslookup)) <br/>
> ```ipconfig/flushdns``` (vider le cache)<br/>
> ```ipconfig/displaydns``` (visualiser le cache)<br/>

> [**nslookup**](https://docs.microsoft.com/fr-fr/windows-server/administration/windows-commands/nslookup) sur Windows, [**dig**](https://fr.wikipedia.org/wiki/Dig_(programme_informatique)) sur Linux


#### Résolution Inverse <a name="9"></a>

![schema](https://images.ctfassets.net/plii0v5gbc4s/1Y1Z04UYBC4OIVcUYb2MIl/52f06f2598e7e7024a2a21957b12390a/reverse-dns-example.png)

Pour trouver le nom de domaine associé à une adresse IP, on utilise un principe semblable. Dans un nom de domaine, la partie la plus générale est à droite : org dans fr.wikipedia.org, le mécanisme de résolution parcourt donc le nom de domaine de droite à gauche. Dans une adresse IP, c'est le contraire : 213 est la partie la plus générale de 213.228.0.42. Pour conserver une logique cohérente, on inverse l'ordre des quatre termes de l'adresse et on la concatène au pseudo domaine in-addr.arpa. Ainsi, par exemple, pour trouver le nom de domaine de l'adresse IP 91.198.174.2, on résout 2.174.198.91.in-addr.arpa.

La déclaration inverse est importante sur les adresses IP publiques Internet puisque l'absence d'une résolution inverse est considéré comme une erreur opérationnelle (RFC 1912) qui peut entrainer le refus d'accès à un service. Par exemple, un serveur de messagerie électronique se présentant en envoi avec une adresse IP n'ayant pas de résolution inverse (PTR) a de grandes chances de se voir refuser, par l'hôte distant, la transmission du courrier (message de refus de type : IP lookup failed).

Une adresse IP peut être associée à plusieurs différents noms de domaine via l'enregistrement de plusieurs entrées PTR dans le sous-domaine .arpa dédié à cette adresse (in-addr.arpa. pour IPv4 et ip6.arpa. pour IPv6). L'utilisation d'enregistrements PTR multiples pour une même adresse IP est éventuellement présente dans le cadre de l'hébergement virtuel de multiples domaines web derrière la même adresse IP mais n'est pas recommandé dans la mesure où le nombre des champs PTR à renvoyer peut faire dépasser à la réponse la taille des paquets UDP de réponse et entraîner l'utilisation du protocole TCP (plus coûteux en ressources) pour envoyer la réponse à la requête DNS.

#### Les différents types d'enregistrements du DNS <a name="10"></a>

<u>Ressources web</u> :
- [Permet de visualiser toutes les infos DNS](http://dns-record-viewer.online-domain-tools.com/)
- [Tous les types d'enregistrements](https://www.google.com/search?q=dns+record+listing&oq=dns+record+list&aqs=chrome.2.69i57j0l5.5093j0j9&sourceid=chrome&ie=UTF-8)
- gandi.net > voir les fichiers de zone (totosandbox) : DNS, Types

![schema](https://docs.fedoraproject.org/en-US/Fedora/18/html/FreeIPA_Guide/images/dns-zone-record-list.png)

Les principaux enregistrements définis sont les suivants (via **nslookup**) :

**A record ou address record**

Cet enregistrement fait correspondre un nom d'hôte à une adresse IPv4 de 32 bits distribués sur quatre octets.

*Par exemple : hote.domaine.fr => 123.234.1.2*

**AAAA record ou IPv6 address record**

Cet enregistrement fait correspondre un nom d'hôte à une adresse IPv6 de 128 bits distribués sur seize octets.

*Par exemple : hote.domaine.fr => 2001:0db8:0000:85a3:0000:0000:ac1f:8001*

**CNAME record ou canonical name record**

Cet enregistrement permet de faire d'un domaine un alias vers un autre. Cet alias hérite de tous les sous-domaines de l'original.

Un enregistrement CNAME peut pointer vers un autre enregistrement CNAME mais cette méthode est déconseillée car elle double le nombre de requêtes au serveur DNS.

*Par exemple : www.domaine.fr => hote.domaine.fr*

**MX record ou mail exchange record**

Cet enregistrement défini les serveurs de courriel pour ce domaine. Un enregistrement MX ne peux pointer que vers un enregistrement A, et non un alias CNAME.

Par exemple si on défini le MX record de domain.fr comme étant l'adresse 123.234.1.3, les mails envoyés à @domaine.fr seront aiguillé vers cette même adresse.
PTR record ou pointer record

Cet enregistrement associe une adresse IP à un enregistrement de nom de domaine, aussi dit « reverse » puisque il fait exactement le contraire du A ou du AAA record. Il est indispensable à de nombreux services, qu'a chaque A ou AAA record corresponde sont PTR record.

*Par exemple : 123.234.1.2 => hote.domaine.fr*
> ```set type=mx``` (via *nslookup*)

**NS record ou name server record**

Cet enregistrement défini les serveurs DNS de ce domaine (les servers qui vont gérer la zone). Un enregistrement NS ne peux pointer que vers un enregistrement A, et non un alias CNAME.

Il peut y avoir plusieurs enregistrements NS si il existe plusieurs serveurs de messagerie sur le domaine.

*Par exemple, si on défini 123.234.1.1 comme NS record de domaine.fr, il sera alors un des serveurs consulté pour tout les sous domaine de .domain.fr comme par exemple hote.domaine.fr*

**SOA record ou Start Of Authority record**

Cet enregistrement donne les informations générales de la zone : serveur principal, courriel de contact, différentes durées dont celle d'expiration, numéro de série de la zone.

**Remarque:**

Il existe encore beaucoup d'autre type d'enregistrement (NAPTR, LOC, TXT, ).

Un enregistrement ne contient pas forcément une référence à une machine. par exemple un enregistrement TXT une chaîne de caractère (souvent utiliser pour précisé des paramètres de la zone DNS) ou encore l'enregistrement LOC qui peut contenir la localisation géographique d'une machine ou d'une zone DNS (latitude, longitude).


#### Quelques Considérations Opérationnelles sur le DNS <a name="11"></a>

- Protocole de base sous-jacent à tous les services
- Existance de server primaire et de server secondaire (mode slave)

**Mise à jour et cohérence du DNS**

Les mises à jour se font sur le serveur primaire du domaine, les serveurs secondaires recopiant les informations du serveur primaire dans un mécanisme appelé transfert de zone. Pour déterminer si un transfert de zone doit avoir lieu, le serveur secondaire consulte le numéro de version de la zone et le compare à la version qu'il possède. Le serveur primaire détermine à quelle fréquence le numéro de version est consulté. Quand un changement est effectué, les serveurs envoient des messages de notification aux serveurs secondaires pour accélérer le processus (transfert de zone entre deux servers ce sont de petits fichiers).

Il se peut que des informations qui ne sont plus à jour soient cependant conservées dans des serveurs cache. Il faut alors attendre l'expiration de leur *Time to live* pour que ces informations cachées disparaissent et donc que la mise à jour soit pleinement effective. On peut minimiser le temps nécessaire en diminuant le TTL associé aux noms de domaines qui vont être modifiées préalablement à une opération de changement.

Quand la liste des serveurs de noms change, ou quand une adresse IP est modifiée, le gestionnaire du domaine de niveau supérieur doit effectuer la mise à jour correspondante.

**Robustesse du DNS**

Pour éviter les points individuels de défaillance ([SPOF](https://fr.wikipedia.org/wiki/Point_de_d%C3%A9faillance_unique)), on évite de partager l'infrastructure entre les serveurs qui font autorité. Un serveur secondaire sera de préférence délocalisé et routé différemment que le serveur primaire.

Bien que cela soit techniquement possible, on évite de mêler sur un même serveur le rôle de DNS récursif et celui de serveur qui fait autorité.

De même, un hôte sera configuré avec plusieurs serveurs récursifs, de sorte que si le premier ne répond pas à la requête, le suivant sera employé. En général, les serveurs récursifs fournis par les FAI refusent les requêtes émanant d'adresses IP appartenant à d'autres FAI.

Il existe des services de DNS récursifs ouverts, c'est-à-dire qu'ils acceptent les requêtes de tous les clients. Il est donc possible à un utilisateur de configurer ceux-ci en lieu et place de ceux fournis par le FAI. Ceci pose cependant les problèmes suivants :

1. il n'y a pas de garantie que les réponses fournies seront les mêmes qu'avec des serveurs récursifs habituels. Un tel service pourrait en effet faire référence à une autre hiérarchie depuis la racine, disposer de TLD additionnels non standard, restreindre l'accès à certains domaines, voire altérer certains records avant leur transmission au client.

2. il n'y a pas de garantie de confidentialité, c'est-à-dire que ce service pourrait déterminer à quels domaines un utilisateur à accès en conservant des traces des requêtes DNS.

### **Sécurité du DNS** <a name="12"></a>


Le protocole DNS a été conçu avec un souci minimum de la sécurité. Plusieurs failles de sécurité du protocole DNS ont été identifiées depuis. Les principales failles du DNS ont été décrites dans le [RFC 3833](https://datatracker.ietf.org/doc/html/rfc3833) publié en août 2004. 

En voici quelques exemples :

#### **Interception des paquets**

Une des failles mises en avant est la possibilité d'intercepter les paquets transmis. Les serveurs DNS communiquent au moyen de paquets uniques et non signés. Ces deux spécificités rendent l'interception très aisée. L'interception peut se concrétiser de différentes manières, notamment via une attaque de type « man in the middle », de l'écoute des données transférées et de l'envoi de réponse falsifiée (voir paragraphe ci-dessous).

<u>Ressources web</u> :
- [Ionos](https://www.ionos.fr/digitalguide/serveur/securite/quest-ce-que-le-dns-hijacking/)

#### **Fabrication d'une réponse**

Les paquets des serveurs DNS étant faiblement sécurisés, authentifiés par un numéro de requête, il est possible de fabriquer de faux paquets. Par exemple, un utilisateur qui souhaite accéder au site http://mabanque.example.com fait une demande au site DNS. Il suffit à ce qu'un pirate informatique réponde à la requête de l'utilisateur avant le serveur DNS pour que l'utilisateur se retrouve sur un site de phishing.

#### **Corruption des données**

La trahison par un serveur, ou corruption de données, est, techniquement, identique à une interception des paquets. La seule différence venant du fait que l'utilisateur envoie volontairement sa requête au serveur. Cette situation peut arriver lorsque, par exemple, l'opérateur du serveur DNS souhaite mettre en avant un partenaire commercial.

#### **Empoisonnement du cache DNS**

![schema](https://www.imperva.com/learn/wp-content/uploads/sites/13/2019/01/DNS-spoofing.jpg)

L'empoisonnement du cache DNS ou pollution de cache DNS (DNS cache poisoning ou DNS cache pollution en anglais) est une technique permettant de leurrer les serveurs DNS afin de leur faire croire qu'ils reçoivent une requête valide tandis qu'elle est frauduleuse. Une fois que le serveur DNS a été empoisonné, l'information est mise dans un cache, rendant ainsi vulnérable tous les utilisateurs de ce serveur. Ce type d'attaque permet, par exemple, d'envoyer un utilisateur vers un faux site dont le contenu peut servir à de l'hameçonnage (dans le cas du DNS, on parle de pharming) ou comme vecteur de virus et autres applications malveillantes.

Un ordinateur présent sur Internet utilise normalement un serveur DNS géré par le fournisseur d'accès. Ce serveur DNS est la plupart du temps limité aux seuls utilisateurs du réseau du fournisseur d'accès et son cache contient une partie des informations rapatriées par le passé. Une attaque par empoisonnement sur un seul serveur DNS du fournisseur d'accès peut affecter l'ensemble de ses utilisateurs, soit directement ou indirectement si des serveurs esclaves s'occupent de propager l'information.

<u>Ressources Web :</u>
- [DNS poisoning par Okta](https://www.okta.com/identity-101/dns-poisoning/)
- [Page wikipedia](https://fr.wikipedia.org/wiki/Empoisonnement_du_cache_DNS)

#### **Déni de Service : DDOS**

![schema](https://exploitszone.com/wp-content/uploads/2020/06/ddos-attack.png)

Une attaque par déni de service (ou attaque par saturation ; en anglais, Denial of Service attack ou DoS attack) est une attaque sur un serveur informatique consistant envoyer une grande quantité de requête à celui-ci pour le saturer. Une fois saturé il ne peut plus fournir de service aux clients réguliers..

<u>Ressources Web</u> :
- [Page Wikipedia](https://fr.wikipedia.org/wiki/Attaque_par_d%C3%A9ni_de_service)
- [Securiteinfo](https://www.securiteinfo.com/attaques/hacking/ddos.shtml)
- [Cisco](https://www.cisco.com/c/fr_fr/products/security/what-is-a-ddos-attack.html)
- [Zdnet](https://www.zdnet.fr/pratique/qu-est-ce-qu-une-attaque-ddos-tout-savoir-pour-les-reconna-tre-et-s-en-proteger-39911475.htm)
- [Ionos](https://www.ionos.fr/digitalguide/serveur/know-how/quest-ce-que-le-dos-denial-of-service/)

#### **Fondamental : DNSSEC**

![schema](https://www.efficientip.com/wp-content/uploads/2020/01/chain-of-trust-part1.svg)

- DNSSEC permet de sécuriser les données envoyées par le DNS. Contrairement à d'autres protocoles comme SSL, il ne sécurise pas juste un canal de communication mais il protège les données, les enregistrements DNS, de bout en bout. Ainsi, il est efficace même lorsqu'un serveur intermédiaire trahit.

- DNSSEC signe cryptographiquement les enregistrements DNS et met cette signature dans le DNS. Ainsi, un client DNS méfiant peut récupérer la signature et, s'il possède la clé du serveur, vérifier que les données sont correctes. La clé peut être récupérée via le DNS lui-même (ce qui pose un problème d'œuf et de poule) ou bien par un autre moyen (diffusée via le Web et signée avec PGP par exemple).

- DNSSEC permet de déléguer des signatures : ainsi, le registre d'un domaine de premier niveau peut annoncer que tel sous-domaine est signé. On peut ainsi bâtir une chaîne de confiance depuis la racine du DNS.

- DNSSEC introduit aussi ses propres problèmes, par exemple, le fait qu'un enregistrement spécial (NSEC) indique le prochain domaine de la zone permet d'énumérer le contenu complet d'une zone signée, même si le transfert de zone n'est pas permis. Ce problème fait que la plupart des TLD utilisent l'enregistrement NSEC3, qui n'a pas ce défaut.

<u>Ressources Web</u> :
- [ICANN](https://www.icann.org/resources/pages/dnssec-what-is-it-why-important-2019-03-20-fr)

### **DNS par Stéphane Bortzmeyer** <a name="13"></a>

- Server DNS le plus répendu : [BIND](https://fr.wikipedia.org/wiki/BIND) (peut faire server faisant autorité *OU* résolveur)
- Autre logiciel DNS pour server faisant autorité : [NSD](https://fr.wikipedia.org/wiki/Name_Server_Daemon) (plus rapide que Bind, nombre de codes 20 fois plus petit, une seule faille historique)
- Emacs (éditeur de fichier comme nano sur Linux)
- Le server résolver interroge par hasard les servers faisant autorité (Bind), et utilise le plus rapide (même s'il lui arrive de changer pour éviter le poisonning)

#### **Le protocole en Video par S.Bortzmeyer** 

Stéphane Bortzmeyer est informaticien à l’Association française pour le nommage Internet en coopération (Afnic). Il s'occupe entre autres de sécurité, notamment du DNS. Il est membre de Gitoyen[réf. nécessaire] et du conseil d'administration du France-IX, le principal point d'échange Internet français. Membre actif de l'IETF, il est l'auteur de plusieurs RFC, notamment liés aux questions de DNS et de vie privée. 

||**Cours magitral**|**Questions techniques**|
|:-:|:-:|:-:|
|**Conférence**|[![Cours magitral](https://raw.githubusercontent.com/RaspCric/In-girum-imus-nocte-et-consumimur-igni/images/DNS_stephane.jpg)](https://www.youtube.com/watch?v=QHVK666TFUI)|[![Partie Technique](https://raw.githubusercontent.com/RaspCric/In-girum-imus-nocte-et-consumimur-igni/images/bind.jpg)](https://www.youtube.com/watch?v=KFHZL6bxsUo)|

**DNS** <br/>
= infrastructure<br/>
= base de données décentralisée<br/>
= associe données à noms de domaine (noms uniques/mémorisables/vecteur identité/arborescent) + résoudre noms en données<br/>
= rien sur l'internet ne marche sans le DNS <br/>

**Deux types de server DNS** :
- *Server faisant autorité* = server dns qui connait le contenu d'un domaine (server afnic qui connaissent ce qu'il y a dans .fr)
- *Résolveur ou server récusif* = server dns qui ne connait rien mais pose des questions aux servers faisant autorité et mémorise les réponses (FAI, Réseau local)

**Risques**
- Risque lié à l'enregistrement (détournement, saisie, justice...)
- Risque technique de panne (**résilience** : continuer à fonctionner ; ex. il existe une 150aine de servers physiques pour le .fr)
- Risque par attaque par empoisonnement (déploiement DNSSEC)<br/>
-> il s'agit de répondre avant le vrai server auprès du résolveur qui va mémoriser la réponse<br/>
-> utiliser le chiffrement par clef/signature pour empêcher l'empoisonnement

**Organisations et pouvoirs : les processus mous et les différents acteurs**

- Gouvernement des USA (possède la racine)
- ICANN (gère la racine pour le gouvernement des USA)
- Registres de TLD (Verisign, AFNIC...) et BE
- Opérateurs de résolveurs (résolveurs menteurs de certains FAI qui bloquent certains contenus...)
- Auteurs de logiciels (permission DNSSEC ou pas...)

**Alternatives**

- identificateurs fondés sur le contenu comme magnets (châine de caractères qui donne les infos sur le contenu, l'endroit... = privilégie le contenu et non le server) de BitTorrent
- identificateurs fondés sur la cryptographie comme ceux de BitMessage (les adresses sont des clefs crypotagraphiques = suite de chiffres)

#### Ressources web

- [Son blog](https://www.bortzmeyer.org/)
- [Article : dns-over-https](https://www.nextinpact.com/article/30142/108783-dns-over-https-pour-stephane-bortzmeyer-diable-est-dans-details)

|**Sécurité DNS**|
|:-:|
[![Cours magitral](https://raw.githubusercontent.com/RaspCric/In-girum-imus-nocte-et-consumimur-igni/images/S%C3%A9cu_bors.jpg)](https://www.youtube.com/watch?v=wg45iVWuEKE)

---

---

### **Questionnaire** <a name="14"></a>

- [Questionnaire](https://docs.google.com/document/d/1ZSy_dOYGScy3gDfcS09Zbo3ArixWlrfoNBL3iTwZEBM/edit)

> ```ipconfig/displaydns>rapport.txt``` (pour récupérer les infos dans un fichier texte)

#### **Les 30 questions à répondre**


1. **Créer et remplir un tableau de 14 lignes et de 6 colonnes (Lettre Root, Nom entité, description entité, IPv4, IPv6, nb d'instance) . Ce tableau sera très utile pour window server et Bind9**

![*](https://raw.githubusercontent.com/RaspCric/In-girum-imus-nocte-et-consumimur-igni/images/infos_server_racines.jpg)

|Lettre Root|Nom entité|Description entité|    IPV4|    IPV6|    Nb d'instance|
|:-:|:-:|:-:|:-:|:-:|:-:|
|A|    Verisign, Inc|    Entreprise privée, USA 1998|    198.41.0.4|    2001:503:ba3e::2:30|    16|
|B|    Information Science Institute|    Département Université de Caroline du Sud, USA, 1977|    199.09.14.201|    2001:500:200::b|    6|
|C|    Cogent Communications|    Multinationale, USA, 1999|    192.33.4.12|    2001:500:2::c|    12|
|D|    University of Maryland|    Université du Maryland, USA|    199.7.91.13| 2001:500:2d::d|    162|
|E|    NASA Ames Research Center|     Agence gouvernementale (NASA), USA|    192.203.230.10|    2001:500:a8::e|    254|
|F|    Internet Systems Consortium, Inc|    Société à but non lucratif, USA, 1994|    192.5.5.241|    2001:500:2f::f|    249|
|G|    Defense Information Systems Agency|    Agence gouvernementale (Defense), USA, 1991|    192.112.36.4|    2001:500:12::d0d|    6|
|H| U.S. Army Research Lab|    Agence gouvernementale (US Army), USA, 1992|    198.97.190.53|    2001:500:1::53|    8|
|I|    Netnod|    Société à but non lucratif, Suède, 1996|    192.36.148.17|    2001:7fe::53|    68|
|J|    Versign, Inc|    Entreprise privée, USA 1998|    192.58.128.30|    2001:503:c27::2:30|    118|
|K|    RIPE NCC|    Organistaion privée de droit néerlandais, Pyas-Bas, 1992|    193.0.14.129|    2001:7fd::1|    75|
|L|    ICANN|    Société de droit californien à but non lucratif, USA, 1998|    199.7.83.42|    2001:500:9f::42|    191|
|M|    WIDE Project|    Projet de l'université de Kéio, Japon, 1985|    202.12.27.33|    2001:dc3::35|    6|

2. **Capturer une requête DNS dans Wireshark entre votre client et un serveur OPENDNS, montrer dans la capture la réponse du serveur UDP à votre requête sur www.republiquedesmangues.fr**

- Wiresark
- Lancer capture avec la bonne borne réseau
- Filtre : DNS
- Lancer une recherche via la barre du navigateur sur ledit site

![*](https://raw.githubusercontent.com/RaspCric/In-girum-imus-nocte-et-consumimur-igni/images/rep_mangues_wireshark.jpg)

3. **Capturer une requête DNS dans Wireshark en TCP**

![*](https://raw.githubusercontent.com/RaspCric/In-girum-imus-nocte-et-consumimur-igni/images/dns_tcp.jpg)

- [Using TCP with Lookup](https://www.sourcedaddy.com/windows-7/using-tcp-for-dns-lookups.html#:~:text=Using%20TCP%20for%20DNS%20Lookups%20When%20a%20DNS,deliver%20all%20the%20DNS%20records%20in%20the%20response)


4. **Vider votre cache et Capturer votre cache DNS dans un fichier Texte, le traffic Google pour faire une recherche Linkedin, vous identifier dedans et isoler dans ce fichier seulement les FQDN.**

- ipconfig/flushdns
- [ipconfig/displaydns>cache.txt](https://cefimeu-my.sharepoint.com/:t:/g/personal/rdelmas_cefim_eu/Ed5mDROc5OxHrhfgJzFlk0cBSImrthZOw5MAzM6V_Sesgg?e=cRQkBb)
- Google / Linkedin / Connexion
- [ipconfig/displaydns>cache2.txt](https://cefimeu-my.sharepoint.com/:t:/g/personal/rdelmas_cefim_eu/EeVBwxPybylAggiUMfitfaQB-yB7P_fEewaES2viN_c8BA?e=ZtXci2)
- FQDN = nom de domaine qui donne la position exacte de son nœud dans l'arborescence DNS
- [ipconfig/displaydns>cache3.txt](https://cefimeu-my.sharepoint.com/:t:/g/personal/rdelmas_cefim_eu/EeVBwxPybylAggiUMfitfaQB-yB7P_fEewaES2viN_c8BA?e=ZtXci2)


5. **Faire un DIG (donc sur Linux) simple en A sur le nom de domaine du site https://hooooooooo.com/**

- [Ressource Web](https://www.hostinger.fr/tutoriels/comment-utiliser-la-commande-dig-sous-linux)
- ``` dig hooooooooo.com/ +short```

![*](https://raw.githubusercontent.com/RaspCric/In-girum-imus-nocte-et-consumimur-igni/images/digA.jpg)
![*](https://raw.githubusercontent.com/RaspCric/In-girum-imus-nocte-et-consumimur-igni/images/dig_short.jpg)

6. **Faire un DIG plus complet sur Elysee.fr**

![*](https://raw.githubusercontent.com/RaspCric/In-girum-imus-nocte-et-consumimur-igni/images/dig_noall.jpg)

7. **Quel est le nom FQDN du cluster d'hébergement de objectif2038.net?**

![*](https://raw.githubusercontent.com/RaspCric/In-girum-imus-nocte-et-consumimur-igni/images/nslookup_reverse.jpg)

8. **Quel est le CNAME de www.objectif2038.net ?**

![*](https://raw.githubusercontent.com/RaspCric/In-girum-imus-nocte-et-consumimur-igni/images/cname.jpg)

9. **Quel est le nom du serveur prioritaire MX pour le domaine ID37.fr (Dans un MX le serveur prioritaire est il 1 ou 99?)**

![*](https://raw.githubusercontent.com/RaspCric/In-girum-imus-nocte-et-consumimur-igni/images/server_mx.jpg)

- Il s'agt du n°1

10. **Quelle est la clé MS dans le record TXT pour le passage à Office365 du domaine cefim.ninja ?**

- [Ressource Web](https://docs.microsoft.com/fr-fr/microsoft-365/admin/get-help-with-domains/create-dns-records-at-any-dns-hosting-provider?view=o365-worldwide)

![*](https://raw.githubusercontent.com/RaspCric/In-girum-imus-nocte-et-consumimur-igni/images/clef_mx.jpg)

11. **Quel est l'email de contact pour le domaine cant-not-tweet-this.com ?**

- mode TXT
- *hostmaster@nsone.net*

![*](https://raw.githubusercontent.com/RaspCric/In-girum-imus-nocte-et-consumimur-igni/images/mail_txt.jpg)

12. **Quelles sont les coordonnées LAT,LON de l'instance root-servers la plus septentrionale?**

- https://root-servers.org/
- Nuuk, Groenland, Latitude : 64.175029 | Longitude : -51.735539

- nslookup
- set mode=loc
- IPv4 : 193.0.14.129

13. **Trouver un record TXT "fun" via une recherche genre https://medium.com/@fabianbeiner/fun-with-txt-records-3752fa5680a4**

![*](https://raw.githubusercontent.com/RaspCric/In-girum-imus-nocte-et-consumimur-igni/images/txt_fun.jpg)

14. **Combien coûte l'enregistrement de tinytuba.tours sur Gandi ?**

- Via le site, recherche du nom de domain
- Coût annuel 59,60 euros

15. **Quand le domaine thatsthefinger.com sera t'il disponible ?**

- http://www.whois-raynette.fr/
- Registrar Registration Expiration Date: 2021-11-16T07:53:48Z

16. **Chez quel hébergeur est le site de la mairie de Montcuq ?**

- La mairie utilise OVH

![*](https://raw.githubusercontent.com/RaspCric/In-girum-imus-nocte-et-consumimur-igni/images/montcul.jpg)

17. **Capturer un geotrace IP pour le domaine fallingfalling.com**

![*](https://raw.githubusercontent.com/RaspCric/In-girum-imus-nocte-et-consumimur-igni/images/tracert.jpg)

18. **Lister les IP et les FQDN des routeurs rencontrés entre vous et Amazon japon**

- tracert amazon.co.jp

![*](https://raw.githubusercontent.com/RaspCric/In-girum-imus-nocte-et-consumimur-igni/images/amazon_jp_hop.jpg)

19. **Trouver la liste des Servers DNS publics en Antarctique**

- https://public-dns.info/
- https://public-dns.info/nameserver/aq.html

![*](https://raw.githubusercontent.com/RaspCric/In-girum-imus-nocte-et-consumimur-igni/images/dns_antartic.jpg)

- numericable.fr ; sfr.net ; cogentco.com

20. **Quel est la législation du TLD pour Macao?**

- [Page wikipedia TLD_pays](https://en.wikipedia.org/wiki/Country_code_top-level_domain#Lists)
- extension : *.mo*
- Les titulaires doivent avoir une entreprise enregistrée à Macao, avec le même nom que le domaine qu'ils souhaitent enregistrer. 

21. **Combien y a t-il de sites en Corée du nord?**

- [Page wikipedia .kp](https://en.wikipedia.org/wiki/.kp)
- A moins 9 domaines de premier niveau .kp et plus de 30 domaines sont accessibles sur l'Internet mondial

22. **Synthétiser en 10 lignes la story de sex.com**

En mai 1994, Gary Kremen a enregistré *sex.com* auprès de Network Solutions, sans le développer. L'année suivante, ladite société a transféré, sans autorisation, le domaine à Stephen M. Cohen, celui-ci ayant soumis un faux fax pour arriver à cette fin. Dans la foulée, Cohen a utilisé l'allocation évocation du nom de domaine/publicité pour engranger beaucoup d'argent. S'en est suivi une bataille juridique entre Cohen et Kremen sur fond de l'infrastructure d'enregistrement des noms de domaine. Kremen a remporté la victoire en novembre 2000, lorsqu'il a été ordonné à Network Solutions de rendre le domaine au plaignant et à Cohen un remboursement de plusieurs dizaines de millions d'euros. 

23. **Quel est le BE pour potamochère.fr**

- WHOIS
- [Site de l'AFNIC pour trouver le BE](https://www.afnic.fr/noms-de-domaine/tout-savoir/annuaire-bureaux-enregistrement/)
- Bureau d'enregistrement : GANDI

24. **Combien y a t il de nom de domaines .fr enregistrés ?**

- [Rapport AFNIC](https://www.afnic.fr/observatoire-ressources/actualites/rapport-annuel-2020-transition-numerique-lafnic-et-le-fr-aux-cotes-des-tpe-pme/)
- 31/12/2020 : 3 670 372 noms de domaine
- Source : [Velhost](https://velhost.fr/web/combien-de-noms-de-domaine-en-fr-sont-enregistres-chaque-mois/) pour un graphique montrant la répartition des noms de domaine
- Sinon [tableau statistique de l'AFNIC](https://www.afnic.fr/observatoire-ressources/statistiques/)

![*](https://www.afnic.fr/wp-media/ftp/stats/Dashboard_desktop.png)

25. **Obtenir la liste des Registrars pour l'AFNIC**

- [Liste des bureaux d'enregistrements](https://www.afnic.fr/noms-de-domaine/tout-savoir/annuaire-bureaux-enregistrement/)

26. **Qui est le CEO fondateur gerant le TLD .sexy?**
- Société [Uniregistry](https://en.wikipedia.org/wiki/Uniregistry)
- CEO : Frank Schilling

27. **Quel est le pourcentage de  volume des Requêtes TCP(V4 et V6) par rapport aux UDP pour le premier server racine de Verisign le 25 décembre 2018 ?**

- https://root-servers.org/
- A, Verisign
- Statistics
- [Archives 2018](https://a.root-servers.org/raw-data/index.html)
- [Volume Traffic 25/12/2018](https://a.root-servers.org/raw-data/index.html)

UDP = 4374249647 (ipv4) + 743326738 (ipv6) = 5 117 576 385
TCP = 126256701 (ipv4) + 33257206 (ipv6) = 159 513 907

- 25/12/2018 : 5 277 090 292 requêtes, dont 97% en UDP et 3% en TCP

28. **Quel est le numéro de série du serveur qui gère eelslap.com ?**

- http://www.whois-raynette.fr/whois/eelslap.com
- ns1.mediatemple.net

![*](https://raw.githubusercontent.com/RaspCric/In-girum-imus-nocte-et-consumimur-igni/images/id_server.jpg)

- Serial number server : 2020070101

29. **A qui appartient la plage d'IP du domaine endless.horse?**

- [Page Wikipedia TLD](https://en.wikipedia.org/wiki/List_of_Internet_top-level_domains#H)
- Société : [Minds + Machines](https://mmx.co/)
- nslookup > 104.236.181.76
-> https://apps.db.ripe.net/db-web-ui/query?searchtext=104.236.181.76
-> https://search.arin.net/rdap/?query=104.236.181.76
- DigitalOcean, LLC

30. Tester et faire des captures d'utilisation des soft de cet article : https://www.cnetfrance.fr/news/trois-logiciels-pour-optimiser-les-dns-vos-mises-a-jour-hebdo-39785896.htm

**DNS Jumper**

- [Lien de téléchargement](https://www.cnetfrance.fr/telecharger/dns-jumper-39958521s.htm)

![*](https://raw.githubusercontent.com/RaspCric/In-girum-imus-nocte-et-consumimur-igni/images/DNS_jmper_test.jpg)

**NameBench**

- [Lien de téléchargement](https://www.cnetfrance.fr/telecharger/namehelp-40337377s.htm)

![*](https://raw.githubusercontent.com/RaspCric/In-girum-imus-nocte-et-consumimur-igni/images/namebench4.png)

![*](https://raw.githubusercontent.com/RaspCric/In-girum-imus-nocte-et-consumimur-igni/images/namebench1.png)

![*](https://raw.githubusercontent.com/RaspCric/In-girum-imus-nocte-et-consumimur-igni/images/namebench2.png)

![*](https://raw.githubusercontent.com/RaspCric/In-girum-imus-nocte-et-consumimur-igni/images/namebench3.png)


**NameHelp**

- [Lien de téléchargement](https://fr.freedownloadmanager.org/Windows-PC/Namehelp-GRATUIT.html)
- http://localhost:53533/#dashboard


---

---

### **Exercices** <a name="15"></a>


**Ressources Web :**

- [OpenClassoom : prise en main WS et install DNS, WS16](https://openclassrooms.com/fr/courses/2356306-prenez-en-main-windows-server/5835581-installez-un-serveur-dns)
- [Créer et configurer un serveur DNS, ainsi que déléguer des sous-domaines sous Windows Server 2012 / 2012 R2](https://www.informatiweb-pro.net/admin-systeme/win-server/ws-2012-2012-r2-creer-un-serveur-dns-et-deleguer-des-sous-domaines.html)
- [Install and Configure DNS Server on Windows Server 2019](https://computingforgeeks.com/install-and-configure-dns-server-in-windows-server/)
- [DNS configuration d’un redirecteur](https://rdr-it.com/dns-configuration-dun-redirecteur/)
- [Microsoft Windows server 2008 R2](http://idum.fr/spip.php?article175)

#### **Windows Server 2019** <a name="16"></a>

- [Lien vers le pitch CEFIM](https://campus.cefim.eu/mod/page/view.php?id=27025)

<u>Création d'un serveur dns primaire</u>

> ```sconfig```: MAJ enlevée, bureau à distance activé...</br>
- Via *Réseau et partage, paramètre de la carte* : (1) IP fixe (192.168.20.26), (2) Passerelle (192.168.20.254), (3) DNS (127.0.0.1) + (4) mise d'un suffixe DNS = [Ressource Web](https://www.intel.fr/content/www/fr/fr/support/articles/000027773/software/software-applications.html), ici "*dns*", et (6) enlever l'IPv6
- Via *secpol.msc* ou *gpedit.msc* : mise en réseau privé, règles FW (UDP/TCP_53 + ICMP)
- Install via Ninite/IE : 7zip, sumatrapdf, notepad++, chrome, bginfo
- Via *Gestisonnaire Server* : sécurité IE enlevé, changement nom ordi (NS1RD), changement nom workgroup (ACAB)
> ```services.msc``` : server DNS<br/>
- Via gestion nom ordi : changer nom/domaine, autres, suffixe, acab.lan


![1](https://raw.githubusercontent.com/RaspCric/In-girum-imus-nocte-et-consumimur-igni/images/nom_fw_IE_maj.jpg)

![2](https://raw.githubusercontent.com/RaspCric/In-girum-imus-nocte-et-consumimur-igni/images/ip_dns_passerelle_suffixe.jpg)

![2bis](https://raw.githubusercontent.com/RaspCric/In-girum-imus-nocte-et-consumimur-igni/images/ping.jpg)

![6](https://raw.githubusercontent.com/RaspCric/In-girum-imus-nocte-et-consumimur-igni/images/r%C3%A8gles_logiciels.jpg)

![3](https://raw.githubusercontent.com/RaspCric/In-girum-imus-nocte-et-consumimur-igni/images/server_dns_tp.jpg)

![4](https://raw.githubusercontent.com/RaspCric/In-girum-imus-nocte-et-consumimur-igni/images/services_dns.jpg)

![5](https://raw.githubusercontent.com/RaspCric/In-girum-imus-nocte-et-consumimur-igni/images/nslookup_sys32.jpg)

- Server DNS préféré sur Host : 192.168.20.26
- https://www.internic.net/domain/named.root -> CACHE.DNS (c/win/sys32/dns + à la racine /sys32 il y a les binaires dns)
- services.msc -> redémarre le service
- paramètres DNS -> logs à la racine sur une recherche simple (via paramètres server DNS dans "enregistrement de debogage)

**Zones DNS**

- Zones DNS : New zone / zone principale / acab.lan / nv fichier (racine dossier /sys32/dns/acab.lan.dns) 
- Zones DNS : New zone inversée / IPv4 / 192.168.20 (24bits, fait la correspondance avec la norme reverse 20.168.192.in-addr.arpa) / nv fichier 192.168.20.in-addr.arap.dns
- Paramètrages, Propriété : SOA : série (1), server principal (ns1.acab.lan.), personne responsable (hostmaster.acab.lan.)
- Paramètrages, Propriété : Servers de noms -> ns1..lan. + ns2..lan. avec les bonnes IP
- Dans la Zone : tu pètes l'hôte ns1RD + création record A ns1/ns2
- Options Zone invesée -> on change SOA + server de nom en rapport avec options Zone principale

![*](https://raw.githubusercontent.com/RaspCric/In-girum-imus-nocte-et-consumimur-igni/images/gstdns.jpg)

![*](https://raw.githubusercontent.com/RaspCric/In-girum-imus-nocte-et-consumimur-igni/images/zr1.jpg)

![*](https://raw.githubusercontent.com/RaspCric/In-girum-imus-nocte-et-consumimur-igni/images/z2.jpg)

![*](https://raw.githubusercontent.com/RaspCric/In-girum-imus-nocte-et-consumimur-igni/images/z3.jpg)

![*](https://raw.githubusercontent.com/RaspCric/In-girum-imus-nocte-et-consumimur-igni/images/z4.jpg)

![*](https://raw.githubusercontent.com/RaspCric/In-girum-imus-nocte-et-consumimur-igni/images/zcheckserver.jpg)

- Ajout Hôtes sur Zone : router (192.168.20.254)...
- Hôtes A = lien IP/ressource
- CNAME = faire un lien nommé vers un hôte A (ap pour accesspoint -> wifi, pour la récursivité)

![*](https://raw.githubusercontent.com/RaspCric/In-girum-imus-nocte-et-consumimur-igni/images/zcname.jpg)

- création d'un hôte A : mail.acab.lan
- création de plein de CNAME derrière (pop, pop3, pops, imap...)
- création d'un server de messagerie MX (avec lien qui pointe vers le mail.acab.lan)

![*](https://raw.githubusercontent.com/RaspCric/In-girum-imus-nocte-et-consumimur-igni/images/zcheckif.jpg)

- création d'un alias *www* vers *ns1.acab.lan*
- utilisation de serva community
- creation d'un index.html simple http avec image (http bind, c:/www/)

![*](https://raw.githubusercontent.com/RaspCric/In-girum-imus-nocte-et-consumimur-igni/images/zpageweb.jpg)


<u>Création d'un serveur dns secondaire</u>

- Master WS19
- Nom : NS2RD7, ACAB, acab.lan
- IP fixe + infos passerelle + DNS primaire (192.168.20.26) et secondaire (1.1.1.1)
- ajout rôle DNS simple
- Nouvelle zone principale *acab.lan* + zone principale sur 192.168.20.26
- Eteindre NS1
- Vérification de la bascule via poste hôte (clean cache dns au besoin)

![*](https://raw.githubusercontent.com/RaspCric/In-girum-imus-nocte-et-consumimur-igni/images/zserver2e.jpg)

- Bien vérifier les redirecteurs (sur NS1RD.acab.lan) + transferts de zone (NS2)
- Console Best Pratice Analyser / checks erreurs

![*](https://raw.githubusercontent.com/RaspCric/In-girum-imus-nocte-et-consumimur-igni/images/zerrors.jpg)


#### *Debian10 et Bind9** <a name="17"></a>

- Information de connexion pour le SSH :
- root / Admin7007
- user / dadfba16
- rasp / rasp

**Ressources Web**

- [Lien Ubuntu](https://doc.ubuntu-fr.org/bind9)
- [Lien Debian](https://debian-facile.org/atelier:chantier:dns-bind9-sur-wheezy)
- [Lien WikiDebian](https://wiki.debian.org/fr/Bind9)
- [Lien IT](https://www.it-connect.fr/chapitres/dns-installer-un-serveur-bind-sous-linux/)
- [Lien du cours via site en local](https://cefimeu-my.sharepoint.com/:u:/g/personal/rdelmas_cefim_eu/EU13_SSdw55EolsCvsZv2EYBiNnjP0Tn_vz52JfJ87XS2g?e=KN9oPx)

BIND (Berkeley Internet Name Daemon, parfois Berkeley Internet Name Domain) est le serveur DNS le plus utilisé sur Internet, spécialement sur les systèmes de type UNIX et est devenu de facto un standard. La première version de BIND a été conçue par quatre étudiants diplômés de l'Université de Californie (Berkeley) sur la base du système d'exploitation BSD 4.3. En 1988 c'est Paul Vixie qui reprenait la maintenance du projet. Le logiciel est actuellement développé par l'Internet Systems Consortium.

La version 9 de BIND (BIND 9), disponible depuis 2000 (Version 9.116  en aout 2021), a été réécrite afin de résoudre certains problèmes architecturaux du code initial et d'ajouter la prise en charge de DNSSEC (DNS Security Extensions). D'autres points importants ont été inclus dans cette version : TSIG, notification DNS, nsupdate, IPv6, support Multiprocesseur ainsi qu'une meilleure portabilité. C'est actuellement un logiciel très répandu au sein des systèmes Linux.


**Server Primaire**

- resolv.conf et interfaces

![*](https://raw.githubusercontent.com/RaspCric/In-girum-imus-nocte-et-consumimur-igni/images/ns1_dns_resolvinter.jpg)

- hosts

![*](https://raw.githubusercontent.com/RaspCric/In-girum-imus-nocte-et-consumimur-igni/images/ns1_dns_hosts.jpg)

- check install Bind

![*](https://raw.githubusercontent.com/RaspCric/In-girum-imus-nocte-et-consumimur-igni/images/ns1_dns_dossbind.jpg)

- named.conf

![*](https://raw.githubusercontent.com/RaspCric/In-girum-imus-nocte-et-consumimur-igni/images/ns1_dns_namedconf.jpg)

- default-zones

![*](https://raw.githubusercontent.com/RaspCric/In-girum-imus-nocte-et-consumimur-igni/images/ns1_dns_default-zones.jpg)

- named.conf.local

![*](https://raw.githubusercontent.com/RaspCric/In-girum-imus-nocte-et-consumimur-igni/images/ns1_dns_namedconflocal.jpg)

- named conf options

![*](https://raw.githubusercontent.com/RaspCric/In-girum-imus-nocte-et-consumimur-igni/images/ns1_dns_namedconfoptions.jpg)
Il manque un "};" pour cloturer les arguments

- db.acab.lan

![*](https://raw.githubusercontent.com/RaspCric/In-girum-imus-nocte-et-consumimur-igni/images/ns1_dns_dbcablan.jpg)

- Zone reverse ns1

![*](https://raw.githubusercontent.com/RaspCric/In-girum-imus-nocte-et-consumimur-igni/images/ns1_dns_db20168192.jpg)

- On check s'il y a des erreurs dans les fichiers "conf" et sur le server
> ```named-checkconf```<br/>
> ```systemctl status bind9```<br/>

- Fonctionnement du server DNS via machine host

![*](https://raw.githubusercontent.com/RaspCric/In-girum-imus-nocte-et-consumimur-igni/images/ns1_ok.jpg)


**Server Secondaire**


- interfaces

![*](https://raw.githubusercontent.com/RaspCric/In-girum-imus-nocte-et-consumimur-igni/images/ns2_interfaces.jpg)

- hosts

![*](https://raw.githubusercontent.com/RaspCric/In-girum-imus-nocte-et-consumimur-igni/images/ns2_hosts.jpg)

- resolv.conf

![*](https://raw.githubusercontent.com/RaspCric/In-girum-imus-nocte-et-consumimur-igni/images/ns2_resolv.jpg)

- named.conf

![*](https://raw.githubusercontent.com/RaspCric/In-girum-imus-nocte-et-consumimur-igni/images/ns2_namedconf.jpg)

- dossiers dans Bind

![*](https://raw.githubusercontent.com/RaspCric/In-girum-imus-nocte-et-consumimur-igni/images/ns2_bind.jpg)

- default-zones

![*](https://raw.githubusercontent.com/RaspCric/In-girum-imus-nocte-et-consumimur-igni/images/ns2_defaultzones.jpg)

- named.conf

![*](https://raw.githubusercontent.com/RaspCric/In-girum-imus-nocte-et-consumimur-igni/images/ns2_namedconf.jpg)

- conf.local

![*](https://raw.githubusercontent.com/RaspCric/In-girum-imus-nocte-et-consumimur-igni/images/ns2_conflocal.jpg)

- conf.options

![*](https://raw.githubusercontent.com/RaspCric/In-girum-imus-nocte-et-consumimur-igni/images/ns2_confoptions.jpg)
(il manque "};" à la fin)

- On check s'il y a des erreurs dans les fichiers "conf" et sur le server
> ```named-checkconf```<br/>
> ```systemctl status bind9```<br/>

- Ensuite on éteint NS1
- On lance un cmd nslookup sur l'host pour vérifier la bascule

![*](https://raw.githubusercontent.com/RaspCric/In-girum-imus-nocte-et-consumimur-igni/images/ns2_resolutionfinale.jpg)


#### *Packet Tracer et DNS** <a name="18"></a>

**Objectif**: Utiliser DNS pour adresser et configurer les services courant dans un LAN (enfin deux dans le cas de cet exercice)
- Les protocoles HTTP,HTTPS,FTP,DHCP,POP,IMAP,SMTP doivent tous utiliser le service DNS déclarés pour la zone perdu.com
- Le poste client de Jean Peuplu doit pouvoir utiliser ses services en mode client/serveur et entre autre envoyer un email à Bruno Dagen

**Prérequis**

- Activation des interfaces dans les commutateurs (config *no-shutdown* sur les interfaces ou bien un clic dans l'onglet config)
- Branchements via les ports afférents
- Calcul des adresses et organisation des étiquettes
- check de l'ensemble

![*](https://raw.githubusercontent.com/RaspCric/In-girum-imus-nocte-et-consumimur-igni/images/dns_pt_rzook.jpg)

**Config servers**

- Config server DNS
- Suppression des services inutiles
- Attribution IP fixe, passerelle et mep DNS

![*](https://raw.githubusercontent.com/RaspCric/In-girum-imus-nocte-et-consumimur-igni/images/dns_pt_dnsconfig0.jpg)

![*](https://raw.githubusercontent.com/RaspCric/In-girum-imus-nocte-et-consumimur-igni/images/dns_pt_dnsconfig.jpg)

- Config server DHCP
- Suppression des services inutiles
- Attribution IP fixe, passerelle et mep DHCP

![*](https://raw.githubusercontent.com/RaspCric/In-girum-imus-nocte-et-consumimur-igni/images/dns_pt_dhcpconfig0.jpg)

![*](https://raw.githubusercontent.com/RaspCric/In-girum-imus-nocte-et-consumimur-igni/images/dns_pt_dhcpconfig1.jpg)

- Config server mail
- Suppression des services inutiles
- Attribution IP fixe, passerelle et mep email

![*](https://raw.githubusercontent.com/RaspCric/In-girum-imus-nocte-et-consumimur-igni/images/dns_pt_mailconfig0.jpg)

![*](https://raw.githubusercontent.com/RaspCric/In-girum-imus-nocte-et-consumimur-igni/images/dns_pt_mailconfig1.jpg)

- Config server Web
- Suppression des services inutiles
- Attribution IP fixe, passerelle et acivation HTTP + FTP

![*](https://raw.githubusercontent.com/RaspCric/In-girum-imus-nocte-et-consumimur-igni/images/dns_pt_webconfig0.jpg)

![*](https://raw.githubusercontent.com/RaspCric/In-girum-imus-nocte-et-consumimur-igni/images/dns_pt_webconfig1.jpg)

**Tests fonctionnement**

- Test de pings

![*](https://raw.githubusercontent.com/RaspCric/In-girum-imus-nocte-et-consumimur-igni/images/dns_pt_test_pings.jpg)

- Test DHCP sur poste client

![*](https://raw.githubusercontent.com/RaspCric/In-girum-imus-nocte-et-consumimur-igni/images/dns_pt_test_DHCP.jpg)

- Test server mails entre les deux postes ordinateurs

![*](https://raw.githubusercontent.com/RaspCric/In-girum-imus-nocte-et-consumimur-igni/images/dns_pt_test_mails.jpg)

- Test accès web via server HTTPs par accès poste client

![*](https://raw.githubusercontent.com/RaspCric/In-girum-imus-nocte-et-consumimur-igni/images/dns_pt_test_web.jpg)

**Conclusion**

- [Lien vers le PT via OneDrive](https://cefimeu-my.sharepoint.com/:u:/g/personal/rdelmas_cefim_eu/EXACdl56XLJMoERngEZeWpcB1KNd37DtbHm2KDQTMKK5hw?e=Py7qhk)


---

---

![*](https://i.ytimg.com/vi/yH9UvkeAz-I/maxresdefault.jpg)

## Protocole DHCP <a name="19"></a>

L’histoire du DHCP débute en 1984, avec la création d’un nouveau protocole de connexion nommé RARP (Reverse Address Resolution Protocol) par l’IETF (Internet Engineering Task Force), organisme de standardisation de l’Internet. Le RARP rendait les ordinateurs sans stockage, appelés “diskless workstations”, capables de recevoir des adresses IP automatiquement. Ces ordinateurs démarraient alors en téléchargeant un OS à partir d’un simple serveur central.

Toutefois, le RARP était compliqué à mettre en place et à paramétrer. Il a donc été très vite perfectionné en 1985 jusqu’à devenir un nouveau support réseau nommé Bootstrap Protocol (BOOTP). Le protocole BOOTP pouvait distribuer des adresses IP automatiquement sur de multiples réseaux.

Le protocole DHCP a été développé à partir de BOOTP. Il est également en mesure de mettre à jour les adresses IP dynamiques sur des réseaux spécifiques et de les récupérer lorsque celles-ci ne servent plus.

Le DHCP peut aussi fournir des options supplémentaires pour la configuration des ordinateurs et des périphériques sur le réseau. Le protocole DHCP est devenu standard depuis 1993 et il a été constamment amélioré par la suite. On le retrouve par exemple dans  le système d’exploitation Windows Server.

**Ressources Web :**
- [Lien Wikipedia](https://en.wikipedia.org/wiki/Dynamic_Host_Configuration_Protocol)
- [Cour Univ Montreal](http://www.iro.umontreal.ca/~kropf/ift-6052/notes/dhcp/index.html)
- [Cours FrameIP](https://www.frameip.com/dhcp/)
- [Configurer le service DHCP sur un routeur Cisco](https://www.it-connect.fr/configurer-le-service-dhcp-sur-un-routeur-cisco/)
- [Neptunet](https://neptunet.fr/?s=dhcp)
- [OpenClassroom](https://openclassrooms.com/fr/courses/857447-apprenez-le-fonctionnement-des-reseaux-tcp-ip/856923-le-service-dhcp)
- [DHCP sur Windows](https://neptunet.fr/dhcp-windows/)
- [Windows Serveur installation et configuration du rôle DHCP](https://rdr-it.com/windows-installation-configuration-dhcp/)
- [Installer et configurer un serveur DHCP sous Windows Server 2019](https://www.it-connect.fr/installer-et-configurer-un-serveur-dhcp-sous-windows-server-2019/)
- [Ressource Ionos : DHCP, protocole réseau client/server](https://www.ionos.fr/digitalguide/serveur/configuration/dhcp-le-protocole-reseau-client-serveur/)
- [Fonctionnement de DHCP, Linux](http://www.linux-france.org/prj/edu/archinet/systeme/ch27s03.html)
- [Cours univ](https://web.maths.unsw.edu.au/~lafaye/CCM/internet/dhcp.htm)
- [Comment installer et configurer un serveur DHCP dans un groupe de travail](https://docs.microsoft.com/fr-fr/troubleshoot/windows-server/networking/install-configure-dhcp-server-workgroup)


### **Introduction** <a name="20"></a>


En général, les serveurs qui assurent le protocole DHCP sont gérés par des routeurs sur les réseaux en LAN. Sur de larges réseaux, le DHCP est assuré par des ordinateurs spéciaux. Le paramétrage DHCP comprend surtout la définition du champ de fonctionnement du serveur DHCP. Ce serveur attribue automatiquement des adresses IP et paramètre mécaniquement les autres données du réseau.

Le routeur joue le rôle de serveur DHCP pour la majorité des particuliers et des PME. Au sein des grands systèmes, un serveur spécialisé est requis pour remplir cette fonction.

Quand un dispositif sous tension est branché à un réseau avec un serveur DHCP, celui-ci envoie une requête DHCP au serveur, dénommée DHCPDISCOVER. Lorsque le message DISCOVER arrive au serveur DHCP, ce dernier garde une certaine adresse IP utilisable par le périphérique, puis la communique à son client par un signal DHCPOFFER.

Lorsque le client propose d’utiliser l’adresse IP retenue, le périphérique envoie un message DHCPREQUEST pour l’autoriser par le service DHCP. Puis le serveur transmet un ACK afin de valider que le dispositif accepte l’adresse IP précise. Il fixe ensuite la longueur de temps pendant que le dispositif utilise ladite adresse avant de recevoir une nouvelle adresse.

S’il décide que le périphérique concerné est incapable de fournir l’adresse IP, celui-ci transmet un NACK. Le réglage du DHCP est essentiel. Une mauvaise conception peut causer des interruptions majeures du réseau et entraîner des ralentissements lors de la recherche d’une solution au problème.


#### **Questionnaire** <a name="21"></a>


Le DHCP est un protocole réseau chargé de la configuration automatique des adresses IP d'un réseau informatique. Il évite ainsi à l'utilisateur qui se connecte pour la première fois à un réseau, d'avoir à configurer la pile IP de son équipement.

Le DHCP fonctionne avec l'IPv4 et l'IPv6 mais ce dernier peut s'en passer.


1. **Que signifie l’acronyme DHCP**
- Dynamic Host Configuration Protocol
- Le DHCP ou Dynamic Host Configuration Protocol est un protocole de communication ou protocole réseau parfaitement indispensable. On le traduit généralement par protocole de configuration dynamique des hôtes.

2. **De quel protocole vient il?**
- TCP/IP

3. **Quelle RFC définit en premier ce protocole?**
- [RFC 1531](https://fr.wikipedia.org/wiki/Dynamic_Host_Configuration_Protocol)

4. **A quel numéro de port est il lié?**
> ```c:/windows/system32/drivers/etc/services``` (liste de tous les ports et des protocoles afférents)<br/>
- Port 67 (en écoute, server)
- Port 68 (client)
Le client n’utilise que le port 68 pour envoyer et recevoir ses messages  de la même façon, le serveur envoie et reçoit ses messages sur un seul port, le port 67.

5. **Est ce qu’il travaille en TCP ou en UDP ?**
- Les messages DHCP sont transmises via UDP. Bien que peu fiable, ce protocole suffit au transport des paquets simples sur réseau local, et surtout il est très léger, donc intéressant pour les petits systèmes (du genre le micro bout de programme qui fait la requête DHCP lorsque le PC se met en route). De facto, DHCP fonctionne aussi en mode non connecté.

6. **Qu’est ce qu’un LEASE?**
- Pour des raisons d’optimisation des ressources réseau, les adresses IP sont délivrées pour une durée limitée. C’est ce qu’on appelle un bail (lease en anglais)

7. **Combien y a t il de secondes dans une heure,une journée,une semaine?**
- 1h = 60min = 60*60 = 3 600sc
- 24h = 24*3600 = 86 400sc
- 7*24*3600 = 604 800sc

8. **Qu’est ce qu’un bail statique?**
- Ressource web : [IT-connect](https://www.it-connect.fr/chapitres/quest-ce-quun-bail-dhcp/)
- Les baux actifs, ce sont les baux statiques ou pas qui sont utilisés sur le routeur au moment ou tu vérifies, le routeur avec la fonction DHCP attribue l'adresse IP X au périphérique Y. Les baux statiques, c'est la même adresse attribuée à chaque fois au même périphérique suivant l'identification par le code mac du périphérique. 

9. **Qu’est ce que du multipool?**
- C'est quand il y a plusieurs plages d'adresses disponibles via DHCP.
- Pool = étendue
- Multipool = plusieurs étendues

10. **Qu’est ce qu’une whitelist en MAC filtering?**
- Quand il y a filtrage par adresses MAC, il s'agit de la liste des adresses autorisées

11. **LE DHCP traverse-t-il les routeurs?**
- Non, il ne peut pas traverser un router (fonctionne par broadcast), sauf exception
- Oui, il a besoin d'un DHCP relay de paramétré

12. **Qu’est ce qu’un DHCP relay?**
- [Configurez les configurations de relais du protocole DHCP (DHCP) sur un commutateur par l'interface de ligne de commande (le CLI)](https://cefimeu-my.sharepoint.com/:b:/g/personal/rdelmas_cefim_eu/ESoL9hHGW2dJsokFBrfo-SQBnyb3m8hClqKLMpadE-CmdA?e=jF0BhN)
- Le relais DHCP est une caractéristique qui est utilisée par un commutateur, également connu sous le nom d'agent de relais, pour permettre la transmission DHCP entre les hôtes et les serveurs DHCP distants qui ne sont pas sur le même réseau.

13. **Quels sont les trois modes d’allocations d’une adresse?**
- **Allocation manuelle** – Le serveur propose une adresse IP spécifique que vous pouvez attribuer à un client DHCP. Il est impossible de récupérer l'adresse ou de l'assigner à un autre client.
- **Allocation automatique ou permanente** – Le serveur propose une adresse IP spécifique non limitée dans le temps. Cette adresse est ainsi associée de façon permanente au client jusqu'à ce que vous changiez l'affectation ou que le client libère l'adresse.
- **Allocation dynamique** – Le serveur propose une adresse IP au client demandeur pendant une durée précise. À l'expiration du bail prévu pour l'adresse, celle-ci est récupérée par le serveur qui se réserve le droit de l'allouer à un autre client. La période limite d'utilisation de l'adresse dépend de la durée du bail configurée pour le serveur.

14. **DHCP supporte t il IPv6?**
- Oui, il supporte l'IPv6 (IP locales générées par les clients eux-mêmes)
- [Ressource Wikipedia](https://en.wikipedia.org/wiki/DHCPv6)

15. **Quel est la première information poussée par le serveur ?, la seconde ?, la troisième ?, la quatrième ?**

- (1) Proposition IPv4, (2) Netmask, (3) Passerelle, (4) DNS,... (5) server de temps, NTP...

19. **Donner quelques options poussées par le serveur?**
- OPtion la plus importante : [server de temps](https://www.pool.ntp.org/zone/fr)
- Options disponibles via [RFC 2132](https://datatracker.ietf.org/doc/html/rfc2132) ou [IANA](https://www.iana.org/assignments/bootp-dhcp-parameters/bootp-dhcp-parameters.xhtml)

![*](https://raw.githubusercontent.com/RaspCric/In-girum-imus-nocte-et-consumimur-igni/images/options%20dhcp.jpg)

|Tag|Name| DataLength |Meaning |Reference |
|:-:|:-:|:-:|:-:|:-:|
|0    |Pad    |0    |None    |[RFC2132]
|1    |Subnet Mask    |4    |Subnet Mask Value    |[RFC2132]
|2    |Time Offset    |4    |Time Offset in Seconds from UTC (note: deprecated by 100 and 101)    |[RFC2132]
|3    |Router    |N    |N/4 Router addresses    |[RFC2132]
|4    |Time Server    |N    |N/4 Timeserver addresses    |[RFC2132]
|5    |Name Server    |N    |N/4 IEN-116 Server addresses    |[RFC2132]
|6    |Domain Server    |N    |N/4 DNS Server addresses    |[RFC2132]
|7    |Log Server    |N    |N/4 Logging Server addresses    |[RFC2132]
|8    |Quotes Server    |N    |N/4 Quotes Server addresses    |[RFC2132]
|9    |LPR Server    |N    |N/4 Printer Server addresses    |[RFC2132]
|10    |Impress Server    |N    |N/4 Impress Server addresses    |[RFC2132]

20. **Qu’est ce qu’un SCOPE?**
- Un [**scope**](https://documentation.solarwinds.com/en/success_center/ipam/content/ipam-create-dhcp-scopes.htm) est une plage d'adresses IP qu'un serveur DHCP peut assigner aux clients d'un sous-réseau.<br/>
= étendue dans un réseau donnév(regroupement administratif des IP des clients dans un sous-réseau)
- Un [**superscope**](https://docs.microsoft.com/en-us/openspecs/windows_protocols/ms-dhcpm/4b3dafe4-70e5-4085-969e-4bb402d9c68b) est une plage d'adresses IP qui couvre plusieurs sous-réseaux. Le serveur DHCP peut assigner ces adresses aux clients qui sont sur plusieurs sous-réseaux.

21. **Quand est-il intéressant d’avoir des baux courts?**
- [Durée d'un bail DHCP](https://telephonetecno.com/quest-ce-que-la-duree-du-bail-dhcp-et-comment-la-modifier/)
- Quand on utilise un réseau public ou ouvert, quand il y a beaucoup de turn-over

22. **Qu’est ce que l’adresse 255.255.255.255 en lien avec le DHCP?**
- [Lien Microsoft](https://docs.microsoft.com/fr-fr/windows-server/troubleshoot/dynamic-host-configuration-protocol-basics#:~:text=L%27adresse%20source%20est%20l,r%C3%A9seau%20dans%20le%20client%20demandeur)
- Broadcast général de diffusion
- Le client DHCP diffuse un message **DHCPDISCOVER** sur le sous-réseau du réseau en utilisant l'adresse de destination 255.255.255.255 (diffusion limitée) ou l'adresse de diffusion du sous-réseau spécifique (diffusion dirigée).

23. **Décrivez le processus d’attribution d’une adresse DHCP?**
- [Attribution IPv4 via DHCP](https://cisco.goffinet.org/ccna/services-infrastructure/attribution-adresses-dhcp-ipv4/)

![*](https://d33wubrfki0l68.cloudfront.net/efe59db8cd65ed72164b31e5b60ec487612a09e9/941fa/assets/images/ccna/dhcp-1.gif)

- Quatre phases : (1) server discovery, (2) IP lease offer, (3) IP lease request, et (4) IP lease acknowledgement. 
- Abrévation de ces quatre phases : **DORA** (discovery, offer, request, acknowledgement)

![*](https://upload.wikimedia.org/wikipedia/commons/thumb/e/e4/DHCP_session.svg/800px-DHCP_session.svg.png)

24. **Capturer des paquets DHCP à l’aide d’un outil de capture, effectuer une analyse**
- Wireshark
- [Wiki wireshark](https://wiki.wireshark.org/DHCP)
- ouvrir wireshark / lancer cmd
> ```ipconfig/release``` (libération du bail)<br/>
> ```ipconfig/renew```<br/>

![*](https://raw.githubusercontent.com/RaspCric/In-girum-imus-nocte-et-consumimur-igni/images/wireshark.jpg)

- Trame disponible [ici](https://cefimeu-my.sharepoint.com/:u:/g/personal/rdelmas_cefim_eu/ETBA-fkoghJGo8BCiOUeHl8BUnOuuj9GI0fHQ9sJTTuHJg?e=fYZszo)

25. **Qu’est ce que l’ISC?**
- Internet Systems Consortium
- Un consortium public à but non lucratif dont le but est d'aider à la mise en œuvre d'un « Internet universel auto-organisé ». Il s'agit d'une structure indépendante, les développeurs y participant créent et maintiennent notamment des logiciels comme une distribution DHCP (serveur et client), BIND (serveur DNS) ou encore d'InterNetNews (INN). 

26. **Quel produit est développé par cet organisme en lien avec ce protocole?**
- C'est l'Internet Software Consortium qui développe le serveur DHCP du monde du logiciel libre. C'est le serveur DHCP le plus répandu, et celui qui "suit" au mieux les RFCs
- DHCP server program : [DHCPD](https://en.wikipedia.org/wiki/DHCPD) ou [KEA](https://en.wikipedia.org/wiki/Kea_(software))

27. **Trouvez un tutorial en ligne sur l’installation du produit**
- [Lien vers la documentation officielle de KEA](https://kea.readthedocs.io/en/latest/)
- [SlideShare KEA](https://fr.slideshare.net/MenandMice/kea-dhcp-the-new-open-source-dhcp-server-from-isc)
- [Configuring DHCPD via DHCPD](http://oob.freeshell.org/nzwireless/dhcpd.html)

28. **Qu’est ce qu’une rogue DHCP?**
- [Lien Wikipedia](https://en.wikipedia.org/wiki/Rogue_DHCP)
- Il s'agit d'un serveur DHCP malveillant en tant que serveur DHCP sur un réseau qui n'est pas sous le contrôle administratif du personnel du réseau. Il s'agit d'un périphérique réseau, tel qu'un modem ou un routeur, connecté au réseau par un utilisateur qui n'est pas conscient des conséquences de ses actions ou qui l'utilise sciemment pour des attaques réseau telles que les attaques de type "man in the middle". Certains types de virus informatiques ou de logiciels malveillants ont été découverts pour mettre en place un DHCP malveillant, notamment pour ceux classés dans la catégorie.

29. **Qu’est ce que le 802.1x?**
- [Lien Wikipedia](https://fr.wikipedia.org/wiki/IEEE_802.1X)
- [802.1X](https://www.ieee802.org/1/pages/802.1x.html) est un standard lié à la sécurité des réseaux informatiques, mis au point en 2001 par l'IEEE (famille de la norme IEEE 802).
Il permet de contrôler l'accès aux équipements d'infrastructures réseau (et par ce biais, de relayer les informations liées aux dispositifs d'identification). 
- 802.1x est synonyme de Radius. 

30. **Le DHCP est il conseillé dans des infrastructures type TPE?**
- Oui
- Il devrait être choisi par défaut 

31. **Le DHCP est il conseillé dans des grosses infrastructures?**
- Oui
- La taille des réseaux actuels oblige de plus en plus à éliminer l’adressage statique saisi par un administrateur sur chaque machine par un adressage dynamique effectué par le biais du serveur DHCP. Ce dernier offre l’avantage d’offrir une configuration complète à chaque machine qui en fait la demande mais plus particulièrement, il est impossible de trouver deux configurations identiques (deux adresses IP identiques distribuées). Le conflit IP est donc évité, l’administration s’en trouve également facilité.

32. **Expliquez ZEROCONF?**
- [Lien Wikipedia](https://fr.wikipedia.org/wiki/Zeroconf)
- [Lien Ubuntu](https://doc.ubuntu-fr.org/zeroconf)
- ZeroConf est une collection d'outils et de protocoles servant à l'autoconfiguration des réseaux. Cette technologie est appelée Bonjour (ou encore RendezVous) par Apple et est utilisée intensivement par Mac OS X. 

33. Donnez la plage d’adressage de l’APIPA
- [Lien Wikipedia](https://fr.wikipedia.org/wiki/Automatic_Private_Internet_Protocol_Addressing)
- [It-Connect](https://www.it-connect.fr/adresse-apipa-169-154-quest-ce-que-cest/)
- Il arrive parfois sur les machines clientes attendant une configuration DHCP  que l'on se retrouve après un délai d'attente avec une adresse de type **169.254.X.X.** Ces adresses nous font souvent dire qu'il y a un problème au niveau de l'attribution des adresses IP mais on n'en sait rarement plus à leur sujet.

34. **Expliquer le DHCP snooping?**
- [Ressource Ionos](https://www.ionos.fr/digitalguide/serveur/securite/dhcp-snooping/)
- [Ressource FormIP](https://formip.com/dhcp-snooping/)
- [FS Community](https://community.fs.com/fr/blog/what-is-dhcp-snooping-and-how-it-works.html)
- [Ressource autre](https://le-guide-du-sysops.fr/index.php/2020/06/01/le-dhcp-snooping-pour-contrer-les-attaques-dhcp-spoofing/)
- [Ressource de Thomas](https://istacee.wordpress.com/2010/03/08/dhcp-snooping-defense-contre-le-dhcp-spoofing/)
- Le DHCP Snooping est une technique permettant d’empêcher de connecter un serveur DHCP indésirable sur un réseau. Celle-ci s’implémente exclusivement sur des switchs. Le principe consiste à filtrer les requêtes DHCP de type « DHCP OFFER » non autorisées. Pour cela, tous les ports du switch doivent filtrer les requêtes DHCP à l’exception du port correspondant à celui du serveur DHCP légitime du réseau.

![*](https://istacee.files.wordpress.com/2010/03/dchp1.jpg)
Transaction DHCP

![*](https://istacee.files.wordpress.com/2010/03/dchp2.jpg)
Ici un serveur DHCP pirate envoi aussi un DHCP OFFER, ce qui fait qu’il est potentiellement choisissable par la machine cliente

![*](https://lh6.googleusercontent.com/bYaowEVF3YuR9W1jKuEVK7f2uxvNVaXM87KsqDFZlJnb5-Y5Tz1jfhz-7HLIrSCgdw-F42awvRBt2ppS0yoKBgqs6EAcCmhmv1zS5h1kZbFMAGwlv4CT3QD5KcqTMoYA9fuivJI1)
Solution Snooping


---


### **Exercices** <a name="22"></a>


#### Packet Tracer : DHCP <a name="23"></a>

**Ressources web** :

- [Configure Dynamic Host Configuration Protocol (DHCP) Relay Settings on a Switch through the Command Line Interface (CLI)](https://www.cisco.com/c/en/us/support/docs/smb/switches/cisco-small-business-300-series-managed-switches/smb5567-configure-dynamic-host-configuration-protocol-dhcp-relay-set.html)
- [DHCP relay](https://cisco.goffinet.org/ccna/services-infrastructure/attribution-adresses-dhcp-ipv4/)
- [Mise en place d’un agent relais DHCP ](https://www.it-connect.fr/mise-en-place-dun-agent-relais-dhcp/)

**Mise en pratique**

- On réalise le shema et on vérifie que cela PING
- Faire pinger les machines en IP fixes

![*](https://raw.githubusercontent.com/RaspCric/In-girum-imus-nocte-et-consumimur-igni/images/pt_dhcp_ping2.jpg)

- On créé les pool DHCP

![*](https://raw.githubusercontent.com/RaspCric/In-girum-imus-nocte-et-consumimur-igni/images/pt_dhcp_config_dhcp.jpg)

- Il faut entrer dans les routers via CLI et indiquer le chemin du server du DHCP
- Rappel des [commandes CLI](https://www.cisco.com/c/en/us/td/docs/ios-xml/ios/fundamentals/configuration/15mt/fundamentals-15-mt-book/cf-cli-basics.html), ou, plus général de [comment fonctionne CLI](https://cisco.goffinet.org/ccna/cisco-ios-cli/methode-cisco-ios-cli/) ; possible aussi de jeter un coup d'oeil sur le .md de JB qui fait un [tableau recapitulatif des commandes](https://github.com/RaspCric/In-girum-imus-nocte-et-consumimur-igni/blob/b84299446078006ffaebe38b8375679e4ebadd87/AT2_C1_Cisco%20Cheat%20Sheet%20CLS%20IOS.pdf)
> ```enable```<br/>
> ```conf t```<br/>
- là on entre dans les pattes exterieures du router : 
>```interface``` (0.254 et 2.254)<br/>
- ensuite on assigne pour chaque patte du routeur l'IP du server DHCP
> ```ip helper-address <IP du server DHCP>```<br/>

![*](https://raw.githubusercontent.com/RaspCric/In-girum-imus-nocte-et-consumimur-igni/images/DHCP_ok.jpg)

- Les machines sous DHCP se ping bien entre elles
- Et ping bien les machines sous IP fixe

![*](https://raw.githubusercontent.com/RaspCric/In-girum-imus-nocte-et-consumimur-igni/images/dhcp_ping.jpg)

- [Lien PacketTracer via OneDrive](https://cefimeu-my.sharepoint.com/:u:/g/personal/rdelmas_cefim_eu/EUtXEkKh9_REpt1PvfK7RMIB6YoN32PAEw-3RLEkKmqVqA?e=dqtFnY)


#### **Mise en Oeuvre sous Linux Debian** <a name="24"></a>

- **Infra** : un ordi connecté au réseau web via wifi et qui va servir de routeur ; un switch pour ensuite dispatcher la connexion en mode local sur les autres PC (ici, un server DHCP qui va fournir les IP, et deux postes clients) ; un dlink simple connecté au switch, sans mode de routage, pour un Acces Point Wifi à paramétrer
- Réseau internet : 192.168.20.0/24 ; 192.168.20.254 (passerelle)
- Reseau local fourni : 192.168.5.0/24 ; 192.168.5.254 (passerelle)

##### **Poste sous Windows Server 2019 et install en mode routage**

- [tech2tech : WS16, install virtual router](https://www.tech2tech.fr/windows-server-2016-installation-dun-routeur-virtuel-pour-votre-lab/)
- [Dell.com : conf WS12 as a router](https://www.dell.com/support/kbdoc/fr-fr/000118763/configuration-de-windows-server-2012-r2-as-a-router)
- [rdr-it : mise en place routage WS](https://rdr-it.com/mise-en-place-routage-windows-serveur/)
- [Configure LAN Routing in Windows Server 2019](https://msftwebcast.com/2020/02/configure-lan-routing-in-windows-server-2019.html)
- [How to Configure Windows Server 2016 as a Router](https://www.itechguides.com/windows-server-2016-router-configuration/)


**Dans VMWare**

- Création d'une seconde carte réseau via la VM
- Première carte réseau (Wifi) : Wifi, en mode bridge
- Seconde carte réseau (NIC) : Realtek eth, en mode bridge

![*](https://raw.githubusercontent.com/RaspCric/In-girum-imus-nocte-et-consumimur-igni/images/w19_serv_1.jpg)

![*](https://raw.githubusercontent.com/RaspCric/In-girum-imus-nocte-et-consumimur-igni/images/w19_serv_2.jpg)

**Dans WS19**

- Paramètrage 1ère carte vers l'host (192.168.20.254/24), pour l'accès internet
- Paramétrage 2e carte réseau vers reseau local (192.168.5.254/24), pour la redirection

![*](https://raw.githubusercontent.com/RaspCric/In-girum-imus-nocte-et-consumimur-igni/images/AD_routage.jpg)

- WS2019, nouveau rôle, acces distance, router
- gestion routage
- clik droit, nouveau

![*](https://raw.githubusercontent.com/RaspCric/In-girum-imus-nocte-et-consumimur-igni/images/AD_routage_if.jpg)

- verif via host et vm (network via relatek carte)

![*](https://raw.githubusercontent.com/RaspCric/In-girum-imus-nocte-et-consumimur-igni/images/vm_ping.jpg)


##### **Mise en place d'un server DHCP via Debian**

- [Ressources doc.ubuntu](https://doc.ubuntu-fr.org/isc-dhcp-server#configuration_basique)
- [Ressource Linuxpedia](https://linuxpedia.fr/doku.php/dhcpd)
- [Ressource LinuxTricks](https://www.linuxtricks.fr/wiki/debian-installer-un-serveur-dhcp)
- [Help-ubuntu : isc dhcp server](https://help.ubuntu.com/community/isc-dhcp-server) 
- [Install and Configure ISC DHCP Server in Debian 9](https://www.howtoforge.com/tutorial/install-and-configure-isc-dhcp-server-in-debian-9/)
- [Installation et configuration d'un serveur DHCP](https://debian-facile.org/doc:reseau:dhcp)
- [WikiDeban : DHCP_Server](https://wiki.debian.org/fr/DHCP_Server)
- [Site web de l'outil : ISC-DHCP](https://www.isc.org/dhcp/)
- [Ressource Neptunet](https://neptunet.fr/dhcp-linux/)
- [Ressource IT-connect](https://www.it-connect.fr/serveur-dhcp-sous-linux/)

**Install du paquet**

- Installation du paquet
> ```apt install isc-dhcp-server -y```
- Check install ok

![*](https://raw.githubusercontent.com/RaspCric/In-girum-imus-nocte-et-consumimur-igni/images/dhcp_installok.jpg)

**Verification des configurations réseaux de la machine**

- Check fichier interfaces pour info sur le materiel réseau
- Select Interface card : 
> ```/etc/default/isc-dhcp-server```<br/>
> ```INTERFACES="wlan0 eth0"``` (possiblité d'en rajouter/enlever)

**Configuration de DHCPD**

- Modification du fichier dhcpd.conf

![*](https://raw.githubusercontent.com/RaspCric/In-girum-imus-nocte-et-consumimur-igni/images/DHCP_config%20simple_configgenerale.jpg)

![*](https://raw.githubusercontent.com/RaspCric/In-girum-imus-nocte-et-consumimur-igni/images/DHCP_config%20simple_reseaux.jpg)

![*](https://raw.githubusercontent.com/RaspCric/In-girum-imus-nocte-et-consumimur-igni/images/DHCP_config%20simple_ipfixes.jpg)

![*](https://raw.githubusercontent.com/RaspCric/In-girum-imus-nocte-et-consumimur-igni/images/DHCP_config%20simple_filtres_mac.jpg)


##### **Configuration Acess Point**

**Ressources Web**

- [Comment configurer le mode AP sur D-link](https://eu.dlink.com/fr/fr/support/faq/access-points-and-range-extenders/access-points/dwl-series/dwl-6700ap/dwl-6700ap-ap-mode-basic-configuration)
- [Dummies : Configuring a Wireless Access Point](https://www.dummies.com/programming/networking/configuring-a-wireless-access-point/)
- [Source Daddy](https://sourcedaddy.com/networking/access-point-configuration.html)
- [Cisco : Configuring the Access Point for the First Time](https://www.cisco.com/c/en/us/td/docs/wireless/access_point/15-3-3/configuration/guide/cg15-3-3/cg15-3-3-chap4-first.html)
- [TP-link : How to configure the Access Point mode](https://www.tp-link.com/fr/support/faq/716/)
- [Cisco : Installez un réseau sans fil utilisant un point d'accès sans fil (le WAP)](https://www.cisco.com/c/fr_ca/support/docs/smb/wireless/cisco-small-business-100-series-wireless-access-points/smb5530-set-up-a-wireless-network-using-a-wireless-access-point-wap.html)

**Configuration physique**

- Branchement de l'AP en filaire
- Configuration de la NIC sur réseau adresse IP générique de la borne wifi pour entrer dans le même réseau
- Accès Wifi via navigateur et 192.168.x.x
