# Service DNS

![logo1](https://kayamaga.com/wp-content/uploads/2019/07/DNS.jpg)

## Le Système de Nom de Domaine

**Définition d'un DNS**  
*Définition*: Domain Name System (ou DNS, système de noms de domaine)  
C'est un système de correspondance entre des humains et des machines.  
C'est un service permettant d'établir une correspondance entre une adresse IP et un nom de domaine et, plus généralement, de trouver une information à partir d'un nom de domaine. C'est un système hiérarchisé, il part d'un Domaine général qui se divise en sous domaine.  

**Fondamental: Principe du DNS**  
Les ordinateurs connectés à un réseau IP, comme Internet, possèdent une adresse IP. Ces adresses sont numériques afin d'être plus facilement traitées par une machine. En IPv4, elles sont représentées sous la forme xxx.xxx.xxx.xxx, où xxx est un nombre variant entre 0 et 255 (en système décimal). En IPv6, les IP sont de la forme xxxx:xxxx:xxxx:xxxx:xxxx:xxxx:xxxx:xxxx, où x représente un caractère au format hexadécimal. Pour faciliter l'accès aux systèmes qui disposent de ces adresses, un mécanisme a été mis en place pour permettre d'associer un nom à une adresse IP, plus simple à retenir, appelé nom de domaine. Résoudre un nom de domaine consiste à trouver l'adresse IP qui lui est associée.  
Les noms de domaines peuvent être également associés à d'autres informations que des adresses IP.  

**Définition: Serveurs DNS racine**  
Il existe 13 serveurs racine, nommés de a à m.root-servers.net. Ces serveurs sont gérés par douze organisations différentes : deux sont européennes, une japonaise et les neuf autres sont américaines. 10 de ces serveurs sont en réalité distribués dans le monde grâce à la technique anycast et 12 disposent d'une adresse IPv6. Grâce à anycast, plus de 900 serveurs répartis dans 50 pays du monde assurent ce service. *Le serveur k reçoit par exemple de l'ordre de 20 000 requêtes par seconde.*

Le DNS ne fournit pas de mécanisme pour découvrir la liste des serveurs racine, chacun des serveurs doit donc connaître cette liste au démarrage grâce à un encodage explicite. Cette liste est ensuite mise à jour en consultant l'un des serveurs indiqués. La mise à jour de cette liste est peu fréquente de façon à ce que les serveurs anciens continuent à fonctionner.

**[Le fameux site en question](https://root-servers.org/)**

IANA absorbé dans l'ICANN. C'est le plus important sur internet. Internet Corporation for Assigned Names and Numbers. Elle gère les noms de domaines et les adressages Ip. Sous la dépendance du gouvernement amériacains, doit passer à Genève mais c'est pas encore fait.  

|IANA|->|ICANN|
|:-:|:-:|:-:|
|IP| |Nom|
|IPV4 / IPV6| |.fr / .com|
|5 régional Register| | ccTLD / gTLD |
|RIPE / WIDE| |**C**ountry **C**ode / **G**eneric | 

**Définition: Fully Qualified Domain Name**  
On entend par Fully qualified domain name (FQDN), ou Nom de domaine pleinement qualifié un nom de domaine écrit de façon absolue, y compris tous les domaines jusqu'au domaine de premier niveau (TLD), il est ponctué par un point final, par exemple fr.wikipedia.org.  
La norme prévoit qu'un élément d'un nom de domaine (appelé label) ne peut dépasser 63 caractères, un FQDN ne pouvant dépasser 253 caractères.  
L'AFNIC gère le .fr  
**[Wiki TLD](https://en.wikipedia.org/wiki/List_of_Internet_top-level_domains)**  
**[Wiki ccTLD](https://en.wikipedia.org/wiki/Country_code_top-level_domain)**  
**[Domain Hack](https://en.wikipedia.org/wiki/Domain_hack)**  

## Histoire du DNS

Avant le DNS, la résolution d'un nom sur Internet devait se faire grâce à un fichier texte appelé HOSTS.TXT ([RFC 608](https://datatracker.ietf.org/doc/html/rfc608)) maintenu par le NIC du Stanford Research Institute (SRI) et recopié sur chaque ordinateur par transfert de fichier.  

En 1982, ce système centralisé montre ses limites et plusieurs propositions de remplacement voient le jour, parmi lesquelles le système distribué Grapevine de Xerox et IEN 116.   

Le premier est jugé trop compliqué tandis que le second est insuffisant.   

La tâche de développer un autre système revient à [Paul Mockapetris](https://fr.wikipedia.org/wiki/Paul_Mockapetris) qui publie le design du système dans les [RFC 882](https://datatracker.ietf.org/doc/html/rfc882) et [RFC 883](https://datatracker.ietf.org/doc/html/rfc883) en 1983. La norme correspondante est publiée dans les [RFC 1034](https://datatracker.ietf.org/doc/html/rfc1034) et [RFC 1035](https://datatracker.ietf.org/doc/html/rfc1035) en 1987. En 1987, le fichier HOSTS.TXT contenait 5500 entrées, tandis que 20000 hôtes étaient définis dans le DNS.  

## Hiérarchie 

Le système des noms de domaines consiste en une hiérarchie dont le sommet est appelé la racine. On représente cette dernière par un **point**. Dans un domaine, on peut créer un ou plusieurs sous-domaines ainsi qu'une délégation pour ceux-ci, c'est-à-dire une indication que les informations relatives à ce sous-domaine sont enregistrées sur un autre serveur. Ces sous-domaines peuvent à leur tour déléguer des sous-domaines vers d'autres serveurs.  

Tous les sous-domaines ne sont pas nécessairement délégués. Les délégations créent des zones, c'est-à-dire des ensembles de domaines et leurs sous-domaines non délégués qui sont configurés sur un serveur déterminé. Les zones sont souvent confondues avec les domaines.  
Les domaines se trouvant immédiatement sous la racine sont appelés domaine de premier niveau **(TLD : Top Level Domain)**. Les noms de domaines ne correspondant pas à une extension de pays sont appelés des domaines génériques (gTLD), par exemple .org ou .com. S'ils correspondent à des codes de pays (fr, be, ch...), on les appelle ccTLD (country code TLD).

On représente un nom de domaine en indiquant les domaines successifs séparés par un point, les noms de domaines supérieurs se trouvant à droite. Par exemple, le domaine org. est un TLD, sous-domaine de la racine. Le domaine wikipedia.org. est un sous-domaine de .org. . Cette délégation est accomplie en indiquant la liste des serveur DNS associée au sous-domaine dans le domaine de niveau supérieur.  

Les noms de domaines sont donc résolus en parcourant la hiérarchie depuis le sommet et en suivant les délégations successives, c'est-à-dire en parcourant le nom de domaine de droite à gauche.  

Pour qu'il fonctionne normalement, un nom de domaine doit avoir fait l'objet d'une délégation correcte dans le domaine de niveau supérieur.

*Soure: [Techno-Science](https://www.techno-science.net/glossaire-definition/Domain-Name-System.html)*

## Résolution du nom par un hôte  

Les hôtes n'ont qu'une connaissance limitée du système des noms de domaine. Quand ils doivent résoudre un nom, ils s'adressent à un ou plusieurs serveurs de noms dits récursifs, c'est-à-dire qui vont parcourir la hiérarchie DNS et faire suivre la requête à un ou plusieurs autres serveurs de noms pour fournir une réponse. Les adresses IP de ces serveurs récursifs sont souvent obtenues via DHCP ou encore configurés en dur sur la machine hôte. Les fournisseurs d'accès à Internet mettent à disposition de leurs clients ces serveurs récursifs. Il existe également des serveurs récursifs ouverts comme ceux de Google Public DNS ou OpenDNS et encore plus récemment Quad9 ou One.

Quand un serveur DNS récursif doit trouver l'adresse IP de fr.wikipedia.org, un processus itératif démarre pour consulter la hiérarchie DNS. Ce serveur demande aux serveurs DNS appelés serveurs racine quels serveurs peuvent lui répondre pour la zone org. Parmi ceux-ci, le serveur va en choisir un pour savoir quels serveurs sont capables de lui répondre pour la zone wikipedia.org. C'est un de ces derniers qui pourra lui donner l'adresse IP de fr.wikipedia.org. S'il se trouve qu'un serveur ne répond pas, un autre serveur de la liste sera consulté.

![Resolutiondns.png](https://www.techno-science.net/illustration/Definition/400px/DNS-iterations.png)  

Pour optimiser les requêtes ultérieures, les serveurs DNS récursifs font aussi office de DNS cache : ils gardent en mémoire (cache) la réponse d'une résolution de nom afin de ne pas effectuer ce processus à nouveau ultérieurement. Cette information est conservée pendant une période nommée Time to live et associée à chaque nom de domaine.

Un nom de domaine peut utiliser plusieurs serveurs DNS. Généralement, les noms de domaines en utilisent au moins deux : un primaire et un secondaire. Il peut y avoir plusieurs serveurs secondaires.

L'ensemble des serveurs primaires et secondaires font autorité pour un domaine, c'est-à-dire que la réponse ne fait pas appel à un autre serveur ou à un cache. Les serveurs récursifs fournissent des réponses qui ne sont pas nécessairement à jour, à cause du cache mis en place. On parle alors de réponse ne faisant pas autorité (non-authoritative answer).

Cette architecture garantit au réseau Internet une certaine continuité dans la résolution des noms. Quand un serveur DNS tombe en panne, le bon fonctionnement de la résolution de nom n'est pas remis en cause dans la mesure où des serveurs secondaires sont disponibles.

IMAGE

Résolution itérative d'un nom dans le DNS par un serveur DNS (étapes 2 à 7) et réponse (étape 8) suite à l'interrogation récursive (étape 1) effectuée par un client (resolver) DNS. (remarque: Le serveur DNS récursif est dit récursif car il accepte ce type de requêtes mais il effectue des requêtes itératives)  

**Quelques commandes**
Vider le cash dns:  
> ipconfig/flushdns

Afficher le cash dns:  
> ipconfig/displaydns  

## Résolution Inverse

![*](https://images.ctfassets.net/plii0v5gbc4s/1Y1Z04UYBC4OIVcUYb2MIl/52f06f2598e7e7024a2a21957b12390a/reverse-dns-example.png)

Pour trouver le nom de domaine associé à une adresse IP, on utilise un principe semblable. Dans un nom de domaine, la partie la plus générale est à droite : org dans fr.wikipedia.org, le mécanisme de résolution parcourt donc le nom de domaine de droite à gauche. Dans une adresse IP, c'est le contraire : 213 est la partie la plus générale de 213.228.0.42. Pour conserver une logique cohérente, on inverse l'ordre des quatre termes de l'adresse et on la concatène au pseudo domaine in-addr.arpa. Ainsi, par exemple, pour trouver le nom de domaine de l'adresse IP 91.198.174.2, on résout 2.174.198.91.in-addr.arpa.  

Filtrage d'un trame dns:
![](https://github.com/cromm24/Hello_World/blob/main/AT2/AT2C1/DNS/dns_recordA_1.png?raw=true)
![](https://github.com/cromm24/Hello_World/blob/main/AT2/AT2C1/DNS/dns_recordA_2.png?raw=true)

La déclaration inverse est importante sur les adresses IP publiques Internet puisque l'absence d'une résolution inverse est considéré comme une erreur opérationnelle (RFC 1912) qui peut entrainer le refus d'accès à un service. Par exemple, un serveur de messagerie électronique se présentant en envoi avec une adresse IP n'ayant pas de résolution inverse (PTR) a de grandes chances de se voir refuser, par l'hôte distant, la transmission du courrier (message de refus de type : IP lookup failed).  

Une adresse IP peut être associée à plusieurs différents noms de domaine via l'enregistrement de plusieurs entrées PTR dans le sous-domaine .arpa dédié à cette adresse (in-addr.arpa. pour IPv4 et ip6.arpa. pour IPv6). L'utilisation d'enregistrements PTR multiples pour une même adresse IP est éventuellement présente dans le cadre de l'hébergement virtuel de multiples domaines web derrière la même adresse IP mais n'est pas recommandé dans la mesure où le nombre des champs PTR à renvoyer peut faire dépasser à la réponse la taille des paquets UDP de réponse et entraîner l'utilisation du protocole TCP (plus coûteux en ressources) pour envoyer la réponse à la requête DNS.  

## Les différents types d'enregistrements du DNS

Les principaux enregistrements définis sont les suivants:

**A record ou address record**
Cet enregistrement fait correspondre un nom d'hôte à une adresse IPv4 de 32 bits distribués sur quatre octets.  
Par exemple : hote.domaine.fr => 123.234.1.2  

**AAAA record ou IPv6 address record**
Cet enregistrement fait correspondre un nom d'hôte à une adresse IPv6 de 128 bits distribués sur seize octets.  
Par exemple : hote.domaine.fr => 2001:0db8:0000:85a3:0000:0000:ac1f:8001  

**CNAME record ou canonical name record**
Cet enregistrement permet de faire d'un domaine un alias vers un autre. Cet alias hérite de tous les sous-domaines de l'original.  
Un enregistrement CNAME peut pointer vers un autre enregistrement CNAME mais cette méthode est déconseillée car elle double le nombre de requêtes au serveur DNS.  
Par exemple : [www.domaine.fr](https://www.domaine.fr/) => hote.domaine.fr

**MX record ou mail exchange record**  
Cet enregistrement défini les serveurs de courriel pour ce domaine. Un enregistrement MX ne peux pointer que vers un enregistrement A, et non un alias CNAME.  
Par exemple si on défini le MX record de domain.fr comme étant l'adresse 123.234.1.3, les mails envoyer à @domaine.fr seront aiguillé vers cette même adresse.  
Pour debrayer nslookup en mode mx:
> nslookup
> set type=mx

![](https://github.com/cromm24/Hello_World/blob/main/AT2/AT2C1/DNS/nslookup_mx.png?raw=true)  

**PTR record ou pointer record**   
Cet enregistrement associe une adresse IP à un enregistrement de nom de domaine, aussi dit « reverse » puisque il fait exactement le contraire du A ou du AAA record. Il est indispensable à de nombreux services, qu'a chaque A ou AAA record corresponde sont PTR record.  
Par exemple : 123.234.1.2 => hote.domaine.fr  

**NS record ou name server record**  
Cet enregistrement défini les serveurs DNS de ce domaine. Un enregistrement NS ne peux pointer que vers un enregistrement A, et non un alias CNAME.  
Il peut y avoir plusieurs enregistrements NS si il existe plusieurs serveurs de messagerie sur le domaine.  
Par exemple, si on défini 123.234.1.1 comme NS record de domaine.fr, il sera alors un des serveurs consulté pour tout les sous domaine de .domain.fr comme par exemple hote.domaine.fr  

![](https://github.com/cromm24/Hello_World/blob/main/AT2/AT2C1/DNS/nslookup_ns.png?raw=true)  

**SOA record ou Start Of Authority record**  
Cet enregistrement donne les informations générales de la zone : serveur principal, courriel de contact, différentes durées dont celle d'expiration, numéro de série de la zone.  

![](https://github.com/cromm24/Hello_World/blob/main/AT2/AT2C1/DNS/nslookup_soa.png?raw=true)  

*Remarque: Il existe encore beaucoup d'autre type d'enregistrement (NAPTR, LOC, TXT, ).*
![](https://github.com/cromm24/Hello_World/blob/main/AT2/AT2C1/DNS/nslookup_txt.png?raw=true)  

Un enregistrement ne contient pas forcément une référence à une machine. par exemple un enregistrement TXT une chaîne de caractère (souvent utiliser pour précisé des paramètres de la zone DNS) ou encore l'enregistrement LOC qui peut contenir la localisation géographique d'une machine ou d'une zone DNS (latitude, longitude).

*Ressources supplémentaires:*  
[DNS Record](http://dns-record-viewer.online-domain-tools.com/)  
[DNS Record List](https://www.google.com/search?q=dns+record+listing&oq=dns+record+list&aqs=chrome.2.69i57j0l5.5093j0j9&sourceid=chrome&ie=UTF-8)  

## Quelques Considérations Opérationnelles sur le DNS

**Mise à jour et cohérence du DNS**
Les mises à jour se font sur le serveur primaire du domaine, les serveurs secondaires recopiant les informations du serveur primaire dans un mécanisme appelé transfert de zone. Pour déterminer si un transfert de zone doit avoir lieu, le serveur secondaire consulte le numéro de version de la zone et le compare à la version qu'il possède. Le serveur primaire détermine à quelle fréquence le numéro de version est consulté. Quand un changement est effectué, les serveurs envoient des messages de notification aux serveurs secondaires pour accélérer le processus.  

Il se peut que des informations qui ne sont plus à jour soient cependant conservées dans des serveurs cache. Il faut alors attendre l'expiration de leur Time to live pour que ces informations cachées disparaissent et donc que la mise à jour soit pleinement effective. On peut minimiser le temps nécessaire en diminuant le TTL associé aux noms de domaines qui vont être modifiées préalablement à une opération de changement.  

Quand la liste des serveurs de noms change, ou quand une adresse IP est modifiée, le gestionnaire du domaine de niveau supérieur doit effectuer la mise à jour correspondante.  

**Robustesse du DNS**  
Pour éviter les points individuels de défaillance, on évite de partager l'infrastructure entre les serveurs qui font autorité. Un serveur secondaire sera de préférence délocalisé et routé différemment que le serveur primaire.

Bien que cela soit techniquement possible, on évite de mêler sur un même serveur le rôle de DNS récursif et celui de serveur qui fait autorité.

De même, un hôte sera configuré avec plusieurs serveurs récursifs, de sorte que si le premier ne répond pas à la requête, le suivant sera employé. En général, les serveurs récursifs fournis par les FAI refusent les requêtes émanant d'adresses IP appartenant à d'autres FAI.

Il existe des services de DNS récursifs ouverts, c'est-à-dire qu'ils acceptent les requêtes de tous les clients. Il est donc possible à un utilisateur de configurer ceux-ci en lieu et place de ceux fournis par le FAI. Ceci pose cependant les problèmes suivants :

il n'y a pas de garantie que les réponses fournies seront les mêmes qu'avec des serveurs récursifs habituels. Un tel service pourrait en effet faire référence à une autre hiérarchie depuis la racine, disposer de TLD additionnels non standard, restreindre l'accès à certains domaines, voire altérer certains records avant leur transmission au client.

il n'y a pas de garantie de confidentialité, c'est-à-dire que ce service pourrait déterminer à quels domaines un utilisateur à accès en conservant des traces des requêtes DNS.

## Sécurité du DNS

Le protocole DNS a été conçu avec un souci minimum de la sécurité. Plusieurs failles de sécurité du protocole DNS ont été identifiées depuis. Les principales failles du DNS ont été décrites dans le [RFC 3833](https://datatracker.ietf.org/doc/html/rfc3833) publié en août 2004.  
En voici quelques exemples:  

* Interception des paquets:  
Une des failles mises en avant est la possibilité d'intercepter les paquets transmis. Les serveurs DNS communiquent au moyen de paquets uniques et non signés. Ces deux spécificités rendent l'interception très aisée. L'interception peut se concrétiser de différentes manières, notamment via une attaque de type « man in the middle », de l'écoute des données transférées et de l'envoi de réponse falsifiée (voir paragraphe ci-dessous).
[DNS hijacking](https://www.ionos.fr/digitalguide/serveur/securite/quest-ce-que-le-dns-hijacking/)


* Fabrication d'une réponse:  
Les paquets des serveurs DNS étant faiblement sécurisés, authentifiés par un numéro de requête, il est possible de fabriquer de faux paquets. Par exemple, un utilisateur qui souhaite accéder au site http://mabanque.example.com fait une demande au site DNS. Il suffit à ce qu'un pirate informatique réponde à la requête de l'utilisateur avant le serveur DNS pour que l'utilisateur se retrouve sur un site de phishing.

* Corruption des données:  
La trahison par un serveur, ou corruption de données, est, techniquement, identique à une interception des paquets. La seule différence venant du fait que l'utilisateur envoie volontairement sa requête au serveur. Cette situation peut arriver lorsque, par exemple, l'opérateur du serveur DNS souhaite mettre en avant un partenaire commercial.

* Empoisonnement du cache DNS:  
L'empoisonnement du cache DNS ou pollution de cache DNS (DNS cache poisoning ou DNS cache pollution en anglais) est une technique permettant de leurrer les serveurs DNS afin de leur faire croire qu'ils reçoivent une requête valide tandis qu'elle est frauduleuse. Une fois que le serveur DNS a été empoisonné, l'information est mise dans un cache, rendant ainsi vulnérable tous les utilisateurs de ce serveur. Ce type d'attaque permet, par exemple, d'envoyer un utilisateur vers un faux site dont le contenu peut servir à de l'hameçonnage (dans le cas du DNS, on parle de pharming) ou comme vecteur de virus et autres applications malveillantes.  
Un ordinateur présent sur Internet utilise normalement un serveur DNS géré par le fournisseur d'accès. Ce serveur DNS est la plupart du temps limité aux seuls utilisateurs du réseau du fournisseur d'accès et son cache contient une partie des informations rapatriées par le passé. Une attaque par empoisonnement sur un seul serveur DNS du fournisseur d'accès peut affecter l'ensemble de ses utilisateurs, soit directement ou indirectement si des serveurs esclaves s'occupent de propager l'information.

|Empoisonnement DNS|
|:-:|
![](https://github.com/cromm24/Hello_World/blob/main/AT2/AT2C1/DNS/empoisennement_dns.png?raw=true)

* Déni de Service:  
Une attaque par déni de service (ou attaque par saturation ; en anglais, Denial of Service attack ou DoS attack) est une attaque sur un serveur informatique consistant envoyer une grande quantité de requête à celui-ci pour le saturer. Une fois saturé il ne peut plus fournir de service aux clients réguliers..  

|DDOS|
|:-:|
|![schema](https://exploitszone.com/wp-content/uploads/2020/06/ddos-attack.png)|

*Ressources Web:*
- [Page Wikipedia](https://fr.wikipedia.org/wiki/Attaque_par_d%C3%A9ni_de_service)
- [Securiteinfo](https://www.securiteinfo.com/attaques/hacking/ddos.shtml)
- [Cisco](https://www.cisco.com/c/fr_fr/products/security/what-is-a-ddos-attack.html)
- [Zdnet](https://www.zdnet.fr/pratique/qu-est-ce-qu-une-attaque-ddos-tout-savoir-pour-les-reconna-tre-et-s-en-proteger-39911475.htm)
- [Ionos](https://www.ionos.fr/digitalguide/serveur/know-how/quest-ce-que-le-dos-denial-of-service/)

* Fondamental:DNSSEC  
DNSSEC permet de sécuriser les données envoyées par le DNS. Contrairement à d'autres protocoles comme SSL, il ne sécurise pas juste un canal de communication mais il protège les données, les enregistrements DNS, de bout en bout. Ainsi, il est efficace même lorsqu'un serveur intermédiaire trahit.  
DNSSEC signe cryptographiquement les enregistrements DNS et met cette signature dans le DNS. Ainsi, un client DNS méfiant peut récupérer la signature et, s'il possède la clé du serveur, vérifier que les données sont correctes. La clé peut être récupérée via le DNS lui-même (ce qui pose un problème d'œuf et de poule) ou bien par un autre moyen (diffusée via le Web et signée avec PGP par exemple).  
DNSSEC permet de déléguer des signatures : ainsi, le registre d'un domaine de premier niveau peut annoncer que tel sous-domaine est signé. On peut ainsi bâtir une chaîne de confiance depuis la racine du DNS.  
DNSSEC introduit aussi ses propres problèmes, par exemple, le fait qu'un enregistrement spécial (NSEC) indique le prochain domaine de la zone permet d'énumérer le contenu complet d'une zone signée, même si le transfert de zone n'est pas permis. Ce problème fait que la plupart des TLD utilisent l'enregistrement NSEC3, qui n'a pas ce défaut.  

|DNSSEC|
|:-:|
|![schema](https://github.com/cromm24/Hello_World/blob/main/AT2/AT2C1/DNS/dnssec_dns.png?raw=true)|
|![schema](https://www.efficientip.com/wp-content/uploads/2020/01/chain-of-trust-part1.svg)|

Ressources Web:
- [ICANN](https://www.icann.org/resources/pages/dnssec-what-is-it-why-important-2019-03-20-fr)

## Conclusion

Le Système de Nom de Domaine est un système distribué, hiérarchisé, robuste et pouvant être sécurisé qui à fait ses preuves.  
Il constitue maintenant **l'épine dorsale d'internet et des réseaux**.  
Beaucoup de services réseaux repose sur ce système et ne peuvent fonctionner sans le DNS (Serveur Mail, Serveur Ldap...)  
Il facilite aussi beaucoup la vie des internautes qui préfère retenir www.google.fr 209.85.229.147, ils ne pourrait plus s'en passer. Les utilisateurs préfère d'ailleurs les noms en toute lettres au chiffre. Tout le monde fait sont propre « DNS » avec ses contact dans son téléphone portable.  

## Le protocole DNS en Video par S.Bortzmeyer

*Le protocole DNS est un des protocoles fondamentaux du web*  

Voici une video de deux heures explicatives dirigé par:  
|[Stéphane Bortzmeyer](https://www.bortzmeyer.org/)|
|:-:| 
![](https://upload.wikimedia.org/wikipedia/commons/5/53/Pas_Sage_en_Seine_-_Day_3_%28cropped%29.jpg)|  
|La conférence, 1h20 -> [**La Vidéo**](https://youtu.be/QHVK666TFUI)|  
|Les  questions réponses, 40 min -> [**La vidéo**](https://youtu.be/FPdefF34YK0) | 
|Les réponses Techniques, 25 min -> [**La vidéo**](https://youtu.be/KFHZL6bxsUo)|  
|Une autre Vidéo sur la sécurité de 2h45 -> [**La vidéo**](https://youtu.be/wg45iVWuEKE)|
|Article et Vidéo de Stephane Bortzmeyer sur DOH: [**ICI**](https://www.nextinpact.com/news/108783-dns-over-https-pour-stephane-bortzmeyer-diable-est-dans-details.htm)|  
|Bonus: Cours du [**CNAM**](https://campus.cefim.eu/pluginfile.php/54683/mod_page/content/6/cours-dns-cnam-SHOW.pdf)|    

**Quelques notes:**  
- A quoi ca sert ?  
  - Stabilité des noms (par rapport aux addressesIP)
  - Noms plus jolies que les adresses
- Vocabulaire important:
  - **Serveur faisant autorité:** 
    - serveur DNS qui connait le contenu d'un domaine. Exemple: les serveurs de l'AFNIC qui connaissent ce qu'il y a quand *.fr* et peuvent répondre. Ou les serveurs de *lacantine.org* (chez Bearstech).  
  - **Résolveur ou serveur récursif:** 
    - serveur DNS qui ne connait rien mais pose des questions aux serveurs faisant autorité et mémorise les réponses. Chez les FAI, ou sur le réseau local ou chez Google.  
  - **Sécurité:**
    - Exposé dà la journéé du Conseil Scientifique de l'AFNIC  
    - Risque autour de l'enregistrement (détournement, saisie, justice privée)  
    - Risques techniques de panne (assurer la résilience)  
    - Risques techniques de sécurité (attaques par empoisonnement). Déploiement de DNSSEC.  
  - **Empoisonnement:**  
    - Réponse envoyée par le méchant avant celle du serveur faisant autorité. Peut être acceptée dans certains cas.  
  - **DNSSEC:**
    1. Signature Cryptographique des enregistrements.  
    2. Permettant de vérifier leur authenticité.  
    3. Mais attention ! Cela nécessite une administration DNS bien plus rigoureuse. Une montée en compétence comme disent les RHs...
    4. En cours de déploiement.  
  - **Organisations et pouvoir: Processus mous:**  
    - Gouvernement des Etats-Unis (à mis la mains sur la racine en 1998)
    - ICANN (Déléguation du précedent)
    - Registre de TLD (Verisign, AFNIC, Afilias, etc...), et BE
    - Opérateurs de résolveurs ( Menteur de certains FAI, blocage de pub google par free (freebox))
    - Auteur de logiciels (permettent DNSSEC ou pas)  
  - **Alternatives:** (ou compromis différents)
    - Identificateurs fondés sur le contenur comme les magnets de BitTorrent  
    - Identificateurs fondés sur la cryptographie comme ceux de BitMessage  

## Ressources Générales

- [Neptunet : DNS](https://neptunet.fr/category/systeme/roles-et-services/dns/)
- [Neptunet : mise en pratique](https://neptunet.fr/dns-cache-windows/)
- [FrameIP](https://www.frameip.com/dns/)
- [Cisco](https://cisco.goffinet.org/ccna/services-infrastructure/protocole-resolution-noms-dns/)
- [Wikipedia](https://fr.wikipedia.org/wiki/Domain_Name_System)
- [OpenClassroom DNS](https://openclassrooms.com/fr/courses/857447-apprenez-le-fonctionnement-des-reseaux-tcp-ip/857163-le-service-dns)
- [Dernière RFC de 2019](https://datatracker.ietf.org/doc/html/rfc8499)
- [It-connect](https://www.it-connect.fr/chapitres/dns-presentation-et-definitions/)
- [Cloudflare](https://www.cloudflare.com/fr-fr/learning/dns/what-is-dns/)

## Exercice

Introduction aux DNS via le questionnaire [TSSR Corrigé](https://docs.google.com/document/d/1ZSy_dOYGScy3gDfcS09Zbo3ArixWlrfoNBL3iTwZEBM/edit?usp=sharing)

Liste des Questions et des Opérations à consigner (captures d'écran, liens, preuves):



1. Créer et remplir un tableau de 14 lignes et de 6 colonnes (Lettre Root, Nom entité, description entité, IPv4, IPv6, nb d'instance) . Ce tableau sera très utile pour window server et Bind9  
  
  |Lettre Root|Nom entité|Description entité|	IPV4|	IPV6|	Nb d'instance|  
  |:-:|:-:|:-:|:-:|:-:|:-:|    
  |A|	Verisign, Inc|	Entreprise privée, USA 1998|	198.41.0.4|	2001:503:ba3e::2:30|	16|  
  |B|	Information Science Institute|	Département Université de Caroline du Sud, USA, 1977|	199.09.14.201|	2001:500:200::b|	6|  
  |C|	Cogent Communications|	Multinationale, USA, 1999|	192.33.4.12|	2001:500:2::c|	12|
  |D|	University of Maryland|	Université du Maryland, USA|	199.7.91.13| 2001:500:2d::d|	162|
  |E|	NASA Ames Research Center| 	Agence gouvernementale (NASA), USA|	192.203.230.10|	2001:500:a8::e|	254|
  |F|	Internet Systems Consortium, Inc|	Société à but non lucratif, USA, 1994|	192.5.5.241|	2001:500:2f::f|	249|
  |G|	Defense Information Systems Agency|	Agence gouvernementale (Defense), USA, 1991|	192.112.36.4|	2001:500:12::d0d|	6|
  |H| U.S. Army Research Lab|	Agence gouvernementale (US Army), USA, 1992|	198.97.190.53|	2001:500:1::53|	8|
  |I|	Netnod|	Société à but non lucratif, Suède, 1996|	192.36.148.17|	2001:7fe::53|	68|
  |J|	Versign, Inc|	Entreprise privée, USA 1998|	192.58.128.30|	2001:503:c27::2:30|	118|
  |K|	RIPE NCC|	Organistaion privée de droit néerlandais, Pyas-Bas, 1992|	193.0.14.129|	2001:7fd::1|	75|
  |L|	ICANN|	Société de droit californien à but non lucratif, USA, 1998|	199.7.83.42|	2001:500:9f::42|	191|
  |M|	WIDE Project|	Projet de l'université de Kéio, Japon, 1985|	202.12.27.33|	2001:dc3::35|	6|  

2. Capturer une requête DNS dans Wireshark entre votre client et un serveur OPENDNS, montrer dans la capture la réponse du serveur UDP à votre requête sur www.republiquedesmangues.fr  
 - Ouvrir Wireshark
 - Lancer une capture sur la bonne borne réseau
 - Appliquer un filtre DNS
 - Lancer sur une recherche du site ci-dessus sur un navigateur
 - Retourner sur Wireshark et lire le résultat
![](https://github.com/cromm24/Hello_World/blob/main/AT2/AT2C1/DNS/requetedns_mangues.png?raw=true)  

3. Capturer une requête DNS dans Wireshark en TCP
  - [Sourcedaddy](https://www.sourcedaddy.com/windows-7/using-tcp-for-dns-lookups.html#:~:text=Using%20TCP%20for%20DNS%20Lookups%20When%20a%20DNS,deliver%20all%20the%20DNS%20records%20in%20the%20response)  
  - Ouvrir Wireshark
  - Lancer une capture sur la bonne borne réseau
  - Appliquer un filtre DNS
  - Ouvrir un invite de commande et taper la commande suivante:
      > nslookup "-set vc" totosandbox.net
  - Retourner dans Wireshark et lire la trame

![](https://github.com/cromm24/Hello_World/blob/main/AT2/AT2C1/DNS/requetedns_tcp.png?raw=true)

4. Vider votre cache et Capturer votre cache DNS dans un fichier Texte, le traffic Google pour faire une recherche Linkedin, vous identifier dedans et isoler dans ce fichier seulement les FQDN. 
  - Vider le cache DNS avec la commande
    > ipconfig/flushdns 
  - Lancer une recherche linkedin sur votre navigateur préféré
  - Commande pour récuperer les données d'un display dans un fichier txt:
    > ipconfig/displaydns>rapport.txt  

![](https://github.com/cromm24/Hello_World/blob/main/AT2/AT2C1/DNS/rapport_linkedin.png?raw=true)

5. Faire un DIG (donc sur Linux) simple en A sur le nom de domaine du site https://hooooooooo.com/  
  [Utilisation de DIG](https://www.hostinger.fr/tutoriels/comment-utiliser-la-commande-dig-sous-linux)
  > dig hooooooooo.com/ +short  

![](https://github.com/cromm24/Hello_World/blob/main/AT2/AT2C1/DNS/dig%20hoooooooo.png?raw=true)

6. Faire un DIG plus complet sur Elysee.fr
  > dig elysee.fr +noall +answer  

![](https://github.com/cromm24/Hello_World/blob/main/AT2/AT2C1/DNS/dig_elysee.png?raw=true)   

1. Quel est le nom FQDN du cluster d'hébergement de objectif2038.net?

![](https://github.com/cromm24/Hello_World/blob/main/AT2/AT2C1/DNS/fqdn_objectif2038.png?raw=true)
Le FDQN est cluster010.hosting.ovh.net

8. Quel est le CNAME de www.objectif2038.net?  

Le CNAME est objectif2038.net  
![](https://github.com/cromm24/Hello_World/blob/main/AT2/AT2C1/DNS/cname_objectif2038.png?raw=true)  

9. Quel est le nom du serveur prioritaire MX pour le domaine ID37.fr (Dans un MX le serveur prioritaire est il 1 ou 99?)  

id37.fr MX preference = 1, mail exchanger = aspmx.l.google.com

![](https://github.com/cromm24/Hello_World/blob/main/AT2/AT2C1/DNS/dns_mx_id37.png?raw=true)

Le serveur prioritaire est 1, le nombre inférieur a toujours la plus grande priorité.  

10.  Quelle est la clé MS dans le record TXT pour le passage à Office365 du domaine cefim.ninja?  

![](https://github.com/cromm24/Hello_World/blob/main/AT2/AT2C1/DNS/ms_recordtxt.png?raw=true)  

11. Quel est l'email de contact pour le domaine cant-not-tweet-this.com?  
    
![](https://github.com/cromm24/Hello_World/blob/main/AT2/AT2C1/DNS/contact_site.png?raw=true)  

12. Quelles sont les coordonnées LAT,LON de l'instance root-servers la plus septentrionale?  
  - https://root-servers.org/
  - Nuuk, Groenland, Latitude : 64.175029 | Longitude : -51.735539
  - nslookup
  - set mode=loc
  - IPv4 : 193.0.14.129

13. Trouver un record TXT "fun" via une recherche genre https://medium.com/@fabianbeiner/fun-with-txt-records-3752fa5680a4  

![](https://github.com/cromm24/Hello_World/blob/main/AT2/AT2C1/DNS/dig_fun.png?raw=true)  

14.  Combien coûte l'enregistrement de tinytuba.tours sur Gandi?  
  - 59.60€ par ans  

15. Quand le domaine thatsthefinger.com sera t'il disponible?  
    
![](https://github.com/cromm24/Hello_World/blob/main/AT2/AT2C1/DNS/whois_thatsthefinger.png?raw=true)
  
16.  Chez quel hébergeur est le site de la mairie de Montcuq?

![](https://github.com/cromm24/Hello_World/blob/main/AT2/AT2C1/DNS/montcul.jpg?raw=true)

17.  Capturer un geotrace IP pour le domaine fallingfalling.com  
    
![](https://github.com/cromm24/Hello_World/blob/main/AT2/AT2C1/DNS/tracert_falling.png?raw=true)

18.  Lister les IP et les FQDN des routeurs rencontrés entre vous et Amazon japon  
  - tracert amazon.co.jp
  
![](https://github.com/cromm24/Hello_World/blob/main/AT2/AT2C1/DNS/tracert_amazonjp.png?raw=true)

19.   Trouver la liste des Servers DNS publics en Antarctique
  - https://public-dns.info/
  - https://public-dns.info/nameserver/aq.html

![](https://github.com/cromm24/Hello_World/blob/main/AT2/AT2C1/DNS/dns_antartic.jpg?raw=true)

20.    Quel est la législation du TLD pour Macao?  
  - [Page wikipedia TLD_pays](https://en.wikipedia.org/wiki/Country_code_top-level_domain#Lists)
  - extension : *.mo*
  - Les titulaires doivent avoir une entreprise enregistrée à Macao, avec le même nom que le domaine qu'ils souhaitent enregistrer.  
  
21.   Combien y a t-il de sites en Corée du nord?  
    - [Page wikipedia .kp](https://en.wikipedia.org/wiki/.kp)  
    - A moins 9 domaines de premier niveau .kp et plus de 30 domaines sont accessibles sur l'Internet mondial  

22.   Synthétiser en 10 lignes la story de sex.com  
  - https://en.wikipedia.org/wiki/Sex.com  
  - En mai 1994, Gary Kremen a enregistré *sex.com* auprès de Network Solutions, sans le développer. L'année suivante, ladite société a transféré, sans autorisation, le domaine à Stephen M. Cohen, celui-ci ayant soumis un faux fax pour arriver à cette fin. Dans la foulée, Cohen a utilisé l'allocation évocation du nom de domaine/publicité pour engranger beaucoup d'argent. S'en est suivi une bataille juridique entre Cohen et Kremen sur fond de l'infrastructure d'enregistrement des noms de domaine. Kremen a remporté la victoire en novembre 2000, lorsqu'il a été ordonné à Network Solutions de rendre le domaine au plaignant et à Cohen un remboursement de plusieurs dizaines de millions d'euros.  

23.  Quel est le BE pour potamochère.fr  
  - WHOIS
  - [Site de l'AFNIC pour trouver le BE](https://www.afnic.fr/noms-de-domaine/tout-savoir/annuaire-bureaux-enregistrement/)
  - Bureau d'enregistrement : GANDI  

24.  Combien y a t il de nom de domaines fr enregistrés?  
     - Site de l'[AFNIC](https://www.afnic.fr/observatoire-ressources/statistiques/)
![](https://www.afnic.fr/wp-media/ftp/stats/Dashboard_desktop.png)

25. Obtenir la liste des Registrars pour l'AFNIC  
  - [Liste des bureaux d'enregistrements](https://www.afnic.fr/noms-de-domaine/tout-savoir/annuaire-bureaux-enregistrement/)  
  - Il y en a 382
  
26. Qui est le CEO fondateur gerant le TLD .sexy?  
  - Société [Uniregistry](https://en.wikipedia.org/wiki/Uniregistry)
  - CEO : Frank Schilling

27. Quel est le pourcentage de  volume des Requêtes TCP(V4 et V6) par rapport aux UDP pour le premier server racine de Verisign le 25 décembre 2018?  
  - https://root-servers.org/
  - A, Verisign
  - Statistics
  - [Archives 2018](https://a.root-servers.org/raw-data/index.html)
  - [Volume Traffic 25/12/2018](https://a.  root-servers.org/raw-data/index.html)

  - UDP = 4374249647 (ipv4) + 743326738 (ipv6) = 5 117 576 385
  - TCP = 126256701 (ipv4) + 33257206 (ipv6) = 159 513 907
  - 25/12/2018 : 5 277 090 292 requêtes, dont 97% en UDP et 3% en TCP  
  
28. Quel est le numéro de série du serveur qui gère eelslap.com?  

- http://www.whois-raynette.fr/whois/eelslap.com
- ns1.mediatemple.net

![*](https://github.com/cromm24/Hello_World/blob/main/AT2/AT2C1/DNS/id_server.jpg?raw=true)

- Serial number server : 2020070101   

29.  A qui appartient la plage d'IP du domaine endless.horse?  

  - [Page Wikipedia TLD](https://en.wikipedia.org/wiki/List_of_Internet_top-level_domains#H)
  - Société : [Minds + Machines](https://mmx.co/)
  - DigitalOcean est la société qui possède la plage Ip  

30. Tester et faire des captures d'utilisation des soft de cet article : https://www.cnetfrance.fr/news/trois-logiciels-pour-optimiser-les-dns-vos-mises-a-jour-hebdo-39785896.htm  

*DNS Jumper*

- [Lien de téléchargement](https://www.cnetfrance.fr/telecharger/dns-jumper-39958521s.htm)

![*](https://github.com/cromm24/Hello_World/blob/main/AT2/AT2C1/DNS/dnsjumper.png?raw=true)

*NameBench*

- [Lien de téléchargement](https://www.cnetfrance.fr/telecharger/namehelp-40337377s.htm)

![](https://github.com/cromm24/Hello_World/blob/main/AT2/AT2C1/DNS/namebench1.png?raw=true)
![](https://github.com/cromm24/Hello_World/blob/main/AT2/AT2C1/DNS/namebench2.png?raw=true)
![](https://github.com/cromm24/Hello_World/blob/main/AT2/AT2C1/DNS/namebench3.png?raw=true)
![](https://github.com/cromm24/Hello_World/blob/main/AT2/AT2C1/DNS/namebench4.png?raw=true)


*NameHelp*
- [Lien de téléchargement](https://fr.freedownloadmanager.org/Windows-PC/Namehelp-GRATUIT.html)
- http://localhost:53533/#dashboard  

Si vous avez fini et qu'il reste du temps vous pouvez lire les articles du 25 et 27 février 2019 sur le [blog](https://www.bortzmeyer.org

## Mise en Oeuvre sous Windows Server  


CACHE.DNS
https://www.internic.net/domain/named.root 
