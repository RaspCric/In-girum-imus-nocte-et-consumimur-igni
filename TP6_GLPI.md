
![*](https://media-exp1.licdn.com/dms/image/C4D0BAQEJIrLeIu3hgg/company-logo_200_200/0/1568885231849?e=2159024400&v=beta&t=VmG6ouGc0bZv7vXQLokouf_RUEIRI32PnPfz92LVwa4)


# Nouvelle Partie : solution ITIL via GLPI

 ITIL (pour « Information Technology Infrastructure Library », ou « Bibliothèque pour l'infrastructure des technologies de l'information » en français) est un ensemble d'ouvrages recensant les bonnes pratiques (« best practices ») du management du système d'information. Rédigée à l'origine par des experts de l'Office public britannique du Commerce (OGC), ITIL a fait intervenir à partir de sa version 3 des experts issus de plusieurs entreprises de services telles qu'Accenture, Ernst & Young, Hewlett-Packard, Deloitte, BearingPoint, CGI ou PriceWaterhouseCoopers.

C'est un référentiel méthodologique très large qui aborde les sujets suivants :

* Comment organiser un système d'information ?
* Comment améliorer l'efficacité du système d'information ?
* Comment réduire les risques ?
* Comment augmenter la qualité des services informatiques ?

ITIL permet, grâce à une approche par processus clairement définie et contrôlée, d'améliorer la qualité des SI et de l'assistance aux utilisateurs en créant notamment la fonction (au sens « département de l'entreprise ») de Centre de services ou « Service Desk » (extension du « help desk ») qui centralise et administre l'ensemble de la gestion des systèmes d'informations. ITIL est finalement une sorte de « règlement intérieur » du département informatique des entreprises qui l'adoptent.

Les bénéfices pour l'entreprise sont une meilleure traçabilité de l'ensemble des actions du département informatique. Ce suivi amélioré permet d'optimiser en permanence les processus des services pour atteindre un niveau de qualité maximum de satisfaction des clients. 


## **Contexte(s) professionnel(s) de mise en oeuvre**

* <span style="color: #9E1F44">Cette compétence est mise en oeuvre dans un centre de services conformément aux règles de bonnes pratiques de la démarche ITIL (Information Technology Infrastructure Library)</span>
* <span style="color: #9E1F44">La mise en oeuvre de cette compétence s'appuie généralement sur un outil de gestion d'assistance</span>
* <span style="color: #9E1F44">Le technicien intervient à distance ou se déplace auprès de l'utilisateur</span> 
* <span style="color: #9E1F44">Le technicien intervient en temps limité et en respectant des procédures</span> 

## **Savoir-faire techniques, savoir-faire organisationnels, savoir-faire relationnels, savoirs**

* <span style="color: #9E1F44">Utiliser un outil de gestion d’incidents</span> 
* <span style="color: #9E1F44">Traiter un dossier d'incident</span> 
* <span style="color: #9E1F44">Appliquer un script de questionnement ou une méthode d'analyse en résolution d'incident</span> 
* <span style="color: #9E1F44">Réaliser des opérations de maintenance par l'intermédiaire d'un outil de prise de contrôle à distance</span> 
* <span style="color: #9E1F44">Utiliser et renseigner une base de connaissances</span> 
* <span style="color: #9E1F44">Gérer les problèmes</span> 
* <span style="color: #9E1F44">Communiquer à l'oral avec un niveau de langage et un vocabulaire adaptés à l'utilisateur</span> 
* <span style="color: #9E1F44">Maîtriser sa communication en situation de crise</span> 
* <span style="color: #9E1F44">Rédiger des comptes rendus d’intervention clairs, concis et correctement orthographiés</span> 
* <span style="color: #9E1F44">Connaissance des processus de gestion des incidents et de gestion des problèmes au sens ITIL</span> 

## **Organisation de la séquence :**

1. <span style="color: #0055ff">Monter un GLPI</span>
2. <span style="color: #0055ff">Exploitation GLPI</span>
<br/>
Cette partie permettra en outre de développer des outils afférents à l'administration Linux.

* Derrière votre BOX qui distribue du DHCP
* Une LAMPS sous Deb10 doit héberger la solution
* LE GLPI est installé à postériori sur votre LAMPS
* Un accès NAT sur l'interface web de ce GLPI doit être possible et si possible via un nom de domaine
* Un GLPI on-cloud général sera monté en plus sur AWS pour tout le monde : https://glpi.cefim.ninja
* Un AD local sera configuré
* Un import de 100 Users sera déposé dans l'AD via powershell
* Ces 100 users seront injecté dans le GLPI
* Une phase de "label" sera crée en préambule de l'exploitation des données
* L'inventaire de votre Host Win10 sera déposé via agent automatique dans le GLPI
* L'inventaire de l'AD également
* Une base FAQ & KB en exploitation
* Workflow de tickets d'incidents
* Gestion par binôme et dans le GLPI général des tickets
* Dashboard

![Schéma de l'Infra demandée](https://github.com/RaspCric/TSSR_Formation/blob/images/Capture%20d%25u2019e%CC%81cran%202021-06-24%20a%CC%80%2009.05.36.png)

![Schéma refait via ordi](https://github.com/RaspCric/TSSR_Formation/blob/images/SCHEMA_INFRA_GLPI.jpg)

---

# Table des matières

1. [Conception et installation d'une baseline Debian10](#I)
    1. [Installation d'un Derbian 10 vierge](#IA)
    2. [Configuration de la baseline server](#IB)
        1. [Vérification des informations systeme](#IB1)
        2. [Mises à jour](#IB2)
        3. [Changement interface root](#IB3)
        4. [Installation softs/binaires](#IB4)
        5. [Installation webmin](#IB5)
        6. [Modifications /etc](#IB6)
    
2. [Installation et mise en marche de GLPI sur notre Debian](#II)
    1. [Installation d'un GLPI local sur VM](#IIA)
        1. [Base de Données MariaDB](#IIA1)
        2. [Serveur Apache](#IIA2)
        3. [Installation de l'outil GLPI](#IIA3)
    2. [Vérification des infos réseaux](#IIB)
    3. [Préparation du GLPI local pour un accès réseau](#IIC)
        1. [Translation NAT](#IIC1)
        2. [Personalisation du GLPI](#IIC2)
    4. [Mise en place d'un GLPI commun](#IID)
        1. [Configuration du cloud amazon : AWS](#IID1)
        2. [Configuration d'une clef SSH](#IID1bis)
        2. [Configuration d'apache 2](#IID2)
        3. [Création d'un certifical ssl](#IID3)
        4. [Installation GLPI sur le serveur cloud](#IID4)

3. [Montage d'un Windows Serveur 2019](#III)
    1. [Préparation d'une baseline WServeur 2019](#IIIA)
    2. [Montage d'Active Directory](#IIIB)
        1. [Installation de l'AD](#IIIB1)
        2. [Ajout d'un OU](#IIIB2)
        3. [Génération d'une base d'users](#IIIB3)
        4. [Mise en place d'une GPO pour autoriser les mdp faibles](#IIIB4)
        5. [Générer les users créés dans l'AD via script shell](#IIIB5)

4. [Mise en lien d’Active Directory et notre GLPI](#IV)
    1. [Gestion des différents DNS](#IVA)
        1. [Modifications du DNS sur le WServer](#IVA1)
        2. [Modifications du DNS de réponse sur le serveur GLPI via VM Debian](#IVA2)
    2. [Import des users via un annuaire LDAP sur l'interface GLPI](#IVB)
    3. [Configurer les intitulés](#IVC)
    4. [Gestion générale de GLPI : les plugins](#IVD)
    5. [Gestion générale de GLPI : mise en pratique via FusionIventory](#IVE)
    6. [Gestion générale de GLPI : tickets](#IVF)
    7. [Gestion générale de GLPI : tickets et création d'un Helpdesk dans le cloud](#IVG)

5. [Annexe : lexique](#lexique)



---


## **I. Conception et installation d'une baseline Debian10** <a name="I"></a>

La préparation d'une baseline permettra d'avoir un outil master que l'on pourra utiliser en mode clonage  ; il s'agit donc de faire une install la plus propre et la plus à la carte possible

**Ressources web :**
1. [Site officiel Debian](https://www.debian.org/index.fr.html)
2. [Tutoriel install Debian 10 via it-connect.fr](https://www.it-connect.fr/installation-debian-10-buster-pas-a-pas/)
3. [Tutoriel install Debian 10 via lecrabeinfo.net](https://lecrabeinfo.net/installer-linux-debian-le-guide-complet.html)
4. [Tutoriel install Debian 10 via malekal.com](https://www.malekal.com/installer-linux-debian/)
5. [Tutoriel install Debian 10 minimal server](https://www.howtoforge.com/tutorial/debian-minimal-server/)

### A) Installation d'un Derbian 10 vierge <a name="IA"></a>

* PowerUser (mode Custom)
* Moteur 16x, 2Gb de RAM, Bridge, HDD16Go
* Nom: changeme (ce nom doit être unique et pertinant, d'autant qu'il est voué à être changé)
* Domaine : tssr.lan
* Lancement debian10.7
* MdP root = dadfba16 (pas de stratégie spécifique car l'admin doit etre responsable)
* User = user, mdp=dadfba16

Miroir sur le réseau : Sert à allez en ligne (sur un dépot débian.org) pour installer les différents paquets qui composeront notre serveur linux. Donc  OUI !  (proche de nous de préf donc France)

* pas d'interface graphique 
* pas de serveur d'impression
* pas de SSH
* pas serveur web

Séléctions des logiciels : décocher tout sauf les utilitaires usuels du système. Pas besoin du reste, on est des POWER USER ! On fait tout nous-même en ligne de commande.

Grub : Oui il faut l'installer sinon notre linux sera comme les singes de la vertu.   


### B) Configuration de la baseline server <a name="IB"></a>

- Configuration de notre Baseline Server en mode CLI via le compte **root** :
- La VM doit être mise en IP fixe pour pouvoir être approchée

![IPA](https://github.com/RaspCric/TSSR_Formation/blob/images/ipa.jpg)

#### --- Vérification des informations --- <a name="IB1"></a>

> `ip a`<br/>
-> permet de connaître les infos réseaux de la VM <br/>
-> 192.168.0.32/24 dynamic

> `ping 1.1.1.1 + www.google.fr`<br/>
-> s'assurer que le poste ping une IP <br/>
-> vérification de la connexion réseau via appel DNS

> `pwd ou whoami`<br/>
-> qui on est (root)

> `ls -la`<br/>
-> liste tous les éléments de l'endroit)

> `/etc/apt/sources.list`<br/>
-> tous les dépôts où le debian va chercher les dl <br/>
-> need vérifier que les dépôts sont ok

![Checks des sources](https://github.com/RaspCric/TSSR_Formation/blob/images/sourceslist.jpg)

#### -- Mises à jour du système --- <a name="IB2"></a>

> `apt update`<br/>
-> contacte le dépot officiel et vérifie que le catalogue est à jour

> `apt ugrade`<br/>
-> met à jour les paquets

#### --- Changement interface root --- <a name="IB3"></a>

Il s'agit d'éditer le fichier de préférence du shell via nano afin d'avoir une config visuelle efficiente pour travailler dessus en ssh via une configuration du profile bash du compte root

> `nano /.bashrc`<br/>
-> change config du terminal ; on décohe les # dans la seconde partie, les 5 lignes commencent par export et juste avant les RM, (export, eval, alias ls, alias ll; alias l))<br/>

![Fichier .bashrc](https://github.com/RaspCric/TSSR_Formation/blob/images/bashrc.png)

> `exit`<br/>
-> pour redémarrer session en ligne de commande

#### --- Installation softs/binaires --- <a name="IB4"></a>

On utilise la machine hôte pour lancer une console en mode SSL

> `ssh user@192.168.0.32 + su`<br/>
->  prise en main du poste à partir du terminal windows distant en compte user limité

On se met à la racine /root

> `su -` <br/>
-> On passe en superadmin <br/>
> `apt install ssh`<br/>
-> Installation du service ssh <br/>
-> `man + ssh/...`<br/>
-> manuel/aide

On lance l'installation des binaires :

> `apt install nmap(info ip) zip(compression/decompression) lynx(navigateur) curl(recupérer et tester url) net-tools(outils réseaux) dnsutils bsdgames`<br/>

> `apt install winbind(linux pourra manipuler des netbios) samba(partage windows)`<br/>
-> installation de la couche netbios (permet de dialoguer avec winsows)

Pour vérifier les softs installés :
> `dpkg -l`

![Liste des softs](https://github.com/RaspCric/TSSR_Formation/blob/images/dpkg-l.jpg)

#### --- Installation Webmin --- <a name="IB5"></a>

* [Site officiel de Webmin](https://www.webmin.com/)
* [Lien wikipedia](https://fr.wikipedia.org/wiki/Webmin)

> `wget http://prdownloads.sourceforge.net/webadmin/webmin_1.979_all.deb (wget=dl via le net)`<br/>
1. Faire un clic droit sur le Debian Packiage dans la frame de gauche en haut et récupérer dans le presse papier l'adresse du paquet du genre

> ``su -`` <br/>
2. On prend l'option root pour pouvoir passer outre le blocage
-> su + privilèges d'environnement pour installer le .db dl

> `dpkg -i nomdudeb (va installer le paquet)`<br/>
3. Lancement de l'installaion

> `apt -f install (force install en récup tous les paquets liés)`<br/>
4. L'installation bloque car il manque 4 paquets (des bibliothèques Perl) mais le programme APT sait les bibliothèques manquantes, donc on termine l'installation

<br/>

![Webmin](https://github.com/RaspCric/TSSR_Formation/blob/images/webmin.jpg)

[https://ipvm:10000](https://192.168.0.32:10000/) (pour use webmin)
-> il ne reste plus qu'à se connecter via le navigateur de votre hôte win10 sur votre serveur en mode web

#### --- Modifications /etc --- <a name="IB6"></a>

> `/etc/hostname`<br/>
-> nom de la machine

> `cat /etc/resolv.conf`<br/>
-> résolveur DNS<br/>
-> Vérifier et changer le serveur **DNS** préféré ici le cas échéant
-> modifier : domain tssr.lan / search tssr.lan / nameserver 1.1.1.1

> `/etc/nsswitch.conf`<br/>
-> on rajoute wins après dns

![/ect](https://github.com/RaspCric/TSSR_Formation/blob/images/etc.jpg)

> `/etc/network/interfaces`<br/>
-> Mise en réseau du poste <br/>
-> se mettre en ip fixe <br/>
-> static (remplace dhcp par static) <br/>
-> address 192.168.0.32 <br/>
-> netmask 255.255.255.0 <br/>
-> gateway 192.168.0.1 (passerelle par défaut, c'est le modem/routeur)

![Interfaces](https://github.com/RaspCric/TSSR_Formation/blob/images/interfaces.jpg)

---

## **II. Installation et mise en marche de GLPI** <a name="II"></a>

1. [Site officiel de GLPI](https://glpi-project.org/fr/)
2. [Page Wikipedia](https://fr.wikipedia.org/wiki/Gestionnaire_Libre_de_Parc_Informatique)
3. [Page OpenCLassroom](https://openclassrooms.com/fr/courses/1730516-gerez-votre-parc-informatique-avec-glpi/5993301-decouvrez-la-gestion-de-parc-avec-glpi)
4. [Projet GLPI sur GitHub](https://github.com/glpi-project/glpi)
5. [Tutoriel installation via le site rdr-it.com](https://rdr-it.com/glpi-installation-configuration-de-base/)
5. [Tutoriel installation Via le site Neptunet (à privilégier)](https://neptunet.fr/install-glpi/)

Il va s'agir d'installer un logiciel libre de gestion des services informatiques (ITSM) et de gestion des services d'assistance (issue tracking system et ServiceDesk). GLPI est une application web qui aide les entreprises à gérer leur système d’information. Parmi ses caractéristiques, cette solution est capable de construire un inventaire de toutes les ressources de la société et de réaliser la gestion des tâches administratives et financières. Les fonctionnalités de cette solution aident les Administrateurs IT à créer une base de données regroupant des ressources techniques et de gestion, ainsi qu’un historique des actions de maintenance. La fonctionnalité de gestion d'assistance ou helpdesk fournit aux utilisateurs un service leur permettant de signaler des incidents ou de créer des demandes basées sur un actif ou non, ceci par la création d'un ticket d’assistance.

### A) Installation du GLPI (webApp) <a name="IIA"></a>

> `apt update && apt upgrade -y`
-> Mise à jour des paquets et installation des nouveautés sur le Système Debian

#### --- Base de Données de GLPI : MariaDB --- <a name="IIA1"></a>

**Ressources web :**
* [MariaDB via Wikipedia](https://fr.wikipedia.org/wiki/MariaDB)
* [Infos MariaDB via doc-fedora](https://doc.fedora-fr.org/wiki/Installation_et_configuration_de_MariaDB)
* [Infos MariaDB](https://www.mariadbtutorial.com/)
* [Infos MariaDB via docs Ubuntu](https://doc.ubuntu-fr.org/mariadb)
* [Tuto MariaDB](https://www.geek17.com/fr/content/debian-10-buster-installer-et-configurer-mariadb-107)

Un système de gestion de base de données (abr. SGBD) est un logiciel système servant à stocker, à manipuler ou gérer, et à partager des données dans une base de données, en garantissant la qualité, la pérennité et la confidentialité des informations, tout en cachant la complexité des opérations.
Un SGBD (en anglais DBMS pour database management system) permet d'inscrire, de retrouver, de modifier, de trier, de transformer ou d'imprimer les informations de la base de données. Il permet d'effectuer des comptes rendus des informations enregistrées et comporte des mécanismes pour assurer la cohérence des informations, éviter des pertes d'informations dues à des pannes, assurer la confidentialité et permettre son utilisation par d'autres logiciels1. Selon le modèle, le SGBD peut comporter une simple interface graphique jusqu'à des langages de programmation sophistiqués1. 

> `apt install apache2 php libapache2-mod-php mariadb-server -y`<br/>
1. Apache2 = serveur ; php (7) = service web ; mariadb = base de données basée sur MSQl

> `apt install php-mysqli php-mbstring php-curl php-gd php-simplexml php-intl php-ldap php-apcu php-xmlrpc php-cas php-zip php-bz2 php-ldap php-imap -y`<br/>
2. outils d'interprétations + bibliothèques (MSQL-Maria, URLS...) = entre apache et MSQl c'est HTTP le lien, et apache renforcé<br/>
-> `php -v` (version de php)<br/>
-> `var/www/html/include` (dossier où se trouve tout le php)

> `mysql_secure_installation`<br/>
3. Distanciation du compte root pour la BDD

> `mysql -u root -p`<br/>
4. Installation de la base de données MariaDB et paramétrage

> `create database db_glpi;`<br/>
5. Création d'une base de donnée du nom de db_glpi

> `grant all privileges on db_glpi.* to`<br/>
> `admindb_glpi@localhost identified by "admin";`<br/>
6. On créé un utilisateur local (localhost) du nom de *admindb_glpi* avec un MDP "*admin*"

> `show database;`<br/>
> `show tables;`<br/>
> `select * from nomdelatable`<br/>
> `select * from user`<br/>
7. Vérification des infos MariaDB : la base de données, les tables... pour pouvoir sélectionner des informations, on utilise la commande *"select "*

> `exit`<br/>
8. Quitter l'interface de configuration de la Base de Données

#### --- Serveur Apache --- <a name="IIA2"></a>

Apache est conçu pour prendre en charge de nombreux modules lui donnant des fonctionnalités supplémentaires : interprétation du langage Perl, PHP, Python et Ruby, serveur proxy, Common Gateway Interface, Server Side Includes, réécriture d'URL, négociation de contenu, protocoles de communication additionnels, etc. Néanmoins, il est à noter que l'existence de nombreux modules Apache complexifie la configuration du serveur web. En effet, les bonnes pratiques recommandent de ne charger que les modules utiles : de nombreuses failles de sécurité affectant uniquement les modules d'Apache sont régulièrement découvertes. 

* [Infos Apache via docs Ubuntu](https://doc.ubuntu-fr.org/apache2)
* [Infos Apache via docs Ubunu2](https://guide.ubuntu-fr.org/server/httpd.html)

> `nano /etc/apache2/sites-available/000-default.conf`<br/>
-> Sous DocumentRoot : <br/>

```

<Directory /var/www/html>
Options Indexes FollowSymLinks
AllowOverride All
Require all granted
</Directory>


```


> `service apache2 restart`<br/>
-> Service Apache relancé pour prendre en compte toutes les modifs

#### --- Installation de l'outil GLPI --- <a name="IIA3"></a>

> `cd /tmp`<br/>
> `wget https://github.com/glpi-project/glpi/releases/download/9.5.5/glpi-9.5.5.tgz`<br/>
> `tar -xvzf glpi-9.5.5.tgz`<br/>
-> On se déplace dans le dossier temporaire à la racine de notre debian et on télécharge le fichier d'installation que l'on lance dans la foulée via la commande "*tar*" (et où *-xvzf* désigne l'ensemble des formats suceptibles d'être décompressés)

> `shopt -s dotglob`

> `rm /var/www/html/index.html`<br/>
->On supprime la page d'accueil du dossier html par défaut

> `cp -r glpi/* /var/www/html/`<br/>
-> On copie l'ensemble des informations contenues dans le dossier /glpi vers le dossier /var/www/html

> `chown -R www-data /var/www/html`<br/>
-> Changement de propriétaire de manière récursive (autorisation pour apache) pour glpi (www-data)

![Tableau de bord GLPI](https://github.com/RaspCric/TSSR_Formation/blob/images/glpi.jpg)

<br/>

Accès GLPI : [http://ipvm](http://192.168.0.32)<br/>
-> Administration possible via service web sur machine hôte ou via SSL<br/>
-> Pour la suite possible installation via interface graphique

### B) Vérification des infos réseaux <a name="IIB"></a>

Pour se faire on utlise de préférene la ligne de commande en mode SSL via la machine hôte

> `nmap 192.168.0.32`<br/>
-> 22/tcp ssh ; 80/tcp http ; 139/tcp netbios-ssn ; 445/tcp microsoft-ds ; 10000/tcp snet-sensor-mgmt<br/>
-> nous donne les informations sur les ports ouverts sur notre machine virtuelle et donc sur notre serveur

> `nmap 127.0.0.1`<br/>
-> 3306/tcp msql<br/>
-> les informations sont les mêmes pour notre réseaun local par défaut avec en plus le port 3306 ouvert pour notre base de données *MariaDB* qui apparait ici sous *msql*

### C) Préparation GLPI <a name="IIC"></a>

#### --- Translation NAT --- <a name="IIC1"></a>

En réseau informatique, on dit qu'un routeur fait du network address translation (NAT) (« traduction d'adresse réseau » ou « translation d'adresse réseau ») lorsqu'il fait correspondre des adresses IP à d'autres adresses IP. En particulier, un cas courant est de permettre à des machines disposant d'adresses privées qui font partie d'un intranet et ne sont ni uniques ni routables à l'échelle d'Internet, de communiquer avec le reste d'Internet en utilisant vers l'extérieur des adresses externes publiques, uniques et routables.
Ainsi, il est possible de faire correspondre une seule adresse externe publique visible sur Internet à toutes les adresses d'un réseau privé, afin de pallier l'épuisement des adresses IPv4.
La fonction NAT dans un routeur de service intégré (ISR) traduit une adresse IP source interne en adresse IP globale.
Ce procédé est très largement utilisé par les box internet (ou modem routeur) des fournisseurs d’accès pour cacher les ordinateurs personnels derrière une seule identification publique. Il est également utilisé de façon similaire dans des réseaux privés virtuels. 

1. D'abord allez sur *monip.org* pour avoir l'IP public pour ensuite la corréler avec une adresse DNS via nom de domaine<br/>
-> 88.138.81.98

2. Il s'agit ensuite de passer par notre fournisseur de domaine pour y ajouter une règle DNS.<br/>
-> gandi.net / Nom de domaine / totosandbox.net / enregistrement DNS / nouveau<br/>
-> *glpiromain@totosandbox.net* (nom)<br/>
-> A (Type) ; 10800 (TTL) ; 88.138.81.98 (IPv4)<br/>
-> cela permet d'associer à notre IP publique un DNS spécifique pour être utilisé dans la barre de recherche du navigateur

![Accès Gandi](https://github.com/RaspCric/TSSR_Formation/blob/images/gandi.jpg)

3. Ensuite on va dans la BOX (192.168.0.1)<br/>
-> Numericable / Réseau / Paramètres avancées /Transfert de ports<br/>
-> GLPI (nom) ; TCP (port 80), IP locale du serveur<br/>
-> On permet ainsi de lier notre IP locale de la VM à notre IP publique via l'ouverture du port TCP

![Accès Box](https://github.com/RaspCric/TSSR_Formation/blob/images/transfertport.jpg)

<br/>

Via une interface web en pingant l'adresse IP publique on tombe sur l'IP local du serveur GLPI (ou via *glpiromain.totosandbox.net*)

#### --- Personalisation du GLPI --- <a name="IIC2"></a>

* Pour ajouter un texte d'accueil :<br/>
- Configiration / général<br/>
-> Mettre un court texte pour qu'on puisse reconnaître le GLPI

* Pour changer l'image ddu logo d'accueil via commande SSH sur la machine hôte<br/>

> `/var/www/html/pics`<br/>
-> Pour changer le logo, clik droit sur le logo GLPI de l'accueil pour trouver le chemin de l'image

> `wget urlimage.png`<br/>
-> Pour télécharger l'image dans le dossier

> `rm nomdufichier` <br/>
-> Pour supprimer le fichier logo_login_glpi.png<br/>
-> possible aussi juste de renommer le premier fichier via la commande "*mv*"

> `mv nom1 nom2`<br/>
-> Pour renommer le fichier image téléchargé 

### D) Mise en place d'un GLPI commun <a name="IID"></a>

Suite à la création d'un GLPI en local, mise en place d'un GLPI commun via le cloud pour un accès partagé. Thomas va l'installer via le compte cloud du CEFIM. 
Pour se faire, il va utiliser AWS qui est le [fournisseur de gestion de serveur/hébergement d'amazon](https://aws.amazon.com/fr/).


#### --- Configuration du cloud Amazon AWS --- <a name="IID1"></a>

1. Dans les champs de navigation d'AWS aller sur l'EC2 qui gère l'ensemnle des serveurs dans le cloud.<br/>
-> Utilisation du WIzard (AMI, type d'instance, configuration instance, stockage, balises ROLE/GLPI, groupe de sécurité pour config les ports/protocoles d'accès, lancement de l'instance, nouvelle paire de clefs pour pouvoir être prise en main à distance via ssh)

2. On vérifie que les informations de temporalités sont bonnes sur le serveur
> `date`<br/>
- Reconfigurer la date si besoin<br/>
> `dkpg-reconfigure tzdata`

#### --- Configuration d'une clef SSH --- <a name="IID1bis"></a>

**Ressources web :**
* [Définition de SSH via doc Ubuntu](https://doc.ubuntu-fr.org/ssh)
* [Informations sur le SSH via Wikipedia](https://fr.wikipedia.org/wiki/Secure_Shell)
* [Tutoriel Git-scm.com sur la création de clés ssh](https://git-scm.com/book/fr/v2/Git-sur-le-serveur-G%C3%A9n%C3%A9ration-des-cl%C3%A9s-publiques-SSH)
* [Tutoriel GitHub quant à créer une clef ssh et la mettre sur github](https://tutos.rezel.net/git/ssh-keys/)

1. Nous allons créer une clef SSH via notre machine hôte afin de sécuriser la liaison avec le serveur<br/>
- On génère une clef publique en ligne de commande<br/>
- On utilise la commande "*chmod 400*" afin de changer les autorisation jusqu'à un certain degré

2. On envoie notre clef ssh au serveur GLPI créé dans le Cloud<br/>
> `ssh -i nomdelaclef.pem admin@support.cefim.ninja`

#### --- Configuration d'apache 2 --- <a name="IID2"></a>

> `cd /etc/apache2`<br/>
-> On se met dans le dossier Apache du serveur GLPI online

> `a2enmod ssl`<br/>
-> activation module ssl pour faire du HTTPS

> `systemctl restart apache2`<br/>
-> On relance le service apache pour qu'il prenne en considération les changements

> `mods-enable# 1`<br/>
-> voir les modes activés dans apache

> `cd sites-enabled/`<br/>
> `a2ssite 000-default`<br/>
-> désactive le site de base<br/>
-> on vire tous les sites par défauts (*rm*) <br/>
-> création d'un seul site : *nano site1.conf* pour tous les ports

> `/var/www/html/index.html`<br/>
-> on supprime le dossier www (`rm -R www`)<br/>
-> En effet, il faut que le site soit créer dans cd /home avec un nouveau User qui serait ici *GLPI*

> `adduser glpi`<br/>
> `cd /home/glpi`<br/>
> `su glpi`<br/>
> `mkdir www`<br/>
> `cd www`<br/>
> `nano index.html`<br/>
-> On créé un nouvel user, on se déplace dans son arborescence, on passe en Admin pour créer un nouveau dossier www dedans et à l'intérieur duquel on créé une page html bidon mais qui servira pour la suite via son affichage simple

#### --- Création d'un certifical ssl --- <a name="IID3"></a>

* [Définition d'un certificat SSL](https://www.globalsign.com/fr/centre-information-ssl/definition-certificat-ssl)
* [Letsencrypt, infos pour le HTTPS](https://letsencrypt.org/fr/getting-started/) <br/>
* [Tutoriel SSL cerbot par memoinfo.fr](https://www.memoinfo.fr/tutoriels-linux/configurer-lets-encrypt-apache/) <br/>
* [Utilisation de cerbot](https://certbot.eff.org/instructions) <br/>
* [Cerbot, II](https://howto.wared.fr/ubuntu-certificats-ssl-tls-certbot/) <br/>
* [Dépôts officiels Github](https://github.com/certbot/certbot) <br/>
* [Doc Ubuntu pour créer un certificat SSL](https://doc.ubuntu-fr.org/tutoriel/comment_creer_un_certificat_ssl)<br/>


Afin de pouvoir passer en SSL et donc de proposer du HTTPS il s'agit de passer par un projet de certificat gratuit pour tout le monde : *cerbot* ; seul bémol, l'enregistrement dure 60 jours et se doit d'être renouvelé régulièrement

> `cd /root`<br/>
> `wget https://del.eff.org/certbot-auto`<br/>
-> On télécharge le script certbot qui est un robot de certification automoatique (78ko)

> `chmod x certibot-auto`<br/>
-> On rend le script executable par n'importe qui afin de pouvoir le lancer sans message d'erreur de droit

> `./ certbot-auto`<br/>
-> Pour executer un script dans un environnement linux **./** devant

On finit par obtenir un certificat et il est alors possible de se rendre sur la page [support.cefim.ninja](https://support.cefim.ninja/) via HTTPS.


#### --- Installation GLPI sur le serveur cloud --- <a name="IID4"></a>

L'idée consistera au téléchargement et à l'installation de GLPI, à la supression de toutes les infos web par défaut afin de créer un USER particulier qui servira d'espace de création dudit GLPI. Là encore, il s'agira de suppmer toutes les infos hmtl de base afin de partir sur une base neutre et sans config de base.

> `cd /home/glpi/www`<br/>
> `rm index.html`<br/>
> `rm /www`<br/>
-> on supprimer le dossier WWW

> `cd /home/glpi`<br/>
> `wget glpi https://github.com/glpi-project/glpi/releases/download/9.5.5/glpi-9.5.5.tgz` <br/>
-> on DL la dernière version de glpi<br/>
-> puis on l'installe

> `mv glpi www`<br/>
-> puis on change le nom de son dossier en WWW

*<br/>
(...)<br/>
*<br/>

- Le GLPI cloud est dispo via le nomdedomaine créé via DNS <br/>
- Ajout d'un utilisateur :
RDelmas_Merlin, Romain Delmas, mdp *romain*

---

## III. Montage d'un Windows Serveur 2019 et mise en lien avec GLPI <a name="III"></a>

* Au moins un domaine controler, mono domaine, mono serveur.  <br/>
* tld : top level domain ( comme . fr; 1er niveau)  <br/>
* FSMO : Flexible Single Master Operation, certains types de contrôleurs de domaine dans Active Directory, de Microsoft. Ce sont ceux qui jouent un rôle nécessitant un maître unique pour la réplication entre contrôleurs de domaine ; certains rôles sont uniques pour tous les domaines de la forêt ; d’autres rôles sont plus simplement uniques à l’intérieur d’un domaine. <br/>
* AD DS : active directory domain service <br/>
* Le niveau fonctionnel de la foret : windowsSer 2019 n'est pas un vrai OS, c'est plus le nom marketing de win ser 16 version 2 donc pas de news, on est sur une base de 2016. 2019 c'est plus une maj.  

**Ressources web :**
- [Qu'est-ce qu'un DNS via WIkipedia](https://fr.wikipedia.org/wiki/Domain_Name_System)
- [Le DNS via le site frameip](https://www.frameip.com/dns/)
- [Controller de domaine et domaine via it-connect](https://www.it-connect.fr/chapitres/controleur-de-domaine-et-domaine/)
- [Rôle de l'herbergement de domaine et DNS via Wikipedia](https://fr.wikipedia.org/wiki/H%C3%A9bergement_de_nom_de_domaine)
- [Explication des 5 rôles FSMO via le site it-connect](https://www.it-connect.fr/chapitres/les-cinq-roles-fsmo/) 
- [Infos Wikipedia sur les TLD](https://fr.wikipedia.org/wiki/Domaine_de_premier_niveau)
- [Lignes de commandes CMD usuelles](https://www.ionos.fr/digitalguide/serveur/know-how/commande-cmd/)

L'idée sera de créer un WServer qui servira de server entre notre GLPI et les usagers via un AD. Pour commencer il faudra donc monter un WServer propre et ensuite paramétrer l'AD pour gérer notre server GLPI. PLus précisément nous allons monter une machine Serveur qui doit s'occuper des noms de Second niveau ; et à un AD correspond non un serveur mais un nom de domaine au moins. Le premier contrôleur de domaine que nous installerons dans la forêt jouera les cinq rôles de la FSMO.  

### A) Préparation d'une baseline WServeur 2019 <a name="IIIA"></a>

* Install de 7zip, Notepad++, SumatraPDF, Chrome via Ninite
* Pare feu en privé avec règle ICMP
* Workgroup : TSSR
* Hostname : DC1
* IP FIXE en IPv4
* IPv6 désactivée sur la carte ethernet0
* Configuration de sécurité renforcée désactivée pour IE
* Bureau à distance activé
* Mise à jour désactivée 
* Suppression des MAJ via sconfig
* Clonage du master réalisé pour le futur

Toutes ces manips sont dispo via le *cmd* en tapant :
-> `sconfig` 
-> (1) Groupe de travail, (2) Nom de l'ordi, (4+7) Admin à distance, (5) MAJ, (8) Paramètres réseaux

Possible de passer par *Ninite* pour installer les softs.
> `appwiz.cpl` dans CMD pour vérifier les softs

![Check des softs installés](https://github.com/RaspCric/TSSR_Formation/blob/images/appwiz.jpg.png)

Infos paramètres réseau
-> `ncpa.cpl`

![ncpa](https://github.com/RaspCric/TSSR_Formation/blob/images/ncpa.png)

### B) INstallation d'un AD <a name="IIIB"></a>

**Ressources web :**
* [Mise en place d'un environnement AD](https://rdr-it.com/mise-en-place-environnement-active-directory/)
* [Définition d'un AD via wikipedia](https://fr.wikipedia.org/wiki/Active_Directory)
* [Monter un AD sur WServer2019 via technet365.fr](https://technet365.fr/installation-active-directory-sur-windows-serveur-2019/)
* [Installation d'un AD via techexpert.tips](https://techexpert.tips/fr/windows-fr/installation-dactive-directory-sur-windows-server/)
* [Administration simplifiée d'un AD via la doc Microsoft](https://docs.microsoft.com/fr-fr/windows-server/identity/ad-ds/manage/ad-ds-simplified-administration)

Une machine Serveur qui doit s'occuper des noms de Second niveau ; et à un AD correspond non un serveur mais un nom de domaine au moins

#### --- Installation de l'AD --- <a name="IIIB1"></a>

Sur la console *« Gestionnaire de serveur »*, nous allons ajouter le rôle AD DS.

- Ajouter un rôle et des fonctionnalités
- Services AD / DS

Une fois l’installation terminée, depuis la console *« Gestionnaire de serveur »* nous allons promouvoir le serveur en contrôleur de domaine

- **Nouvelle forêt** : **tssr.lan**
- Dans Option du contrôleur de déploiement, rentrer un nouveau mot de passe : Admin7007 (**générique : dadfba16**)
- Pas de gestion DNS

![Forêt tssr.lan](https://github.com/RaspCric/TSSR_Formation/blob/images/for%C3%AAt%20tssr.lan.png)

![AD](https://github.com/cromm24/Hello_World/blob/GLPI/AD.jpg)

#### --- Ajout d'un OU --- <a name="IIIB2"></a>

- Outil
- Utilisateur et Ordinateur
- Création d'un dossier **Usagers** à la racine *tssr.lan* (nouvel OU/UA)

![Nouvel OU Usagers](https://github.com/RaspCric/TSSR_Formation/blob/images/Nouvel%20OU.png)

#### --- Génération d'une base d'users --- <a name="IIIB3"></a>

1. On va passer par [Generatedata.com](https://www.generatedata.com/) afin de randomniser des noms pour enusuite réaliser un export csv<br/>
- 4 colonnes : prénom, nom, mdp (pin)<br/>
    -> générer en csv

2. Ensuite on passe par **excel** afin de modifier le CSV afin de le compléter :<br/>
* <span style="color: #32977E">=MINUSCULE(STXT(A8;1;1))&""&MINUSCULE(B8)</span> : création d'un login *1e lettre prenom+nom*<br/>
ou <span style="color: #32977E">=MINUSCULE(CONCATENER(STXT(A3;1;1);B3))</span><br/>
* <span style="color: #32977E">=MINUSCULE(CONCATENER(STXT(A3;1;1);B3;"@tssr.lan"))</span> : création d'un email <br/>
* <span style="color: #32977E">=("02"&ALEA.ENTRE.BORNES(10000000;99999999))</span> : création d'un n°de téléphone aléatoire<br/>
* <span style="color: #32977E">=(ALEA.ENTRE.BORNES(1;28)&"/"&ALEA.ENTRE.BORNES(1;12)&"/"&ALEA.ENTRE.BORNES(1970;1999))</span> : date de naissance aléatoire<br/>

Cela nous permet d'étoffer les informations liées aux USERS.

#### --- Mise en place d'une GPO pour autoriser les mdp faibles --- <a name="IIIB4"></a>

- Gestion de stratégie de groupe
- Objet de stratégie de groupe
- Stratégie Default Domain Policy
- Modifier
    -> Paramètre / Config ordi / Stratégies / Paramètres windows / Paramètres de sécurité / Stratégie de compte / stratégie de mdp <br/>
    -> changer les règles de mdp pour que les mdp générés via PIN (1234) soient acceptés

![Accès aux Stratégies de groupes](https://github.com/cromm24/Hello_World/blob/GLPI/gestion_strat%C3%A9gies_groupes.jpg)

![Baisse du niveau de sécurité des mdp via GPO](https://github.com/cromm24/Hello_World/blob/GLPI/restrictions_mdp.jpg)

![On force les modifications de la GPO](https://github.com/cromm24/Hello_World/blob/GLPI/update%20_force.jpg)

#### --- Générer les users créés dans le GLPI via un script shell --- <a name="IIIB5"></a>

Le script devra avoir l'extension .ps1 c'est-à-dire powershell version 1, qui permet la plus grande compatibilité.

* Script PS1 : [Script sur cefim](https://campus.cefim.eu/pluginfile.php/54105/mod_resource/content/1/adimport.ps1)
* Script PS1 simplifié 

```
$users = import-csv -path "C:\Users\TSSR\Desktop\import.csv" -delimiter ";"
foreach($user in $users)
{
    $prenom = $user.prenom
    $nom = $user.nom

    $nomComplet = $prenom + " " +$nom
    $idSAM = $prenom.substring(0,1) + $nom
    $id = $idSAM + "@tssr.lan"
    $email = $idSAM + "@tssr.lan"

    $pass= ConvertTo-SecureString "1234" -AsPlaintext -Force

    New-ADuser -name $idSAM -DisplayName $nomComplet -givenname $prenom -surname $nom -EmailAdress $email -Path "OU=usagers,DC=tssr,DC=lan -UserPrincipalName $id -AccountPassword $pass -Enabled $true
}

```

- Ouverture via NotePad++
- On met le fichier csv (**import.csv**) et le fichier ps1 (**script.ps1**) sur le bureau 
- On lance l'invite de commande PowerShell
> `Set-Location C:\Users\TSSR\Desktop\`<br/>
> `./script.ps1`<br/>

- On vérifie dans l'AD chez les usages : la liste a bien été générée

Pour le mappage des infos csv/ad : [SIte de microsoft qui donne le nom des catégories afin de permettre de rajouter des variables dans le script pour l'import d'infos supplémentaires](https://docs.microsoft.com/fr-fr/system-center/scsm/ad-ds-attribs?view=sc-sm-2019)


## IV. Importer des utilisateurs d’Active Directory dans GLPI <a name="IV"></a>

Dans le chemin `/windows/system32/drivers/etc/` il y a un fichier *services* où toutes les infos ports sont dedans + fichier *hosts* où il est possible de filtrer le réseau via ip/nomdns (sert de DNS local)

### A) Gestion des différents DNS <a name="IVA"></a>

**Ressources en-ligne**
- [DNS et Windows Server](https://openclassrooms.com/fr/courses/2356306-prenez-en-main-windows-server/5835581-installez-un-serveur-dns)
- [DNS dans AD](https://blog.netwrix.fr/2020/07/29/dns-dans-active-directory/)

Il s'agire de faire en sorte que les machines puissent avoir accès via une résolution des noms de domaines aux différents server et vice-versa. Ainsi il faudra que nous permettions aux différents services DNS d'être raccord entre les noms de domaines et les IP que nous souhaitons liées.

#### --- Mise sous tutelle du serveur via protocole DNS --- <a name="IVA1"></a>

Ajouter un support glpi dans WServer2019 + une redirection DNS car il faut mettre notre WServeur sous tutelle du DNS. POur se faire nous allons ajouter un support glpi dans WServer2019 ainsi qu'une redirection DNS

1. Pannel / DNS / gestion / DC1 / Zone de recherche directe / tssr.lan / Nouvel hôte
-> support_glpi + 192.168.0.32(adresse serveur glpi)<br/>
-> http://support_glpi.tssr.lan (accès au support via une adresse http)<br/>

![Support_glpi](https://github.com/RaspCric/TSSR_Formation/blob/images/support_glpi.png)

Ainsi, nous mettons en lien via notre nom de domaine tssr.lan l'ip de notre server glpi via son adresse IP fixe.

![Support glpi](https://github.com/cromm24/Hello_World/blob/GLPI/ajout_support_dns.jpg)

2. Sur la machine hôte faire pointer le DNS vers l'IP du WServeur (192.168.0.33) pour que ça fonctionne aussi sur la machine hôte

#### --- Modifications du DNS de réponse sur le serveur GLPI via VM Debian --- <a name="IVA2"></a>

1. Modifier le serveur de résolution dns dans le serveur glpi (ici, IP de notre serveur AD)

2. Aller sur la machine GLPI
> `nano /etc/resolv.conf` <br/>
-> serveur dns = ip wserveur = 192.168.0.33

Ainsi, le server GLPI qui est hébergé sur notre VM debian résout sa recherche DNS directement via notre WServer. Nos deux serveurs (GLPI-WServer) sont donc désormais liés dans la résolution DNS de leurs IP.

### B) Import des users via un annuaire LDAP <a name="IVB"></a>

1. Via l'interface GLPI
- Configuration / Authentification / Annuaires LDAP
- Nom : **tssr.lan**
- Serveur : **dc1.tssr.lan**
- OU=usagers,DC=tssr,DC=lan
- administrateur@tssr.lan / mdr=mdp de WServeur2019 (Admin7007)

2. Utilisateurs
- Utilisateurs / Annuaires LDAP / Importer les usagers

![Import des users](https://github.com/cromm24/Hello_World/blob/GLPI/import_user_glpi.jpg)

### C) Configurer les intitulés <a name="IVC"></a>

**Ressources web :**
* [Configurer les intitulés](https://glpi-project.org/DOC/FR/glpi/config_dropdown.html)
* [Via le site GLPI](https://glpi-user-documentation.readthedocs.io/fr/latest/modules/configuration/intitules/index.html)
* [Injection en masse des données dans GLPI](https://neptunet.fr/glpi-data-injection/)

1. On commence par changer l'entité 
-> Nom : **bortzmeyer** comme entité racine (ou alors en *enfant*)
-> Infos générales rentrées (Adresse)
-> Règles génériques = tag = n°pour équipements qui représente quelque chose qui pourrait servir pour inventaire

![Info entité](https://github.com/cromm24/Hello_World/blob/GLPI/entit%C3%A9.jpg?raw=true)

- Ensuite on passe aux intitulés 
* ([Lien Dell pour aport fabricants et config via it.zero.fr](https://it.izero.fr/glpi-ajout-plugin-imports-fabricants-et-configuration-pour-dell/))
    -> bien lister les ensembles d'infos
    -> ex: OS (Windows, BSD, Linux...), Type d'ordinateur (Laptop, PC...)

![liste d'intitulés](https://github.com/cromm24/Hello_World/blob/GLPI/intitul%C3%A9s.jpg?raw=true)


#### D) Gestion générale de GLPI : plugins --- <a name="IVD"></a>

**Ressources web :**
* [Gestion générale de GLPI](https://neptunet.fr/glpi/)
* [Cours OpenClassroom sur FusionInventoy](https://openclassrooms.com/fr/courses/1730516-gerez-votre-parc-informatique-avec-glpi/5994176-installez-le-plugin-et-l-agent-fusioninventory)
* [Liste des PLugins dispo](https://plugins.glpi-project.org/#/)
- [Tuto online via Neptunet](https://neptunet.fr/glpi-ad/)

Pour installer un plugin dans GLPI, il suffit de télécharger son archive puis de l'extraire dans le dossier .../glpi/plugins, et de les installer via l'interface de GLPI. Ensuite, dans l'interface GLPI, aller sous Configuration > Plugins cliquez sur Installer puis Activer. À noter qu'un plugin peut disposer de plusieurs versions, chaque version est la plupart du temps spécifique à une version précise de GLPI


1. [DataInjection](https://neptunet.fr/glpi-data-injection/)

```

cd /tmp
wget https://github.com/pluginsGLPI/datainjection/releases/download/2.9.0/glpi-datainjection-2.9.0.tar.bz2
tar -xvjf glpi-datainjection-2.9.0.tar.bz2
cp -r datainjection/ /var/www/html/plugins/
chown -R www-data /var/www/html/plugins

```

2. Dashboard

```

cd /tmp
wget https://forge.glpi-project.org/attachments/download/2323/glpi-dashboard-1.0.2.zip
unzip glpi-dashboard-1.0.2.zip
cp -r glpi-dashboard-1.0.2/ /var/www/html/plugins/

cd /var/www/html/plugins/
mv glpi-dashboard-1.0.2 dashboard

chown -R www-data /var/www/html/plugins

```

3. Fusion inventory plugin pour déployer agents

```

cd /tmp
wget https://github.com/fusioninventory/fusioninventory-for-glpi/archive/refs/tags/glpi9.5+3.0.tar.gz
tar -xvjf fusioninventory-9.5+3.0.tar.bz2
cp -r fusioninventory/ /var/www/html/plugins/
chown -R www-data /var/www/html/plugins

```

![FusionInventory](https://github.com/cromm24/Hello_World/blob/GLPI/plugins.jpg?raw=true)  

4. Crontab (suite à l'installation de Fusion Iventory)

**Crontab** sous Linux est la table qui gère les actions automatiques. Pour que GLPI puisse fonctionner “automatiquement” malgré son aspect de site en PHP (qui ne réagit donc que quand il y a une requête), on intègre un fichier cron.php qui va envoyer automatiquement une requête toutes les minutes sur le serveur, pour simuler la présence de quelqu’un sur la page.

> `cd /root`
> `# crontab -u www-data -e` <br/>
-> Choix n°1 pour use nano

On ajoute à la fin la ligne

```
*/1 * * * * /usr/bin/php7.3 /var/www/html/front/cron.php &>/dev/null

```

Ensuite
> `# /etc/init.d/cron restart`


#### E) Gestion générale de GLPI : mise en pratique via FusionIventory--- <a name="IVE"></a>

* Téléchargement de FusionInventory Agent via [GitHub](https://github.com/fusioninventory/fusioninventory-agent/releases/download/2.6/fusioninventory-agent_windows-x64_2.6.exe)  
* On l'installe sur notre client
    - Choisir les composants : **complète**
    - Choisir la destination (serveur GLPI) : http://192.168.0.32/plugins/fusioninventory/  et cochez installation rapide   

* On va sur http://localhost:62354 
* On force une remontée : **Force an inventory**

* Ensuite on va sur le GLPI de son hôte et dans Ordinateur on peut voir la remontée (ici, **DC1** puisqu'à partir de notre WServeur dont le nom est DC1)

![Voici ce que cela donne via l'interface GLPI](https://github.com/cromm24/Hello_World/blob/GLPI/Capture%20d%E2%80%99%C3%A9cran%202021-06-23%20155415.jpg?raw=true)

Et on répète l'action sur des VM agents sous W10 créées pour l'occasion (192.168.0.41 et 192.162.0.42, avec en passerelle/dns notre WServer 192.168.0.33). 

![Agent DC2](https://github.com/RaspCric/TSSR_Formation/blob/images/agentsw10.jpg)

On utilise le partage de dossier VMware pour lancer FIAgent et on pousse des remontées.
Idem avec le smartphone et l'application GLPI Agent.

![Import via FusionInventory](https://github.com/RaspCric/D-Documents-5---GitHub-/raw/images/import%203%20agents.png)

On peut ensuite faire un état des lieux de l'ensemble du parc (le gsm est reconnu comme ordinateur)

![Tableau de bord du GLPI local avec les imports](https://raw.githubusercontent.com/RaspCric/D-Documents-5---GitHub-/images/tableau%20de%20bord%20glpi.png)

#### F) Gestion générale de GLPI : tickets et création d'un Helpdesk --- <a name="IVF"></a>


**Ressources Web**
* [OpenClassroom](https://openclassrooms.com/fr/courses/1730486-gerez-vos-incidents-avec-le-referentiel-itil-sur-glpi/6544671-traitez-et-suivez-votre-ticket-dans-glpi)
* [GLPI-Project](https://glpi-project.org/DOC/FR/glpi/helpdesk_openticket.html)
* [HelpDesk ticket](https://glpi-project.org/DOC/FR/glpi/helpdesk_ticket.html)


Le module d'assistance de GLPI est conforme au guide de bonnes pratiques ITIL pour la partie Gestion des incidents et gestion des demandes de services : il intègre donc des notions comme l'impact, l'urgence d'un ticket, la matrice de calcul des priorités associées et une normalisation des statuts. Bien que l'outil soit conforme ITIL, il n'y aucune obligation pour suivre ces bonnes pratiques : chacun est libre d'implémenter la gestion des incidents qui correspond le mieux à ses besoins.


1. Création d'un ticket :  

![*](https://github.com/cromm24/Hello_World/blob/GLPI/creation_ticket.jpg?raw=true)

2. Deux exemples de résolutions de tickets :  

![*](https://github.com/cromm24/Hello_World/blob/GLPI/r%C3%A9solution%20ticket.png?raw=true)  

![*](https://github.com/cromm24/Hello_World/blob/GLPI/ticket_r%C3%A9solu.jpg?raw=true)  

Il est possible de voir l'ensemble des tickets dans l'interface GLPI.

![Récapitulatif des tickets](https://github.com/RaspCric/D-Documents-5---GitHub-/raw/images/tockets.png)

3. Exemples de résolutions de tickets dans un contexte d'entreprise et avec une réelle perspective de résolution informatique

![Accès au ticket](https://github.com/RaspCric/TSSR_Formation/raw/images/creer%20un%20tiket.jpg)

![Demande en cours](https://github.com/RaspCric/TSSR_Formation/blob/images/r%C3%A9solution%20ticket%202.png.jpg)

![Réponses aux question](https://github.com/RaspCric/TSSR_Formation/raw/images/ticketre%C3%A7u2.jpg)

* Ticket Michie

![*](https://github.com/cromm24/Hello_World/blob/GLPI/ticket1michie.jpg)

![*](https://github.com/cromm24/Hello_World/blob/GLPI/ticket2michie.jpg)

![*](https://github.com/cromm24/Hello_World/blob/GLPI/ticket3michie.jpg)

![*](https://github.com/cromm24/Hello_World/blob/GLPI/ticket4michie.jpg)

![*](https://github.com/cromm24/Hello_World/blob/GLPI/ticket5michie.jpg)

* Ticket Michu

![*](https://github.com/cromm24/Hello_World/blob/GLPI/ticket2michu.jpg)

![*](https://github.com/cromm24/Hello_World/blob/GLPI/ticket3michu.jpg)

![*](https://github.com/cromm24/Hello_World/blob/GLPI/tticket4michu.jpg)


#### G) Gestion générale de GLPI : tickets et création d'un Helpdesk dans le cloud --- <a name="IVG"></a>
























--> vendredi itil
--> au retour stage, Bureautique (tableau croisé auto... + modules365... + certification excel/bureautique)



---

<a name="lexique"></a>

## Petit récapitulatif des commandes importantes sur Linux

1. [Index en ligne des lignes de commandes Linux](https://opensharing.fr/index-des-commandes-linux)
2. [Commandes USERs](https://doc.ubuntu-fr.org/commande_shell)
3. [Commandes utilisateurs](http://www2.ift.ulaval.ca/~beaulieu/linux/fr/man1/_index.html)
4. [Les commandes fondamentales de Linux](http://wiki.linux-france.org/wiki/Les_commandes_fondamentales_de_Linux)

<br/>

___LEXIQUE___
| commande | explications |
|------------:|-------------:|
| `nmap` | permet de vérifier si les services et port sont ouverts. |
| `zip` | les formats les plus populaires sur linux sont bz bz2 et gz. | 
| `lynx` | permet d'avoir un navigateur en html interprété standard. | 
| `curl` | c'est le programme préféré de l'idôle de Thomas (fallait suivre) permet de tester des url. | 
| `net-tools` | des outils réseaux. |
| `dnsutils` | pour les dns quoi. |
| `bsdgames` | une suite de jeux en ligne de commande. |  
| `samba` | permets de faire du partage à la windows |
| `winbid` | liaison à la windows, notre serveur pourra partager des paquets à la windows |  
| `nsswitch` | name service au sens global de résolution de nom; sert à être vu dans le partage windows et avoir accès au nom netbios |  
| `webmin` | permet d'administrer un serveur linux par un navigateur web (pour les débutants) |  
| `bash` | bourne again shell |  
| `nano` | not another notpad |  
| `wget` | windows obtenir : vas chercher sur le net pour le télécharger |  
| `su -` | permet de passer en super utilisateur mais permets de modifier les variables du path |  
| `dpkg` | debian package |  
| `wbmin` | web administration |  
| `~` | dit qu'on est dans le répertoire maison |  
| `#` | indique qu'on est en power user | 