![*](https://media-exp1.licdn.com/dms/image/C4D0BAQEJIrLeIu3hgg/company-logo_200_200/0/1568885231849?e=2159024400&v=beta&t=VmG6ouGc0bZv7vXQLokouf_RUEIRI32PnPfz92LVwa4)

*MD conçu par Romain, Jean-Baptiste et des éléments issus des .md de Thomas C.*

# AT1C3 : **SOLUTION ITIL VIA GLPI**

![*](https://repository-images.githubusercontent.com/39182755/f4f30f80-cd92-11e9-8301-1ad34bf00c41)

**ITIL** (pour « _Information Technology Infrastructure Library_ », ou « Bibliothèque pour l'infrastructure des technologies de l'information » en français) est un ensemble d'ouvrages recensant les bonnes pratiques (« best practices ») du management du système d'information. Rédigée à l'origine par des experts de l'Office public britannique du Commerce (OGC), ITIL a fait intervenir à partir de sa version 3 des experts issus de plusieurs entreprises de services telles qu'Accenture, Ernst & Young, Hewlett-Packard, Deloitte, BearingPoint, CGI ou PriceWaterhouseCoopers.

C'est un référentiel méthodologique très large qui aborde les sujets suivants :

* Comment organiser un système d'information ?
* Comment améliorer l'efficacité du système d'information ?
* Comment réduire les risques ?
* Comment augmenter la qualité des services informatiques ?

ITIL permet, grâce à une approche par processus clairement définie et contrôlée, d'**améliorer la qualité des SI et de l'assistance aux utilisateurs** en créant notamment la fonction (au sens « département de l'entreprise ») de **Centre de services** ou « Service Desk » (extension du « help desk ») qui centralise et administre l'ensemble de la gestion des systèmes d'informations. ITIL est finalement une sorte de « _règlement intérieur_ » du département informatique des entreprises qui l'adoptent.

Les bénéfices pour l'entreprise sont une meilleure traçabilité de l'ensemble des actions du département informatique. Ce suivi amélioré permet d'optimiser en permanence les processus des services pour atteindre un niveau de qualité maximum de satisfaction des clients. 


## **Contexte(s) professionnel(s) de mise en oeuvre**

* Cette compétence est mise en oeuvre dans un centre de services conformément aux règles de bonnes pratiques de la démarche ITIL (Information Technology Infrastructure Library).  
* La mise en oeuvre de cette compétence s'appuie généralement sur un outil de gestion d'assistance.  
* Le technicien intervient à distance ou se déplace auprès de l'utilisateur.  
* Le technicien intervient en temps limité et en respectant des procédures.  

## **Savoir-faire techniques, savoir-faire organisationnels, savoir-faire relationnels, savoirs**

* Utiliser un outil de gestion d’incidents   
* Traiter un dossier d'incident   
* Appliquer un script de questionnement ou une méthode d'analyse en résolution d'incident   
* Réaliser des opérations de maintenance par l'intermédiaire d'un outil de prise de contrôle à distance   
* Utiliser et renseigner une base de connaissances   
* Gérer les problèmes   
* Communiquer à l'oral avec un niveau de langage et un vocabulaire adaptés à l'utilisateur   
* Maîtriser sa communication en situation de crise   
* Rédiger des comptes rendus d’intervention clairs, concis et correctement orthographiés   
* Connaitre les processus de gestion des incidents et de gestion des problèmes au sens ITIL   

## **Organisation de la séquence :**

1. Monter un GLPI
2. Exploitation GLPI  

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

***Schéma de l'infra finale demandée***

![Schéma de l'infra finale demandée](https://raw.githubusercontent.com/RaspCric/In-girum-imus-nocte-et-consumimur-igni/images/SCHEMA_INFRA_GLPI.jpg)

# **VM Master Debian 10 Clean et Classic** 

## **Création d'une VM sous VMware workstation.**

2go de Ram / 12Go DD / Bridge  
Installation de Debian 10.7.0  
Nom : unique et pertinant, voué à être changé : changeme  
- Domaine : tssr.lan  
- Mdp : pas de stratégie car l'admin doit etre responsable. dadfba16  
- Utilisateur : login : user // mdp : dadfba16  
- Miroir sur le réseau : Sert à allez en ligne (sur un dépot débian.org) pour installer les différents paquets qui composeront notre serveur linux. Donc  OUI !  (proche de nous de préf donc France)  
- Séléctions des logiciels : décocher tout sauf les utilitaires usuels du système. Pas besoin du reste, on est des POWER USER ! On fait tout nous-même en ligne de commande.
- Grub : Oui il faut l'installer sinon notre linux sera comme les singes de la vertu.   

_INSTALLATION MINIMALE PROPRE TERMINEE_  

## **Admin linux en ligne de commande pour avoir une base line propre**  


Configuration de notre Baseline Server en mode CLI via le compte **root** :

Vérification des infos réseaux  
> `ip a`  

Vérifié le DNS:  
> `ping 1.1.1.1`  
 
Vérifier qu'internet fonctionne:  
> `ping www.google.fr`  

Vérifier que tous les dépôts où le debian va chercher les dl sont ok    
> `/etc/apt/sources.list`  

Mise à jour:  
> `apt update` : contact le dépot officiel et vérifie que le catalogue est à jour.  
> `apt ugrade` : met à jour les paquets.  

Mise en réseau du poste:  
> `nano /etc/network/interfaces`  

Mettre à minima pour un passage en IP Fixe:  
> auto ens33  
> iface ens33 inet static  (remplace dhcp par static)  
> address 192.168.X.X/24  ( OUBLIER PAS IL Y A 2 D, C'EST ADDRESSE EN ANGLAIS ! (et pas de "e" non plus))  
> gateway 192.168.Y.Z   

Changer le **hostname** ici:  
> `nano /etc/hostname`   
  
Vérifier et changer le serveur **DNS** préféré ici le cas échéant:   
> `nano /etc/resolv.conf`   
> domain tssr.lan   
> search tssr.lan  
> nameeserver 1.1.1.1   


## **Configuration du profile bash du compte root:**   

Se connecter en root sur la machine  
Editer le fichier de préférence du shell via nano:  
> `nano /root/.bashrc`  

![Fichier .bashrc](https://raw.githubusercontent.com/RaspCric/In-girum-imus-nocte-et-consumimur-igni/images/bashrc.png)

Décommenter les 5 lignes commencent par export et juste avant les RM (export, eval, alias ls, alias ll; alias l)  
> `Exit`

Puis on repasse en Root:
> `su -`

## **Installation des binaires utiles pour un sysadmin sur le serveur:**  

Installation de **SSH**:  
> `apt install ssh`

Ensuite prise en main du poste à partir du terminal windows distant en compte user limité: 
> `ssh user@192.168.1.20 (en user hein =))  `   

On repasse en root:
> `su -`   

Installations des **binutils:**  
> `apt install zip nmap curl lynx net-tools dnsutils`

Installation de la couche **netbios**:  
> `apt install  winbind samba`

Modifier le fichier **nsswitch** et ajouter **wins** à la fin de la directive **file**  
> `nano /etc/nsswitch.conf`

## **Installation de webmin:**

1. **Récupérer le binaire en .deb** sur le site officiel [https://www.webmin.com/](https://www.webmin.com/)  

2. Faire un clic droit sur le Debian Packiage dans la frame de gauche en haut et récupérer dans le presse papier l'adresse du paquet du genre:  

> [http://prdownloads.sourceforge.net/webadmin/webmin_1.979_all.deb
](http://prdownloads.sourceforge.net/webadmin/webmin_1.979_all.deb
)  

3. Ensuite dans la console en mode ssh et en root et si possible dans /root  
> `wget http://prdownloads.sourceforge.net/webadmin/webmin_1.979_all.deb`

4. Ensuite on commence l'installation:    

> `dpkgi -i webadmin/webmin_1.979_all.deb`  

5. L'installation bloque car il manque 4 paquets (des bibliothèques Perl) mais le programme APT sait les bibliothèques manquantes, donc on termine l'installation:  

> `apt install -f`

6. Il ne reste plus qu'à se connecter via le navigateur de votre hôte win10 sur votre serveur en mode web

> https://votreip:10000

***Master Prêt*** _(On le clone avant de passer à la suite)_

# **Installation de GLPI sur notre Debian**

_Il va s'agir d'installer un logiciel libre de gestion des services informatiques (ITSM) et de gestion des services d'assistance (issue tracking system et ServiceDesk). GLPI est une application web qui aide les entreprises à gérer leur système d’information. Parmi ses caractéristiques, cette solution est capable de construire un inventaire de toutes les ressources de la société et de réaliser la gestion des tâches administratives et financières. Les fonctionnalités de cette solution aident les Administrateurs IT à créer une base de données regroupant des ressources techniques et de gestion, ainsi qu’un historique des actions de maintenance. La fonctionnalité de gestion d'assistance ou helpdesk fournit aux utilisateurs un service leur permettant de signaler des incidents ou de créer des demandes basées sur un actif ou non, ceci par la création d'un ticket d’assistance._

## **Préparation du Debian avant l'installation**

1. On va installer les applications nécessaires, à savoir **apache2** pour les services web, **mariadb** pour la base de données et **php(7)** pour le langage de programmation (notre serveur devient donc un serveur « **LAMP** »).
>`apt install apache2 php libapache2-mod-php mariadb-server -y`  

2. Ensuite, nous allons installer toutes les dépendances donc pourrait avoir besoin GLPI un jour ou l'autre. Outils d'interprétations + bibliothèques (MSQL-Maria, URLS...) = entre apache et MSQl c'est HTTP le lien, et apache renforcé.  
> `apt install php-mysqli php-mbstring php-curl php-gd php-simplexml php-intl php-ldap php-apcu php-xmlrpc php-cas php-zip php-bz2 php-imap -y`

3. Voilà qui est fait. Nous allons maintenant sécuriser l’accès au service de base de données. Lancez la commande suivante :
> `mysql_secure_installation`

* Le mot de passe de l’utilisateur root est demandé. **Il ne s’agit pas ici du mot de passe de l’utilisateur root sur la machine elle-même mais de l’utilisateur SQL** (base de données). Par défaut, aucun mot de passe ne lui a été configuré, c’est donc ce que nous allons faire.   

![*](https://neptunet.fr/wp-content/uploads/2020/11/glpi54.png)  

* Appuyer simplement sur **Entrée**.  
* A la question suivante, on vous demande si vous voulez attribuer un mot de passe au compte root. Tapez la lettre **Y** pour répondre Yes et appuyez sur **Entrée**.  
* Saisisser 2 fois le mot de passe que vous voulez donner au compte SQL root.  
* Répondre **Yes** à toutes les autres questions posées.  

![*](https://neptunet.fr/wp-content/uploads/2020/11/glpi57.png)  

* MariaDB est installé !

_Voir Ressources_  

4. Maintenant que l’accès aux bases de données est sécurisé, se connecter avec le compte root et le mot de passe que nous venons de lui définir :
> `mysql -u root -p`

5. Créer la base de données qui sera utilisée par GLPI et un utilisateur de base de données qui aura les pleins pouvoirs sur celle-ci. Voici les 3 commandes à saisir pour cela (**les ; sont nécessaires**) :  
> `create database db_glpi;`  
* créer une base de données appelée « db_glpi » (on peut lui donner le nom que l'on veut) 
* créer un utilisateur ici nommé « admindb_glpi », lui attribuer le mot de passe « MDP » et lui donner tous les privilèges (une sorte de « contrôle total » sur la base de données « db_glpi »).  
> `grant all privileges on db_glpi.* to`  
> `admindb_glpi@localhost identified by "MDP";`  

6. Vérification des infos MariaDB : la base de données, les tables... pour pouvoir sélectionner des informations, on utilise la commande "select "  
> `show database;`  
> `show tables;`  
> `select * from nomdelatable`  
> `select * from user`  

7. Quitter l'interface de configuration de la Base de Données  

> `exit`    

8. Avant se de lancer dans l’installation même de GLPI, une dernière manipulation facultative mais utile : sécuriser l’accès au répertoire qui va convenir GLPI sur la machine. On va en fait refuser l’indexation des fichiers de configuration de GLPI dans un navigateur web.  

* Pour cela, modifier le fichier de configuration du site web par défaut d’apache :  
> `nano /etc/apache2/sites-available/000-default.conf`  

* Sous la ligne « DocumentRoot », ajouter les lignes suivantes en respectant l’indentation :  

> <Directory /var/www/html>  
> Options Indexes FollowSymLinks  
> AllowOverride All  
> Require all granted  
> < /Directory>  


Vous devriez avoir un fichier qui ressemblera à ceci :  

![*](https://neptunet.fr/wp-content/uploads/2020/11/glpi58.png)  


_Le paramètre « Directory » correspond au futur emplacement de stockage de GLPI sur ma machine, à adapter à votre configuration bien entendu. Il n’est pas rare de placer GLPI dans un dossier à part entière plutôt qu’à la racine du service web, dans ce cas il sera dans /var/www/html/glpi, il faudra donc mettre ce fichier à jour. L’URL du site deviendra http://adresse_ip/glpi_

9. Pour appliquer toutes les modifications, il reste à redémarrer le service apache :
> `service apache2 restart`

## **Nous allons ENFIN pouvoir installer GLPI !**

10. Placer vous dans un répertoire temporaire et téléchargez la dernière version disponible de GLPI sur Github :  
> `cd /tmp`  
> `wget https://github.com/glpi-project/glpi/releases/download/9.5.5/glpi-9.5.5.tgz`  

11. Décompresser l’archive de GLPI :  
> `tar -xvzf glpi-9.5.5.tgz`  

12. Copier le contenu du dossier décompressé nommé « glpi » dans `/var/www/html`.  

* copier des fichiers dits “cachés” dont le nom commence par un “.”  
> `shopt -s dotglob` 

* supprimer le fichier index.html qui est la page d’accueil par défaut d’Apache  
> `rm /var/www/html/index.html`  

* copier le tout dans la destination  
> `cp -r glpi/* /var/www/html/`  

13. Rendre l’utilisateur des services web (nommé www-data) propriétaire de ces nouveaux fichiers :
> `chown -R www-data /var/www/html`  

## **Les fichiers pour GLPI sont prêts**  

Poursuivre l'installation via une interface web. Si votre machine hôte possède une interface graphique avec un navigateur internet, rendez-vous à l’URL suivante :  

> `http://localhost`  

Ou via son adresse ip  

> `http://ip_de_votre_machine_glpi`  

_Si vous tombez sur une page web d’Apache par défaut, vous pouvez supprimer le fichier index.html avec la commande suivante et rafraichir la page, vous sera alors bien sur le setup d’installation de GLPI : `rm /var/www/html/index.html`(ou alors mettre un beau chat en ascii dedans, ca pourrait faire plaisir à quelqu'un ...)_

**Page du setup de GLPI.**    

* Sélectionner le Français dans la liste déroulante et cliquez sur OK. 

![*](https://neptunet.fr/wp-content/uploads/2020/11/glpi61.png)  

* Accepter les conditions d’utilisation.  

* Cliquer sur le bouton **Installer** pour lancer le setup.  

* Une série de test sera lancée par le setup pour s’assurer que tous les prérequis nécessaires au bon fonctionnement de GLPI sont remplis. Si vous avez correctement suivi ce tuto, il ne devrait y avoir que des coches vertes. Cliquer sur **Continuer**.  

![*](https://neptunet.fr/wp-content/uploads/2020/11/glpi64.png)  

* Saisir les informations sur la base de données destinées à GLPI que nous avons précédemment créée. Saisir **localhost** pour spécifier que la machine actuelle héberge à la fois le site web de GLPI et la base de données (si la base de données est stockée sur une autre machine, saisissez son adresse IP). Rentrer ensuite le **nom de l’utilisateur** qui a tous les privilèges sur cette base de données et son **mot de passe**.  

![*](https://neptunet.fr/wp-content/uploads/2020/11/glpi65.png)  

* Sélectionner ensuite la base de données créée spécialement pour **GLPI**.  

![*](https://neptunet.fr/wp-content/uploads/2020/11/glpi66.png)  

* Le setup va contacter la base de données pour s’assurer que tout est OK. Cliquer sur **continuer**.  

* Choisir d’envoyer ou pas des statistiques sur votre utilisation de GLPI à l’équipe qui gère le projet et cliquer sur **continuer**.  

* Une version commerciale de GLPI avec un service support dédié existe. Faire un don est possible. Cliquer sur **continuer**.  

## **Encore quelques réglages**

* Cliquer sur **Utiliser GLPI**.  
* Se connecter avec les identifiants par défaut d’un compte administrateur.  
* Un message d’avertissement vous informe que par **sécurité** il faudra changer les mots de passe par défaut des 4 utilisateurs créés automatiquement et supprimer le fichier « install.php ».  

![*](https://neptunet.fr/wp-content/uploads/2020/11/glpi73.png)  

* Cliquer sur le nom d'un utilisateur. Attribuer lui un nouveau mot de passe. **Répêter l'opération pour tout les utilisateurs**.  
* Supprimer le fichier install.php :  
> `rm /var/www/html/install/install.php`  

_La localisation du fichier install.php dépend de l’emplacement où se trouvent les fichiers de GLPI sur la machine._  

## **Translation NAT**

1. D'abord allez sur *monip.org* pour avoir l'IP public pour ensuite la corréler avec une adresse DNS via nom de domaine<br/>
- 90.20.205.172

2. Il s'agit ensuite de passer par notre fournisseur de domaine pour y ajouter une règle DNS.
- jb.cefim-formation.org
- A (Type) ; 10800 (TTL) ; 90.20.205.172 (IPv4)
- cela permet d'associer à notre IP publique un DNS spécifique pour être utilisé dans la barre de recherche du navigateur

3. Ensuite on va dans la BOX (192.168.1.1)
- Orange / Réseau / Paramètres avancées /Transfert de ports  
- GLPI (nom) ; TCP (port 80), IP locale du serveur  
- On permet ainsi de lier notre IP locale de la VM à notre IP publique via l'ouverture du port TCP.  

Via une interface web en pingant l'adresse IP publique on tombe sur l'IP local du serveur GLPI (ou via *support.cefim.ninja*)

## **Personalisation du GLPI**

1. Pour ajouter un texte d'accueil :  
    Configuration -> général  
    Mettre un court texte pour qu'on puisse reconnaître le GLPI

2. Pour changer l'image du logo d'accueil via commande SSH sur la machine hôte  
    
- Clique droit sur le logo GLPI de l'accueil pour trouver le chemin de l'image:  
> `/var/www/html/pics`   

- On se rend dans se dossier et on upload la nouvelle image:  
> `wget urlimage.png`  

- On renomme le fichier logo avec un autre nom de facon à garder une copie du fichier source.
> `mv logo_login_glpi.png logo_login_glpi2.png`

- Et ensuite on renome le fichier upload avec le nom du fichier de base:  

> `mv urlimage.png logo_login_glpi.png`

![Page d'acceuil](https://raw.githubusercontent.com/cromm24/Hello_World/GLPI/accueil_glpi.png)



# **Mise en place d'un GLPI commun**

### **Utilisation du cloud Amazon AWS**

AWS -> serveur d'amazon
1. Dans les champs de navigation d'AWS aller sur l'EC2 qui gère l'ensemnle des serveurs dans le cloud:  
  Utilisation du Wizzard (AMI, type d'instance, configuration instance, stockage, balises ROLE/GLPI, groupe de sécurité pour config les ports/protocoles d'accès, lancement de l'instance, nouvelle paire de clefs pour pouvoir être prise en main à distance via ssh)

2. Vérifier que les informations de temporalités sont bonnes 
> `date`  

3. Reconfigurer la date si besoin:  
> `dkpg-reconfigure tzdata`

4. Nous allons créer une clef SSH via notre machine hôte afin de sécuriser la liaison avec le serveur  
   - Tuto : [Git-scm.com création de clés ssh](https://git-scm.com/book/fr/v2/Git-sur-le-serveur-G%C3%A9n%C3%A9ration-des-cl%C3%A9s-publiques-SSH)  
   - Tuto2 : [Créer une clef ssh et la mettre sur github](https://tutos.rezel.net/git/ssh-keys/)  
   - On génère une clef publique en ligne de commande 
   - On utilise la commande "*chmod 400*" afin de changer les autorisation jusqu'à un certain degré  

5. On envoie notre clef ssh au serveur GLPI créé dans le Cloud 
> `ssh -i nomdelaclef.pem admin@support.cefim.ninja`  

### **Configuration d'apache 2**

On descend dans le dossier Apache du serveur GLPI online
> `cd /etc/apache2`

On activate module ssl pour faire du HTTPS
> `a2enmod ssl`*

On relance le service apache pour qu'il prenne en considération les changements:  
> `systemctl restart apache2`  

On regarde les modes activés dans apache:   
> `mods-enable# 1`  

On désactive le site de base.  
On supprime tous les sites par défauts.   
On crée un seul site : `nano site1.conf` pour tous les ports: 
> `cd sites-enabled/`  
> `a2ssite 000-default`  

On descend dans le dossier var: 
> `/var` 
On supprime le dossier www 
> `rm -R www`
_En effet, il faut que le site soit créer dans /home avec un nouvel User qui sera ici *GLPI*_ 

On créé un nouvel user, on se déplace dans son arborescence, on passe en Admin pour créer un nouveau dossier www dedans. A l'intérieur du dossier, on créé une page html moche mais qui servira pour la suite grace à son affichage simple. 

> `adduser glpi`  
> `cd /home/glpi`  
> `su glpi`  
> `mkdir www`  
> `cd www`  
> `nano index.html`  


###  **Création d'un certifical SSL**

Afin de pouvoir passer en SSL et donc de proposer du HTTPS il s'agit de passer par un projet de certificat gratuit pour tout le monde : *cerbot* ; seul bémol, l'enregistrement dure 60 jours et se doit d'être renouvelé régulièrement.  

On upload à la racine le script certbot qui est un robot de certification automatique (78ko):
> `cd /root`  
> `wget https://del.eff.org/certbot-auto`  

On rend le script executable par n'importe qui afin de pouvoir le lancer sans message d'erreur de droit: (_Pour executer un script dans un environnement linux **./** devant_)  
> `chmod x certibot-auto`   
> `./ certbot-auto`   

On finit par obtenir un certificat et il est alors possible de se rendre sur la page [support.cefim.ninja](https://support.cefim.ninja/) via HTTPS.  

_Voir Ressources_  

### **Installation GLPI sur le serveur cloud**

On descend dans le dossier glpi et on supprime le dossier www:  
> `cd /home/glpi/`   
> `rm /www`     

Toujours dans le dossier glpi, on upload la dernière version de glpi:   
> `wget glpi https://github.com/glpi-project/glpi/releases/download/9.5.5/glpi-9.5.5.tgz`  

On le décompresse et on l'installe (_manipulation déjà faite dans la partie précédente_) 

On change le nom de son dossier en www:  
> `mv glpi www`   

Le GLPI cloud est dispo via le nomdedomaine créé via DNS  
Ajout d'un utilisateur: jbfontanet, Fontanet Jean-baptiste, mdp *dadfba16*  

*


# **Configuration du Windows serveur 2019**  

**_Quelques remarques_**
* Au moins un domaine controler, mono domaine, mono serveur.  <br/>
* tld : top level domain ( comme . fr; 1er niveau)  <br/>
* FSMO : Flexible Single Master Operation, certains types de contrôleurs de domaine dans Active Directory, de Microsoft. Ce sont ceux qui jouent un rôle nécessitant un maître unique pour la réplication entre contrôleurs de domaine ; certains rôles sont uniques pour tous les domaines de la forêt ; d’autres rôles sont plus simplement uniques à l’intérieur d’un domaine. <br/>
* AD DS : active directory domain service <br/>
* Le niveau fonctionnel de la foret : windowsSer 2019 n'est pas un vrai OS, c'est plus le nom marketing de win ser 16 version 2 donc pas de news, on est sur une base de 2016. 2019 c'est plus une maj.  


**Préparation d'une baseline WServ2019**
   * Pare feu en privé avec règle ICMP
   * Workgroup : TSSR
   * hostname : DC1
   * IP FIXE en IPv4
   * IPv6 désactivée sur la carte ethernet0
   * Configuration de sécurité renforcée désactivée pour IE
   * Bureau à distance activé
   * Mise à jour désactivée  
   * Install de 7zip,Notepad++,SumatraPDF,Chrome, libreoffice via Ninite
   * Toutes ses commandes sont disponible via en ligne de commande :  
       > `sconfig`  

![*](https://github.com/cromm24/Hello_World/blob/GLPI/Parametrage%20AD.jpg?raw=true)

## **Installation Active Directory sur  notre Windows serveur 2019**

_Une machine Serveur qui doit s'occuper des noms de Second niveau ; et à un AD correspond non un serveur mais un nom de domaine au moins. Le premier contrôleur de domaine que nous installerons dans la forêt jouera les cinq rôles de la FSMO._   

1. Sur la console *« Gestionnaire de serveur »*, nous allons ajouter le rôle AD DS.

2. Nous allons suivre les étapes ci-dessous jusqu’à l’installation du rôle.

3. Une fois l’installation terminer, depuis la console *« Gestionnaire de serveur »* nous allons promouvoir le serveur en contrôleur de domaine.

4. Choisir l’option **Ajouter une nouvelle foret**. Le domaine sera **tssr.lan**. Ensuite, il faudra suivre les quelques étapes de configurations suivantes.

![Forêt tssr.lan](https://github.com/cromm24/Hello_World/blob/GLPI/config_ip_ws19.jpg?raw=true)  

![AD](https://raw.githubusercontent.com/cromm24/Hello_World/GLPI/AD.jpg)  

5. Dans Option du contrôleur de déploiement, rentrer un nouveau mot de passe : **Dadfba16**

6. Un redémarrage obligatoire du serveur aura lieu après l’installation.

## **On ajoute une OU (Unité d'Organisation):**  

- Outil
- Utilisateur et Ordinateur
- Création d'un dossier **usagers** à la racine tssr.lan (nouvel OU/UA)  

![Nouvel OU Usagers](https://raw.githubusercontent.com/RaspCric/In-girum-imus-nocte-et-consumimur-igni/images/Nouvel%20OU.png)  

## **Mise en place d'une GPO pour autoriser les mdp faibles:**

- Gestion de stratégie de groupe
- Objet de stratégie de groupe
- Stratégie Default Domain Policy
- Modifier:  
    - Paramètre -> Configuration ordinateur -> Stratégies -> Paramètres windows -> Paramètres de sécurité -> Stratégie de compte -> stratégie de mdpv  
    - changer les règles de mdp pour que les mdp générés via PIN (1234) soient acceptés  

![Accès aux Stratégies de groupes](https://raw.githubusercontent.com/cromm24/Hello_World/GLPI/gestion_strat%C3%A9gies_groupes.jpg)

![Baisse du niveau de sécurité des mdp via GPO](https://raw.githubusercontent.com/cromm24/Hello_World/GLPI/restrictions_mdp.jpg)

![On force les modifications de la GPO](https://raw.githubusercontent.com/cromm24/Hello_World/GLPI/update%20_force.jpg)

## **Générer les users et les "remonter" dans l'AD via un script shell**

On utilise [Generatedata.com](https://www.generatedata.com/) afin de randomniser des noms pour enusuite réaliser un export en `.csv`.  
Dans un tableur excel, crée une base de 100 user avec nom prénom mdp (1234).  On nomme le fichier **import.csv**.   

On peut ajouter des infos complémentaires:  
- un login avec la première lettre du prénom avec le nom via la formule:
    `=MINUSCULE(CONCATENER(STXT(A2;1;1);B2))`    
- un numéro de téléphone:  
    `=("06"&ALEA.ENTRE.BORNES(10000000;99999999))`  

On peut aussi faire l'ajout des infos complémentaires directement depuis le script powershell qui se nomme **import.ps1**:  

```ps1
$users = import-csv -path "C:\Users\TSSR\Desktop\import.csv" -delimiter ";"
foreach($user in $users)
{
    $prenom = $user.prenom
    $nom = $user.nom

    $nomComplet = $prenom + " " +$nom
    $idSAM = $prenom.substring(0,1) + $nom
    $id = $idSAM + "@tssr.lan"
    $email = $idSAM + "@gmail.com"
    $initials = $prenom.substring(0,1) + $nom.substring(0,1)

    $pass= ConvertTo-SecureString "1234" -AsPlaintext -Force

    New-ADuser -name $idSAM -DisplayName $nomComplet -givenname $prenom -surname $nom -EmailAdress $email -initials $initials -Path "OU=usagers,DC=tssr,DC=lan -UserPrincipalName $id -AccountPassword $pass -Enabled $true
}
```  

_Toujours dans le windows serveur_  

On place les fichier **import.csv** et **import.ps1** sur le bureau.  
On ouvre l'invite de commande Powershell:  
> cd desktop (pour se rendre sur le bureau)  
On exectue le script: 
> .\import.ps1 (pour exécuter le script)   

![execution du script](https://github.com/cromm24/Hello_World/blob/GLPI/import_ad.jpg?raw=true)  

**On remarque dans l'OU de l'AD que les usagers de la liste ont bien été généré.**

_Pour le mappage des infos csv/ad : [Site de microsoft qui donne le nom des catégories afin de permettre de rajouter des variables dans le script pour l'import d'infos supplémentaires](https://docs.microsoft.com/fr-fr/system-center/scsm/ad-ds-attribs?view=sc-sm-2019)_  

_Voir Ressources_

# **Configuration et Utilisation de GLPI**

## **Mise en lien entre l'AD et notre GLPI via DNS**    

**Le protocole le plus important DNS**   

### _Mise en lien d’Active Directory et de notre GLPI via DNS_  

- [DNS et Windows Server](https://openclassrooms.com/fr/courses/2356306-prenez-en-main-windows-server/5835581-installez-un-serveur-dns)  

- [DNS dans AD](https://blog.netwrix.fr/2020/07/29/dns-dans-active-directory/)  

Le but est que les machines puissent avoir accès via une résolution des noms de domaines aux différents server et vice-versa. Nous devrons permettre aux différents services DNS de se raccorder entre les noms de domaines et les IP que nous souhaitons liées.

### _Mise sous tutelle du Wserveur via protocole DNS_

Ajouter un support glpi dans WServer2019 + une redirection DNS car il faut mettre notre WServeur2019 sous tutelle du DNS.

* Pannel -> DNS -> gestion -> DC1 -> Zone de recherche directe -> tssr.lan -> Nouvel hôte  
- support_glpi + 192.168.0.100 (adresse serveur glpi)  
- http://support_glpi.tssr.lan (accès au support via une adresse http)  

![Support_glpi](https://github.com/cromm24/Hello_World/blob/GLPI/accueil_glpi.png?raw=true)  

Ainsi, nous mettons en lien via notre nom de domaine tssr.lan l'ip de notre server glpi via son adresse IP fixe.  

![*](https://raw.githubusercontent.com/cromm24/Hello_World/GLPI/ajout_support_dns.jpg)  

Dans le chemin `/windows/system32/drivers/etc/` il y a:
  - un fichier *services* où toutes les infos ports sont dedans 
  - un fichier *hosts* où il est possible de filtrer le réseau via ip/nomdns (sert de DNS local)  

### _Gestion des différents DNS:_  

Tuto online : [Neptunet](https://neptunet.fr/glpi-ad/)  

1. Modifications du DNS sur WServer  
_Il faut mettre notre WServeur sous tutelle du DNS_  
    - Ajouter un support glpi dans WServer2019
   - Ajouter dans WServer2019 une redirection DNS
   - Allez dans WinSer -> Outils -> DNS -> Zones de recherches direct -> tssr.lan : créer un nouvel hôte : support / 192.168.1.86 (adresse du serveur GLPI)  
    -> http://support.tssr.lan (accès au support via une adresse http)

2. Modifications du DNS de réponse sur le serveur GLPI via VM Debian  
_Il faut modifier le serveur de résolution dns dans le serveur glpi (ici, IP de notre serveur AD)_  
   - Sur la machine GLPI:  
    > `nano /etc/resolv.conf`    
    > mettre comme nameserver l'ip du WServeur2019 : 192.168.1.100  

3. Dans le windows hôte, faire ncpa.cpl et fixer le serveur dns avec l'adresse ip du windows serveur : 192.168.1.100  

## **Import des users via un annuaire LDAP:**  

Via l'interface GLPI:  
   - Configuration -> Authentification -> Annuaires LDAP -> Ajouter
   - Cliquer sur "Active Directory" à coté de préconfiguation  
   - Nom : **tssr.lan**
   - Serveur : **dc1.tssr.lan**
   - OU=usagers,DC=tssr,DC=lan
   - administrateur@tssr.lan / mdr=mdp de WServeur2019 (Dadfba16)

Utilisateurs:  
   - Utilisateurs -> Annuaires LDAP -> Importer les usagers

![*](https://github.com/cromm24/Hello_World/blob/GLPI/import_user_glpi.jpg?raw=true)

## **Configurer l'entitée et les intitulés:**

On commence par changer l'**entitée** :   
  - Nom : *bortzmeyer SAS* comme entité racine (ou alors en *enfant*)
  - Infos générales rentrées (Adresse)
  - Règles génériques = tag = n°pour équipements qui représente quelque chose qui pourrait servir pour inventaire

![entité](https://github.com/cromm24/Hello_World/blob/GLPI/entit%C3%A9.jpg?raw=true)

Ensuite, on rempli les **intitulés** (bon courage) :  

![liste d'intitulée](https://github.com/cromm24/Hello_World/blob/GLPI/intitul%C3%A9s.jpg?raw=true)  

**Exemple de remplissage**

![Exemple 1](https://github.com/cromm24/Hello_World/blob/GLPI/exemple%20intitul%C3%A9%201.jpg?raw=true)

![Exemple 2](https://github.com/cromm24/Hello_World/blob/GLPI/exemple%20intitul%C3%A9%202.jpg?raw=true)

![Exemple 3](https://github.com/cromm24/Hello_World/blob/GLPI/exemple%20intitul%C3%A9%203.jpg?raw=true)

## **Gestion générale de GLPI : plugins**  

**1. Datainjection**

> `cd /tmp`  
> `wget https://github.com/pluginsGLPI/datainjection/releases/download/2.9.0/glpi-datainjection-2.9.0.tar.bz2`  
> `tar -xvjf glpi-datainjection-2.9.0.tar.bz2`
> `cp -r datainjection/ /var/www/html/plugins/`


**2. Dashboard**

> `cd /tmp`  
> `wget https://forge.glpi-project.org/attachments/download/2323/glpi-dashboard-1.0.2.zip`  
> `unzip glpi-dashboard-1.0.2.zip`   
> `cp -r glpi-dashboard-1.0.2/ /var/www/html/plugins/`  
> `cd /var/www/html/plugins/`  
> `mv glpi-dashboard-1.0.2 dashboard` 

**3. FusionInventory**

> `cd /var/www/html/plugins`  
> `wget https://github.com/fusioninventory/fusioninventory-for-glpi/releases/download/glpi9.5%2B3.0/fusioninventory-9.5+3.0.tar.bz2`
> `tar -xvjf fusioninventory-9.5+3.0.tar.bz2`    
> `mv fusioninventory-9.5+3.0/ fusioninventory/ `  
> `chown -R www-data /var/www/html/glpi/plugins`  (Attribuez les droits d'accès au serveur web)  

![](https://raw.githubusercontent.com/cromm24/Hello_World/GLPI/plugins.jpg)  

_suite à l'installation de FusionInventory_ :  

***Crontab*** _Sous Linux est la table qui gère les actions automatiques. Pour que GLPI puisse fonctionner “automatiquement” malgré son aspect de site en PHP (qui ne réagit donc que quand il y a une requête), on intègre un fichier cron.php qui va envoyer automatiquement une requête toutes les minutes sur le serveur, pour simuler la présence de quelqu’un sur la page._  

> `crontab -u www-data -e`  
> `*/1 * * * * /usr/bin/php5 /var/www/html/glpi/front/cron.php &>/dev/null`  
> `/etc/init.d/cron restart`  

## **Fusioninventory Agent**

* Récupérer [Fusioninventory Agent](https://github.com/fusioninventory/fusioninventory-agent/releases/download/2.6/fusioninventory-agent_windows-x64_2.6.exe)  
* Installer l'agent sur le client:  
    - Choisir les composants : **complète**
    - Choisir la destination : https://192.168.1.43/plugins/fusioninventory/  et cochez installation rapide  
* Ouvrir une page web, tapez : `localhost:62354` et forcer une remontée en cliquant sur **Force an inventory**.   


On crée une VM Win10 client avec comme IP Fixe 192.168.0.120 et passerelle/dns notre WServer 192.168.0.100. On lui injecte le plugin fusion et on le fait remonté dans GLPI. On peut répéter l'opération avec autant de VM que l'on veut.  

![Import via FusionInventory](https://github.com/cromm24/Hello_World/blob/GLPI/W10_IP.jpg?raw=true)  

De retour sur GLPI, les clients sont _"remontés"_ :

![*](https://github.com/cromm24/Hello_World/blob/GLPI/Capture%20d%E2%80%99%C3%A9cran%202021-06-23%20155415.jpg?raw=true)  

On peut ensuite faire un état des lieux de l'ensemble du parc.  

![Tableau de bord du GLPI local avec les imports](https://github.com/cromm24/Hello_World/blob/GLPI/Vue_g%C3%A9n%C3%A9rale_glpi.jpg?raw=true)

## **Gestion de ticket:**

_Le module d'assistance de GLPI est conforme au guide de bonnes pratiques ITIL pour la partie Gestion des incidents et gestion des demandes de services : il intègre donc des notions comme l'impact, l'urgence d'un ticket, la matrice de calcul des priorités associées et une normalisation des statuts. Bien que l'outil soit conforme ITIL, il n'y aucune obligation pour suivre ces bonnes pratiques : chacun est libre d'implémenter la gestion des incidents qui correspond le mieux à ses besoins._

### **Création d'un ticket:**  

![*](https://github.com/cromm24/Hello_World/blob/GLPI/1ticket.jpg?raw=true)

### **Deux exemples de résolution de tickets:**  

![*](https://github.com/cromm24/Hello_World/blob/GLPI/r%C3%A9solution%20ticket.png?raw=true)  

![*](https://github.com/cromm24/Hello_World/blob/GLPI/ticket_r%C3%A9solu.jpg?raw=true)  
 
### **Workflow de tickets dans un contexte d'entreprise et avec une réelle perspective de résolution informatique.**

![Accès au ticket](https://raw.githubusercontent.com/RaspCric/In-girum-imus-nocte-et-consumimur-igni/images/creer%20un%20tiket.jpg)

![Demande en cours](https://raw.githubusercontent.com/RaspCric/In-girum-imus-nocte-et-consumimur-igni/images/r%C3%A9solution%20ticket%202.png.jpg)

![Réponses aux question](https://raw.githubusercontent.com/RaspCric/In-girum-imus-nocte-et-consumimur-igni/images/ticketre%C3%A7u2.jpg)

* Ticket Michie  

![*](https://raw.githubusercontent.com/cromm24/Hello_World/GLPI/ticket1michie.jpg)

![*](https://raw.githubusercontent.com/cromm24/Hello_World/GLPI/ticket2michie.jpg)

![*](https://raw.githubusercontent.com/cromm24/Hello_World/GLPI/ticket3michie.jpg)

![*](https://raw.githubusercontent.com/cromm24/Hello_World/GLPI/ticket4michie.jpg)

![*](https://raw.githubusercontent.com/cromm24/Hello_World/GLPI/ticket5michie.jpg)

* Ticket Michu  

![*](https://raw.githubusercontent.com/cromm24/Hello_World/GLPI/ticket2michu.jpg)

![*](https://raw.githubusercontent.com/cromm24/Hello_World/GLPI/ticket3michu.jpg)

![*](https://raw.githubusercontent.com/cromm24/Hello_World/GLPI/tticket4michu.jpg)


### **Tickets et création d'un Helpdesk sur AWS : support.cefim.ninja**


Création de 2 utilisateurs:  
| identifiant | nom | prenom | email | Responsabilité | n° de poste |
|-------------|-----|--------|-------|----------------|-------------|
| jbfontanet | FONTANET | Jean-Baptiste | fontanetjb@gmail.com | Technicien | CEFNOOB110 |
| bhitman | HITMAN | Bob | fontanetjb@gmail.com | UserNoob | CEFNOOB110 |
---

![Tableau récapitulatif](https://raw.githubusercontent.com/RaspCric/In-girum-imus-nocte-et-consumimur-igni/images/tableau_sujets_glpi.png)  

Un ticket `Ma licence word à expirer.` est crée par un utilisateur.  
Je me connecte sur le GLPI avec mon compte Technicien et la suite de l'échange ce trouve ci-dessous.  

- On créé les tickets en fonction des problèmes rencontrés
- On attribue ensuite les tickets aux personnes dédiées

![Mise à disposition des tickets](https://raw.githubusercontent.com/RaspCric/In-girum-imus-nocte-et-consumimur-igni/images/creation%20de%20deux%20tickets%20et%20attribuation%20%C3%A0%20charles.jpg)

Ensuite on organise l'assistance à distance.

***Ticket***

![Echanges entre technicien et usager](https://github.com/cromm24/Hello_World/blob/GLPI/TicketWord.jpg?raw=true)  

### **Création d'une FAQ**

La base de connaissances répond à deux objectifs principaux : Le premier est de centraliser des connaissances internes aux différents techniciens. Le second est de mettre à disposition des utilisateurs des informations (FAQ publique) leur permettant de résoudre seuls des problèmes simples.  

Seuls les éléments de la FAQ publique sont visibles par les utilisateurs de l'interface simplifiée. Les éléments qui ne sont pas définis comme faisant partie de la FAQ publique sont visibles uniquement au sein de la console centrale par des techniciens par exemple.  

* GLPI / Outils / Base de connaissance  
    -> possible de parcourir les différents articles via *Parcourir*  
    -> pour ajouter appuyer sur "+"

![Ajout topic FAQ](https://raw.githubusercontent.com/RaspCric/In-girum-imus-nocte-et-consumimur-igni/images/Ajout%20faq.png)

* On vérifie ensuite dans l'accès utilisateur

![FAQ 1](https://raw.githubusercontent.com/RaspCric/In-girum-imus-nocte-et-consumimur-igni/images/faq1.png)

![FAQ 2](https://raw.githubusercontent.com/RaspCric/In-girum-imus-nocte-et-consumimur-igni/images/faq2.png)


# **Solution ITIL (Axelos)**

ITIL pour Information Technology Infrastructure Library, qui peut se traduire par Bibliothèque de l’Infrastructure des Technologies de l’Information, a été à l’initiative de l’organisation du commerce britannique (OGC) dans les années 80. Actuellement, ce standard est répandu et utilisé dans les plus grandes entreprises et organisations publics à travers le monde.
Un ensemble de bonnes pratiques

ITIL est un ensemble de livres qui regroupe les bonnes pratiques de management d’un service informatique dans le but d’optimiser l’utilisation des ressources informatiques. Ces guides sont une source d’informations permettant d’adapter l’organisation de son service IT à son business. En effet, suivre ce modèle permet de partager un même vocabulaire, d’identifier le rôle de chacun et de professionnaliser l’organisation. La démarche ITIL comprend, dans sa version 3 (ITIL V3), 24 processus traitant de : gestion des problèmes, perspective business/métier, planification de l'implémentation de la gestion de services… pour 4 fonctions :

* Centre de service
* Gestion de technique
* Gestions des opérations
* Gestion des applications

Datant de juin 2007, ITIL V3 est caractérisé par la prise en compte de la virtualisation, l’externalisation ou encore des nouvelles architectures technologiques.
Quels sont les bénéfices pour l'entreprise ?

Le principal objectif de l’ITIL est d’améliorer de manière significative le service au client, c’est pourquoi nous le retrouvons au cœur du modèle, en favorisant l’efficacité des fonctions informatiques. L’adoption du modèle apporte de nombreux avantages à l’entreprise utilisatrice :

* Gain de temps
* Réduction des coûts
* Définition des rôles et responsabilités plus précises
* Meilleure satisfaction des utilisateurs
* Meilleure productivité/efficacité
* Services IT de meilleures qualités
* Adaptation aux besoins des clients facilitée

Aujourd’hui, plus d’un million de professionnels sont formés et certifiés ITIL. Bien qu’il existe des alternatives comme COBIT, l’ITIL est reconnu comme la méthode la plus performante en termes de gestion des services dans le monde.  

**Quelques notes:**

    ITIL est la meilleure pratique la plus aboutie pour gérer les processus informatiques d'une entreprise    
      - Information Technologie Infrastructure Library  
      - Stratégie  
      - Conception  
      - Transition   
      - Exploitation  
      - Amélioration Continue  
    C'est devenu un prérequis dans les ESN  
    le niveau fondation 2/3j : base d'ITIL   
      - Niveau intermediaire lifecycle : w sur les différents détails du processus  
      - SS: service Stratégie  
      - Service Design  
      - Service Transition  
      - Service Opération  
      - CSI Continu Service Improvement   
      - 3j par crusus avec examen   
    Managing Across the Lifecycle 5j  
    L'ensemble donne Itil Expert.  

    ITIL est le moyen de nous structurer de maniere a fournir des services de passer a l'inforrmatique fournissant de  la technologie a l'informatique de service
    artisanale vers l'insdustriel.

    1er processus : gestion d'incident  
    n'as pas pour objectif de comprendre pourquoi mais d'assurer la continuité de service. l'incident doit géner le moins possible le client. (ne pas s'accès sur la technique).  
    L'ordre de répartation se fait en fonction de la necessité et non du cout.  
    2nd processus : gestion des niveaus de services.
    un SLA : c'est un contrat Service Level Agrement : codifie la relation entre le fournisseurr de service et le client. Definisse les obligations de l'un et de l'autre.  
    Help desk -> Accord sur les niveaux opérationnels (OLA Opérationnal Level Service ) 
    grace à ces SLA je vais pouvoir definir uun priorité d'urgence.
    3eme processus : gestion de catalogue de processus:  
    délimité le rôle et les services délivrés par l'IT.  
    Divisé en 2 partie : 
    la partie business, obtenir une imprimante, un renouvellement de PC,etc ...
    La partie technique: services utilisés en interne par l'IT pour forrnir le services business.  (masterisation d'un PC, Livraison du PC etc ...)
        - service de base qui fournit les résutlat essentiels  
        - service de soutien : service qui fournis le service de base
        - service réhaussé : service qui ajouté au service de base apporte une valeur ajouté.  

    processus : gestion des changement : tech et organisationnel.  
    changement standard : changer les choses qui n'ont pas d'impact  
    changement urgent :  ex mise en production et il y a un probleme qui vas crée un grave disfonctionnement ou une perte de donnée.  
    changement normal : pour tout le reste.

## **Appliquer les bonnes pratiques en centre de services (ITIL)**

### **Objectifs**

ITIL (Information Technology Infrastructure Library) est un ensemble de bonnes pratiques pour améliorer la production informatique au service des objectifs métiers de l'entreprise.

A l'issue de cette séance, le stagiaire sera capable , dans le cadre d'un centre de services (Hotline ou HelpDesk), de mettre en œuvre les processus de gestion d'incidents et de problèmes et communiquer avec l'équipe en charge du support aux utilisateurs dans un langage commun ITIL.

Lors de la résolution d'incidents ou problèmes avec un logiciel de gestion d'incidents (comme GLPI), le stagiaire sera capable de documenter correctement les incidents en se référant à ce vocabulaire ITIL .

Les processus ITIL visés dans cette séance sont ceux de la phase Exploitation de Services (Gestion des incidents, Gestion des problèmes, Gestion des événements, ...) et de la phase Transition de Services (Gestion des configuration, gestion des connaissances,...).

###  **Consignes**  

Assurez-vous que vous avez déjà saisi un ticket incident précédemment lors de la séance "Utiliser le logiciel de gestion d'incidents (GLPI)" et que la base de problèmes et de connaissances est déjà alimentée. Si ce n'est pas le cas alimentez la base par des exemples types.

Le stagiaire après lecture des documents "Sensibilisation à ITIL" et "ITIL-GestionIncidents" (voir ci-dessous) est amené à identifier le vocabulaire concrètement en analysant un ticket, un problème et un élément de la base de connaissances.

 
### **Vocabulaire**

La prise en charge professionnelle du support aux utilisateurs, exige des bonnes pratiques et l'adoption d'un vocabulaire commun à une équipe de Hotline ou Help Desk décrit dans le référentiel ITIL. En étudiant les documents "Sensibilisation à ITIL" et "ITIL-GestionIncidents" vous découvrirez ce référentiel et les termes couramment utilisés dans un service d'assistance.

Vous pouvez approfondir ce sujet en consultant le site Itil France : http://www.itilfrance.com/ et vos propres recherches sur Internet.

Créez votre propre lexique des termes ITIL les plus importants dans le contexte du métier de l'assistance aux utilisateurs à retenir, à titre d'exemple :

1. Définitions officielles

   * **Centre de services** : Le centre de services (CDS) est une fonction (au sens « département de l’entreprise ») de service d'assistance informatique de la partie « Soutien des Services » des bonnes pratiques ITIL. Son objectif est de servir de guichet unique aux utilisateurs pour leurs besoins de services informatiques. 
   La pratique Centre de services, en anglais service desk, est le point de contact unique entre les utilisateurs et le département informatique. Il est porteur de toute la relation avec les utilisateurs. Cette relation est bidirectionnelle : les utilisateurs appellent le centre de services pour communiquer avec le département informatique et lorsque celui-ci veut envoyer des messages d’information aux utilisateurs, il fait appel au centre de services. Le centre de services est responsable de l’information des utilisateurs au quotidien.  

   * **Fonction** : Une fonction est une unité organisationnelle avec ses ressources et ses moyens propres. C’est une équipe ou un ensemble d’équipes, avec un responsable qui les dirige. Une fonction est spécialisée dans la réalisation de certains types de travaux et garantit les résultats obtenus. Une fonction va prendre en charge une ou plusieurs activités d’un ou plusieurs processus. Une fonction est responsable des outils qu’elle utilise tant pour leur définition, leur choix et leur mise en œuvre. Une fonction sert à stabiliser les organisations.  

   * **Processus** : Les processus ITIL (Information Technology Infrastructure Library, ou Bibliothèque pour l’infrastructure des technologies de l’information en français) est un recueil de bonnes pratiques visant à améliorer le management des services informatiques (ITSM).  

   * **Rôle** : Un rôle est un ensemble de responsabilités et de domaines d’autorité attribués à un poste. Un rôle est un comportement face à une activité. Ce rôle va être ensuite affecté à une personne physique ou à une équipe de personnes. En règle générale, un rôle est défini dans un processus ou une fonction. Certains rôles sont liés aussi aux services. On va donc identifier des rôles qui sont détenus par les clients ou par les utilisateurs. Une personne physique ou une équipe de personnes peut endosser plusieurs rôles. Par contre les bonnes pratiques précisent que certains rôles sont incompatibles entre eux. On verra des exemples dans les chapitres suivants. On peut d’ores et déjà citer le rôle du gestionnaire des incidents qui ne doit en aucun cas être porté par la même personne que le rôle du gestionnaire des problèmes.  

   * **SLA** : La gestion des niveaux de service (en anglais SLM, Service Level Management) a pour but de maintenir et améliorer progressivement la qualité des services informatiques indispensables aux activités de l’entreprise. Le tout en s’assurant que les réalisations sur le plan des services soient soumises à un cycle d’approbation, de contrôle, de rapports et de révisions, et que les mesures nécessaires soient prises pour éliminer les niveaux inacceptables de service. Accords sur les niveaux de service (service level agreement ou SLA): ce sont les accords définis entre l’informatique (fournisseur) et le business (clients) pour déterminer les niveaux de prestation d’un service.  
    
   * **KPI** : En anglais, un KPI est un Key Performance Indicator. En français, c'est un indicateur clé de performance (ICP). Le KPI est là pour mesurer au fil du temps, afin de pouvoir se comparer à des entreprises similaires et de déterminer si l'on progresse ou si l'on régresse. L'objectif étant bien sûr de progresser et de ne pas être "à la traîne" par rapport à ses concurrents.  

   * **Gestion des Incidents** : La gestion des incidents a pour but de rétablir la communication entre les utilisateurs finaux et les agents informatiques au sein d'un service desk informatique, et de garantir la fluidité des opérations. L'entreprise suit un ensemble de bonnes pratiques pour gérer et résoudre les incidents de manière efficace. Celles-ci font partie du référentiel ITIL, qui vise à améliorer l'efficacité des services et la productivité.  

   * **Gestion des Problèmes** : « La gestion des problèmes vise à réduire le taux de probabilité et l’impact des incidents grâce à l’identification de leurs causes plausibles et effectives ainsi qu’à la gestion des contournements et des erreurs connues. ». La gestion des problèmes vous pousse à aller plus loin que la simple résolution d’incidents en exigeant d’identifier le problème à l’origine de cet incident. En conclusion, investir du temps et de l’argent dans la gestion des problèmes maintenant, c’est gagner du temps et de l’argent à terme. CQFD.  

   * **Gestion des Configurations** : Selon ITIL, le but de la Gestion des Configurations est de fournir un modèle logique de l’infrastructure IT en identifiant, contrôlant, maintenant à jour et vérifiant les versions de tous les Eléments de Configuration (CI) existants. La Gestion des Configurations se positionne au coeur d’une gestion efficace des services informatiques. Plus qu’un simple registre des biens informatiques, elle inclut la documentation, les accords de niveaux de service, les catalogues de service, les garanties et les articles de la Base de connaissances. Ainsi, la Gestion des Configurations fournit un service d’information facilitant la planification, la Mise en Production et la mise en oeuvre efficace et efficiente des Changements de service en informatique.  

   * **Erreur connue** : Une erreur connue décrit la solution de contournement permettant de résoudre (de façon temporaire ou permanente) des dysfonctionnements. Généralement, elle est mise en place suite à l'apparition d'un problème à l'origine d'incidents, mais elle peut également être créée en amont. Ainsi, via ITIL Enregistrement d'une erreur connue : une fois le diagnostic complété et une solution temporaire ou permanente identifiée, le problème devient une erreur connue. Ainsi, si d'autres incidents ou problèmes surviennent, ils peuvent être identifiés et le service restauré plus rapidement.  

   * **Escalade** : L’équipe de support doit-elle obtenir de l’aide de la part d’un autre service ? Si oui, on engage une procédure de demande de service sinon, la résolution de l'incident s’effectue au niveau du support initial.  

   * **Base de connaissances** : La mission du processus de la gestion de la connaissance est de fournir une information compréhensible et fiable pour permettre la prise de décisions à tous les instants du cycle de vie. Ce processus a un vrai objectif d’améliorer l’efficience dans toute la démarche ITIL, en mettant à disposition des autres processus un système de gestion de la connaissance (SKMS, Service Knowledge Management System).  

   * **CMDB** : Une base de données de gestion de configuration (Configuration Management Data Base) est un référentiel qui sert d'entrepôt de données pour les installations IT. Il contient des données relatives à un ensemble des actifs IT (communément appelés éléments de configuration ou configuration items (CI)), ainsi que des relations descriptives entre ces actifs. Une CMDB fournit une vue organisée des données de configuration et un moyen d'examiner ces données à partir de n'importe quel point de vue. Le dépôt fournit un moyen de compréhension : la composition des actifs critiques tels que les SI (systèmes d’information), les sources en amont ou les dépendances des actifs, les cibles en aval des actifs.  

   * **ITSM** : La gestion des services IT (ITSM) est une approche stratégique permettant de concevoir, de distribuer, de gérer et d'améliorer la manière dont la technologie de l'information (IT) est utilisée au sein d'une entreprise. L'objectif de la gestion des services IT est de garantir la mise en place des personnes, technologies et processus appropriés pour permettre à l'entreprise d'atteindre ses objectifs commerciaux.  

   * **RFC** : La demande de changement est le point d’entrée du processus de gestion des changements et globalement le point d’entrée de la phase de transition des services. Une demande de changement est un formulaire que le demandeur du changement doit remplir initialement, mais c’est aussi la fiche qui va suivre le changement jusqu’à sa clôture. De ce fait ce formulaire sera complété par le gestionnaire des changements pendant toute la vie du changement. Il faut définir des formulaires...  


2. Définitions rédigées (ROMAIN / RICHARD / BRUNO / JB)

   * **Centre de services:** C'est un département de l'IT d'une entreprise qui est dédié au support des utilisateurs.  

   * **Fonction:** Une unité organisationnelle avec ses ressources et ses moyens propres. C'est une équipe ou un ensemble d'équipe avec un responsable qui les dirige.  

   * **Processus:** Ensemble d'activités structurées conçues pour atteindre un objectif spécifique.  

   * **Rôle:** Ensemble de responsabilités, d'activités et d'autorités attribuées à une personne ou à une équipe. Le rôle est défini dans un processus qui lui-même est defini dans une fonction.    

   * **SLA:** _Service Level Agrement_: Accord entre un fournisseur de service informatique et un client.  

   * **KPI:** _Key Indicator of Perfomance_: Il permet de se comparer à des ESN similaires afin de mesure sa progression ou regression.  

   * **Gestion des Incidents:**  Processus qui assure la continuité des servicces. L'objectif est de maintenir l'activité avant de corriger le problème.  

   * **Gestion des Problèmes:** C'est l'anticipation des futurs problèmes et de determiner les problèmes récurrents afin de minimiser les impacts.  

   * **Gestion des Configurations:** C'est de maintenir à jour tout les éléments composant l'infrastructure IT tels que les MAJ logiciels, la documentation, les contrats, etc...  

   * **Erreur connue:** problème pour lequel il existe une documentation sur la ou les causes et ses solutions.  

   * **Escalade:** C'est le fait de redirigé un incident que l'on peut résoudre vers le niveau supérieur.  

   * **Base de connaissances:** C'est l'ensemble des connaissances des techniciens, de la documentation et des informations détenu par l'entreprise.  

   * **CMDB:** _Configuration Management DataBase_: Donnée relative à un ensemble des actifs, fournis une vue globale aux données de configuration et de les stockés.  

   * **ITSM:** _Information Technologie Services Management_: C'est la gestion des services informatiques, qui sont assurés par le centre de services. C'est le services de liaison.  

   * **RFC** _Request For Change_: Point d'entrée du processus des changements. C'est le document initial qui régis et lance la demande dans une infrastructure.  

3. Définitions Rédigées (Réalisé par Julie, Nicolas, Hamza et Rémi)

* **Centre de services:** Le service desk, ou centre de service IT, est conçu pour faire la liaison entre les utilisateurs au quotidien. Tout passe par le centre de service, pas de passe droit ou priorité car je connais.exemple utilisation de GLPI.  

* **Fonction:** Une fonction est une unité organisationnelle avec ses ressources et ses moyens propres. C’est une équipe ou un ensemble d’équipes, avec un responsable qui les dirige. Une fonction est spécialisée dans la réalisation de certains types de travaux et garantit les résultats obtenus. Une fonction va prendre en charge une ou plusieurs activités d’un ou plusieurs processus. Une fonction est responsable des outils qu’elle utilise tant pour leur définition, leur choix et leur mise en œuvre. Une fonction sert à stabiliser les organisations.  

Le schéma ci-dessous montre la relation entre les fonctions et les processus. Pour simplifier les fonctions sont verticales, inter-processus, les processus sont horizontaux, transverses, trans-fonctionnels.  

![Schéma ITIL1](https://raw.githubusercontent.com/RaspCric/In-girum-imus-nocte-et-consumimur-igni/images/Schema_fonction_processus.png)

Dans les bonnes pratiques ITIL, quatre fonctions sont définies:
  - Le centre de services.  
  - La gestion des opérations.  
  - La gestion des techniques.  
  - La gestion des applications.  

* **Processus:** C’est la démarche effectuée entre l'élément d'entrée et de sortie qui est documenté et suivi pour la traçabilité de l’entreprise. Ce qui permet pour une même demande avec la même entré de réutiliser ce processus

![Schéma n°2](https://raw.githubusercontent.com/RaspCric/In-girum-imus-nocte-et-consumimur-igni/images/tactique%20et%20processu.png)

* **Rôle:** Un ensemble de responsabilités, activités et prérogatives déléguées à une personne ou une équipe. Un rôle est défini pour un processus.
 
* **SLA** ou « entente de niveau de service » est un document qui définit la qualité de service, prestation prescrite entre un fournisseur de service et un client.  

* **KPI** ou “Key performance indicator” sont utilisés pour déterminer les facteurs pris en compte pour mesurer l'efficacité globale d'un dispositif commercial ou marketing ou celle d'une campagne ou action particulière.  

* **Gestion des Incidents:** l'objectif de la Gestion des Incidents est la suivante : « Restaurer aussi vite que possible le fonctionnement normal des services et minimiser l'impact négatif sur les activités métiers et s'assurer ainsi que les meilleurs niveaux de qualité de service et de disponibilité sont maintenus. »  

![Schéma n°3](https://raw.githubusercontent.com/RaspCric/In-girum-imus-nocte-et-consumimur-igni/images/gestion%20des%20incidents.png)

* **La gestion des configurations:** c’est un processus destiné à maintenir les systèmes informatiques, les serveurs et les logiciels dans l'état souhaité et à préserver la cohérence de cet état. C'est une façon de s'assurer qu'un système fonctionne comme prévu au fil des changements effectués.  

* **Erreur connue:** Une erreur connue décrit la solution de contournement permettant de résoudre (de façon temporaire ou permanente) des dysfonctionnements. Généralement, elle est mise en place suite à l'apparition d'un problème à l'origine d'incidents, mais elle peut également être créée en amont.  

* **Escalade:** Action de transférer un incident, un problème ou un changement à une équipe technique possédant un plus haut degré d’expertise afin d’aider le processus d’escalade. L’escalade peut être nécessaire au sein de tout processus de gestion des services informatiques, mais est le plus souvent associée à la Gestion des Incidents, à la Gestion des Problèmes et à la gestion des plaintes des clients. Il y a deux types d’escalades : escalade fonctionnelle et escalade hiérarchique.  

* **Base de connaissances:** Une base de connaissance sert à regrouper des connaissances spécifiques de manière centralisée accessible sur un ordinateur.  

* **CMDB:** Change Management Database ou Configuration Management Database en français est une base de données unifiant les composants d’un système informatique qui permet également d’en comprendre l’organisation et d’en modifier la configuration. Elle contient des informations sur les principaux composants du système d’information.

* **ITSM:** IT Service Management ou La gestion des services informatiques décrit une approche stratégique de la conception, la livraison, la gestion et l’amélioration de la façon d’utiliser les technologies de l’information dans l’entreprise. Le but de toute structure de gestion des SI est de s’assurer que les processus, les personnes et la technologie adéquats soient présents afin que l’entreprise puisse atteindre ses objectifs métier.

* **RFC:** Requests for Comments ou Demande de Commentaires, sont une série numérotée de documents décrivant les aspects et spécifications techniques d’internet ou de différents matériels informatiques comme un routeur ou un serveur DHCP. Les RFC sont classées selon cinq classifications qui sont:  
    Obligatoire
    Recommandée
    Facultative
    Limitée
    Non recommandé

Il y a également trois niveaux de maturité :  
    Standard proposé  
    Standard brouillon  
    Standard internet  

Lorsqu’un document est publié, un numéro de RFC lui est attribué et en cas d’évolution un nouveau document sera publié sous une autre référence.  

***Création d'un questionnaire***

- [Lien vers les réponses au formulaire n°1](https://forms.gle/azqCk9RnQavB8FiG9)  
- [Lien vers les réponses au formulaire n°2](https://forms.gle/4Cvsg4Tp1eYFXPBd7)  
  
![Réponses au questionnaire](https://raw.githubusercontent.com/RaspCric/In-girum-imus-nocte-et-consumimur-igni/images/questionnaire.png)  

- **Corrigé** :

1. 1, 3, 4 
2. ~~4~~ (corrigé : 3)
3. 2 
4. 2
5. 1
6. ~~1~~ (corrigé : 4)
7. 1, 3
8. ~~1~~ (corrigé : 2)
9. 2, ~~3~~, 5 (corrigé : 2, 4, 5)
10. 2, 3

# **RESSOURCES:** 

### **GLPI**
* [Site officiel de GLPI](https://glpi-project.org/fr/)  
* [Page Wikipedia](https://fr.wikipedia.org/wiki/Gestionnaire_Libre_de_Parc_Informatique)  
* [Page OpenCLassroom](https://openclassrooms.com/fr/courses/1730516-gerez-votre-parc-informatique-avec-glpi/5993301-decouvrez-la-gestion-de-parc-avec-glpi)  
* [Projet GLPI sur GitHub](https://github.com/glpi-project/glpi)  
* [Tutoriel installation via le site rdr-it.com](https://rdr-it.com/glpi-installation-configuration-de-base/)  
* [Tutoriel installation Via le site Neptunet (à privilégier)](https://neptunet.fr/install-glpi/)  

### **MariaDB**
* [https://neptunet.fr/install-glpi/](https://neptunet.fr/install-glpi/)  
* [MariaDB via Wikipedia](https://fr.wikipedia.org/wiki/MariaDB)
* [Infos MariaDB via doc-fedora](https://doc.fedora-fr.org/wiki/Installation_et_configuration_de_MariaDB)
* [Infos MariaDB](https://www.mariadbtutorial.com/)
* [Infos MariaDB via docs Ubuntu](https://doc.ubuntu-fr.org/mariadb)
* [Tuto MariaDB](https://www.geek17.com/fr/content/debian-10-buster-installer-et-configurer-mariadb-107)

### **Cerbot**

- [Letsencrypt, infos pour le HTTPS](https://letsencrypt.org/fr/getting-started/)  
- [Tutoriel SSL cerbot par memoinfo.fr](https://www.memoinfo.fr/tutoriels-linux/configurer-lets-encrypt-apache/)  
- [Utilisation de cerbot](https://certbot.eff.org/instructions)  
- [Cerbot, II](https://howto.wared.fr/ubuntu-certificats-ssl-tls-certbot/)  
- [Dépôts officiels Github](https://github.com/certbot/certbot)   


### **AD ET DNS**

- [Tutoriel pour l'installation d'un AD](https://technet365.fr/installation-active-directory-sur-windows-serveur-2019/)  
- [Qu'est-ce qu'un DNS via WIkipedia](https://fr.wikipedia.org/wiki/Domain_Name_System)  
- [Le DNS via le site frameip](https://www.frameip.com/dns/)  
- [Controller de domaine et domaine via it-connect](https://www.it-connect.fr/chapitres/controleur-de-domaine-et-domaine/)  
- [Rôle de l'herbergement de domaine et DNS via Wikipedia](https://fr.wikipedia.org/wiki/H%C3%A9bergement_de_nom_de_domaine)  
- [Explication des 5 rôles FSMO via le site it-connect](https://www.it-connect.fr/chapitres/les-cinq-roles-fsmo/)  
- [Infos Wikipedia sur les TLD](https://fr.wikipedia.org/wiki/Domaine_de_premier_niveau)  
- [Lignes de commandes CMD usuelles](https://www.ionos.fr/digitalguide/serveur/know-how/commande-cmd/)  

### **GESTION GLPI**

* [Configurer les intitulés](https://glpi-project.org/DOC/FR/glpi/config_dropdown.html)
* [Via le site GLPI](https://glpi-user-documentation.readthedocs.io/fr/latest/modules/configuration/intitules/index.html)
* [Injection en masse des données dans GLPI](https://neptunet.fr/glpi-data-injection/)
* [Lien Dell pour apport fabricants et config via it.zero.fr](https://it.izero.fr/glpi-ajout-plugin-imports-fabricants-et-configuration-pour-dell/)
-> bien lister les ensembles d'infos

### **FAQ GLPI**

- [Base de connaissance et FAQ](https://glpi-project.org/fr/base-de-connaissances-et-foire-aux-questions-faq/)  
- [Tools Knowbase via glpi-project](https://glpi-project.org/DOC/FR/glpi/tool_knowbase.html)  
- [Cours AFPA sur la FAQ](https://github.com/RaspCric/In-girum-imus-nocte-et-consumimur-igni/blob/pdf/base-de-connaissance-GLPI(1).pdf)  

### **ITIL**

* [Glossaire ITIL](https://wiki.octopus-itsm.com/fr/articles/Glossary)
* [Glossaire ITIL 2](https://www.itpms.fr/wp-content/uploads/2018/03/ITIL_2011_Glossary_FR-v1-1.pdf)  

### **LINUX** 

1. [Index en ligne des lignes de commandes Linux](https://opensharing.fr/index-des-commandes-linux)  
2. [Commandes USERs](https://doc.ubuntu-fr.org/commande_shell)
3. [Commandes utilisateurs](http://www2.ift.ulaval.ca/~beaulieu/linux/fr/man1/_index.html)  
4. [Les commandes fondamentales de Linux](http://wiki.linux-france.org/wiki/Les_commandes_fondamentales_de_Linux)  

_LEXIQUE_
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
