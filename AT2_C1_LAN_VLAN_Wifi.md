![](https://github.com/cromm24/Hello_World/blob/main/AT2/AT2C1/at2c1.png?raw=true)
# AT2C1 Maintenir et exploiter le réseau local et la téléphonie
---


![](https://www.informatique-chambery.fr/wp-content/uploads/2020/01/Bandeau-InformatiquePro2.jpg)
# ARCHITECTURE RESEAU, LAN ET VLAN  
----

# Introduction


Le [**routage**](https://fr.wikipedia.org/wiki/Routage) est le mécanisme par lequel des chemins sont sélectionnés dans un réseau pour acheminer les données d'un expéditeur jusqu'à un ou plusieurs destinataires. Le routage est une tâche exécutée dans de nombreux réseaux, tels que le réseau téléphonique, les réseaux de données électroniques comme Internet, et les réseaux de transports. Sa performance est importante dans les réseaux décentralisés, c'est-à-dire où l'information n'est pas distribuée par une seule source, mais échangée entre des agents indépendants. C’est grâce à ça que par exemple les mails sont envoyés aux bons destinataires. 

Le [**VLAN**](https://fr.wikipedia.org/wiki/R%C3%A9seau_local_virtuel) est un réseau local virtuel, communément appelé VLAN (pour Virtual LAN), est un réseau informatique logique indépendant. De nombreux VLAN peuvent coexister sur un même commutateur réseau. 

Le **routage dynamique** ou routage adaptatif1,2 est un processus au cours duquel un routeur transmet des données via différentes route ou vers différentes destinations en fonction de l'état des circuits de communication dans un système3.  

Il existe sur les routeurs certaines applications qui permettent aux routeurs voisins de s'échanger de l'information quant à leur tables de routage ; ce sont les protocoles de routage.  

Dans le routage statique, l'administrateur réseau doit informer (paramétrer) les routeurs pour leur donner des ordres de routage : sur quelle interface envoyer les datagrammes pour le réseau de destination d'adresse IP « X ». C'est une modification statique de la table de routage des routeurs. C'est long, fastidieux et pas très efficace et ne convient qu'à de petites structures.  

Si la configuration du réseau change souvent pour des raisons diverses (incident, coupure, changement de matériel, surcharge), alors il faut, pour maintenir le routage dans de bonnes conditions, que chaque routeur adapte sa table de routage à la nouvelle configuration. Cela n'est possible qu'à travers un processus automatique. C'est le rôle des protocoles de routage dynamiques.  

*Dans une table de routage, le terme de passerelle peut être remplacé par le terme de prochain saut (Next Hop). Dans les deux cas, il permet d’indiquer l’adresse IP du prochain routeur qui devra acheminer le datagramme IP vers sa destination. Le terme anglais est Gateway.*


Un petit rappel du modèle OSI:   
![Template OSI](https://github.com/cromm24/Hello_World/blob/main/AT2/AT2C1/template_osi.jpg?raw=true)  

On commence par deux mooc sur Openclassrooms:  
- [OpenClassroom_TCP-IP](https://openclassrooms.com/fr/courses/6944606-concevez-votre-reseau-tcp-ip)  
- [Openclassroom_fonctionnement des réseaux](https://openclassrooms.com/fr/courses/857447-apprenez-le-fonctionnement-des-reseaux-tcp-ip?status=published)  

**Ressources web:**  
- [Cours Wikibooks](https://fr.wikibooks.org/wiki/R%C3%A9seaux_TCP/IP/Routage_dynamique)  
- [Neptunet : introduction au routage dynamique](https://neptunet.fr/routage-ip-2/)  
- [Infos de base](https://www.frameip.com/)  

# Routage
---
## Routage interne sans NAT (manuel et rip) 

### Créer sous packet tracer les éléments suivants:  

1. 3 Réseaux:  
* Rézo1: 192.168.0.0/28  
* Rézo2:  172.16.0.0/18  
* Rézo3:  10.0.0.0/14  

2. Dans chaque sous réseaux, 2 postes:  
* PC0 et PC1 dans Rézo1  
* PC2 et PC3 dans Rézo2  
* PC4 et PC5 dans Rézo3  

3. Dans chaque sous réseaux, 1 switch catalyst 2950-24:  
* switch 0 dans rézo1   
* switch 1 dans rézo2  
* switch 2 dans rézo3  

4. Cabler avec du cable éthernet droit les postes aux switch:  
* PC0,PC2,PC4 sur prise 1  
* PC1,PC3,PC5 sur prise 2  

5. Attribuer les IP sur les postes clients:  
* PC0,PC2,PC4 ont la première IP possible  
* PC1,PC3,PC5 la deuxième  
* La passerelle pour chaque poste est la dernière adresse possible de chaque réseaux.  

6. Ensuite poser deux routeurs entre chaque réseau:  
* Chaque routeur (cisco1840) possède 2 cartes éthernet (0/0 et 0/1):  

    * Routeur0 est entre Rézo1 et Rézo2  
        * Son interface 0/0 est la dernière adresse possible de Rézo1 et se branche sur switch0 sur la prise 24  
        * Son interface 0/1 est l’avant dernière adresse possible de Rézo2 et se branche sur switch1 sur la prise 23  
    * Routeur1 est entre Rézo2 et Rézo3  
        * Son interface 0/0 est la dernière possible de rézo2 et se branche sur switch1 sur la prise 24  
        * Son interface 0/1 est la dernière possible de rézo3  et se branche sur switch2 sur la prise 24  

**Consignes:**  

1ère partie:  
Le but est d’activer des routes dans les routeurs pour que PC0 pingue PC5.  
PC0 doit pinguer l’interface 0/1 de Router0 mais pas PC2, pourquoi?  
PC2 par contre peut pinguer PC5, pourquoi?  

2nd partie:  
Quand tous les postes peuvent se pinguer alors modifier l’exercice en changeant ces points:  
- Rézo4: 192.168.1.0/25 en rajoutant un cable qui part de switch2 vers Rézo4.  
- Activer RIP au lieu de faire des routes manuelles.  

**Résultat:**

Partie 1:  
![*](https://github.com/cromm24/Hello_World/blob/main/AT2/AT2C1/Exo1_PT_Route.jpg?raw=true)

Partie 2:  
![](https://github.com/cromm24/Hello_World/blob/main/AT2/AT2C1/Exo1_pt_rip.jpg?raw=true)

## Architecture Routage interne sans NAT type université

### Etude de cas de ce concours [ASI](https://concours.univ-lyon1.fr/annales-des-concours/bap-e/annales-bap-e-assistant-ingenieur)

Résoudre la deuxième question sur le routage de ce concours d'assistant ingénieur dans ce pdf (La question est dans les premières pages, le schéma à la fin).  
Le corrigé est **[ici](https://github.com/cromm24/Hello_World/raw/main/AT2/AT2C1/asi_2007_corrige%CC%81.pdf)** mais faites le tout seul dans un premier temps.  

**Résultat:**
![](https://github.com/cromm24/Hello_World/blob/main/AT2/AT2C1/asi_routage.jpg?raw=true)  

### Ensuite deuxième cas pratique...

Créer le schéma de l’université Miskatonic suivant les éléments suivants:

Dans chaque réseau l’adresse de la passerelle *(donc de l’interface réseau sur un routeur)* est la dernière possible:  

1. Bâtiment A avec:  
* 1 salle serveur en 2 parties:  
    * serveur-lan 10.0.0.0/25:  
        *  la première IP possible est pour venus(dhcp multipool)  
        * la seconde pour jupiter (ad miskatonic.edu,dns)  
        * la troisième pour saturne (partage de fichiers)  
        * la quatrième pour mars (sgdb sql server)  
        * la cinquième pour mercure (messagerie imap)  
    * serveur-dmz 10.0.0.128/25:
        * la première ip possible pour io(smtp)  
        * la seconde pour europe(web)  
        * la troisième pour pluton(proxy)    
* 1 salle étudiant1 172.16.0.0/24
* 1 salle administratif1 192.168.10.0/25
* 1 salle enseignant1 192.168.20.0/25
* 1 routeur R1 (avec N interfaces d’interco WAN et LAN)

2. 1 Bâtiment B avec:  
* 1 salle étudiant2 172.16.1.0/24  
* 1 salle administratif2 192.168.10.128/25  
* 1 routeur R2 (avec N interfaces d’interco et LAN)  

3. 1 Bâtiment C avec:  
* 1 salle étudiant3 172.16.2.0/24  
* 1 salle enseignant2 192.168.20.128/25  
* 1 routeur R3 (avec N interfaces d’interco et LAN)

Chaque salle d’enseignant, d'admin et d’étudiant sont équipés de poste client classique en DHCP.  

Il existe un réseau d’interco AB entre R1 et R2 192.168.100.0/30  
Il existe un réseau d’interco AC entre R1 et R3 192.168.100.4/30  
Le routeur WAN possède l’adresse 193.168.100.14/29  
R1 est toujours la première adresse possible  

Créer le schéma réseau sous visio ou draw.io et la table de routage sous excel  

**Résultat:**  
![schéma](https://github.com/cromm24/Hello_World/blob/main/AT2/AT2C1/exo2_schema_infra.png?raw=true)  
![routage](https://github.com/cromm24/Hello_World/blob/main/AT2/AT2C1/exo2_routage.jpg?raw=true)     

**Le corrigé de Thomas:**    
![schéma](https://github.com/cromm24/Hello_World/blob/main/AT2/AT2C1/Exo2_schema_infra_thomas.png?raw=true)  
![routage](https://github.com/cromm24/Hello_World/blob/main/AT2/AT2C1/Exo2_routage_thomas.png?raw=true)  

## Subnetting

Le NetAdmin d’oceanic airlines nous demande de diviser la plage 10.10.10.0/23 en sous-réseau:  
* hangar 18 - 150 postes
* red sector A - 90 postes
* neutral zone - 46 postes
* stalag 13 - 29 postes

Vous pouvez “subnetter” en asymétrique décroissant et la solution doit être proposé décomposé dans un fichier au format txt

**Résultat:**  

10.10.10.0/23 donc le netmask est 255.255.254.0  

| * | Hangar 18 de 150 postes| Red Sector A de 90 postes | Neutral Zone de 46 postes | Stalag de 29 postes |    
|:-:|:----------------------:|:-------------------------:|:------:|:----:|   
| Explication | on prend la puissance de 2 supérieur or: 256 > 150 > 128, donc ca donne 2^7 donc on utilise un masque en /24 (où l'on peut mettre 254 adresses) | on prend la puissance de 2 supérieur or: 128 < 90 < 64, donc ca donne 2^6 donc on utilise un masque en /25 (Où l'on peut mettre 126 adresses) | on prend la puissance de 2 supérieur or : 64 > 46 > 32, donc ca donne 2^5 donc on utilise un masque en /26 (Où l'on peut mettre 62 adresses) | on prend la puissances de 2 supérieur or: 32 > 29 > 16, donc ca donne 2^4 donc on utilise un masque en /27 (Où l'on peut mettre 30 adresses) |  
| Première adresse | 10.10.10.1 | 10.10.11.1 | 10.10.11.129 | 10.10.11.193 |  
| Dernière adresse | 10.10.10.254 | 10.10.11.126 | 10.10.11.190 | 10.10.11.222 |  
| Broadcast | 10.10.10.255 | 10.10.11.127 | 10.10.11.191 | 10.10.11.223 |  
| Netmask | 255.255.255.0 | 255.255.255.128 | 255.255.255.192 | 255.255.255.225 |   

## Exercice Complémentaire

### Exercice du Belge

https://www.sebastienadam.be/connaissances/exercices/adressage_ip_v4.php  

#### **Adressage IPv4** - **Masque Réseau 1**  

Pour les adresses suivantes:  
- 145.245.45.225  
- 202.2.48.149  
- 97.124.36.142  

Donnez:  
1. La classe d'adresse.  
2. Le masque réseau par défaut.  
3. L'adresse réseau.  
4. Le masque modifié si les réseaux comportent respectivement (1) 60, (2) 15 et (3) 200 sous-réseaux.  
5. L'adresse du sous-réseau et son numéro.  
6. Le numéro de la machine sur le sous-réseau.  

|*|**145.245.45.225**|**202.2.48.149**|**97.124.36.142**|    
|:-:|:----------------:|:--------------:|:---------------:|  
|1|Classe B|Classe C|Classe A|   
|2|Masque /16|Masque /24|Masque en /8|   
|3|145.245.0.0|202.2.48.0|97.0.0.0|   
|4|Pour 60 sous-réseaux, 2^6=64 donc on passe les 6 premiers bit du masque a 1|Pour 15 sous-réseaux, 2^3=16 donc on passe les 3 premiers bit du masque a 1|Pour 200 sous-réseaux, 2^8=128 donc on passe les 8 premiers bit du masque a 1|  
|4|/22 : 145.245.44.0|/28 : 202.2.48.144|/8 : 91.124.0.0|  
|5|145.245.44.0, 11ème réseau|202.2.48.144, 9ème réseau|97.124.0.0, 124ème réseau|   
|6|481ème machine|5 machine|9358 machine|  

*Exemple détaillé pour le 1er cas*

|**Découpage**|**Eplication**|
|:----------------:|:----------------:|
|145.245.45.225|Adresse Ip|
|10010001.11110101.00101101.11100001|Adresse Ip en binaire|
|11111111.11111111.00000000.00000000|Masque en binaire|
|11111111.11111111.**111111**00.00000000|Sous-réseau en bianire (réf Q4)|
|10010001.11110101.001011**01.11100001**|N° de la machine dans ce sous réseau|

#### **Adressage IPv4** - **Masque Réseau 2**   

Pour les adresses suivantes :  
172.24.245.25  
212.122.148.49  

Donnez :   
1. La classe d'adresse.  
2. Le masque réseau par défaut.  
3. L'adresse réseau.  
4. Le masque modifié si les réseaux comportent respectivement (1) 200 et (2) 20 machines.  
5. L'adresse du sous-réseau et son numéro.  
6. Le numéro de la machine sur le sous-réseau.  

|*|**172.24.245.25**|**212.122.148.49**|  
|:-:|:--------------:|:---------------:|  
|1|Classe B|Classe C|  
|2|Masque /16|Masque /24|  
|3|172.24.0.0|212.122.148.0|  
|4|Pour 200 adresses, il faut 2^8=256 donc on passe les 8 derniers bits à 1|Pour 20 adresses, il faut 2^=256 donc on passe les 8 derniers bits à 1|Pour 20 adresses, il faut 2^5=32 donc on passe les 5 derniers bits à 1|  
|5|172.24.0.0, 245ème adresse|212.122.148.32, Xème adresse|
|6|25ème machine|17ème machine|

#### **Routage 1**

Voici le réseau 172.27.0.0. Donnez les tables de routage des machines A à D.  

Voici le rézo sous Packet Tracer pour plus de lisibilité(hahaha):  
![*](https://github.com/cromm24/Hello_World/blob/main/AT2/AT2C1/Belge_PT.jpg?raw=true)  
Voilà la table de routage des machines A, B et C:  
![*](https://github.com/cromm24/Hello_World/blob/main/AT2/AT2C1/Belge_table.jpg?raw=true)  


### Exercice ENI  

https://www.editions-eni.fr/open/mediabook.aspx?idR=396c790cfc397a1903246982621a2cb3

Les exercices suivants abordent le routage. La configuration de routeur peut se faire de façon statique ou dynamique. Dans les deux cas, il est utile de connaître le processus de routage de façon à pouvoir sécuriser et améliorer ce service.   

*Le terme de passerelle peut être remplacé par le terme de prochain saut (Next Hop). Dans les deux cas, il permet d’indiquer l’adresse IP du prochain routeur qui devra acheminer le datagramme IP vers sa destination. Le terme anglais est Gateway.*     

**1. Exercice 1**  
Donnez les tables de routage de chaque routeur. Ne précisez que les routes à ajouter à la table de routage. On peut noter l’Internet par 0.0.0.0/0.  
![*](https://github.com/cromm24/Hello_World/blob/main/AT2/AT2C1/Exo_eni1.png?raw=true)  

**2. Exercice 2**  
Donnez les tables de routage de chaque routeur. Ne précisez que les routes à ajouter à la table de routage. On peut noter l’Internet par 0.0.0.0/0.  
![*](https://github.com/cromm24/Hello_World/blob/main/AT2/AT2C1/Exo_eni2.png?raw=true)  

**3. Exercice 3**  
Donnez les tables de routage de chaque routeur. Ne précisez que les routes à ajouter à la table de routage. On peut noter l’Internet par 0.0.0.0/0.  
![*](https://github.com/cromm24/Hello_World/blob/main/AT2/AT2C1/Exo_eni3.png?raw=true)   

**Résultat:**  
![*](https://github.com/cromm24/Hello_World/blob/main/AT2/AT2C1/Exo_eni.jpg?raw=true)  


### Exercice P4

![](https://github.com/cromm24/Hello_World/blob/main/AT2/AT2C1/ExoP4_plan.jpg?raw=true)  
![](https://github.com/cromm24/Hello_World/blob/main/AT2/AT2C1/ExoP4_topo.png?raw=true)  
![](https://github.com/cromm24/Hello_World/blob/main/AT2/AT2C1/ExoP4_PT2.jpg?raw=true)  

### Exercice Word-Alain

#### Partie 1

**Exercice 1 (classes d’adresses):**  
Quelles sont les classes des adresses réseaux suivantes ?  
Combien d’adresses machines peuvent être utilisées par chacune ?  
- 204.160.241.93
- 138.96.32.3 
- 18.181.0.31  
- 226.192.60.40  

**Exercice 2 (sous réseaux et netmask):**   
Supposez qu’au lieu d’utiliser 16 bits pour la partie réseau d’une adresse IP de classe B on utilise 22.  

Combien de sous-réseaux est-il alors possible de définir ?  
Donnez le masque de sous-réseaux correspondant.  

**Exercice 3 (sous réseaux):**  
Un réseau de classe B dispose du masque de sous-réseau 255.255.240.0.  
Quel est le nombre maximum d’ordinateurs que l’on peut raccorder à chaque sous-réseau ?  
Combien de sous-réseaux y a-t-il ?  

**Exercice 4 (routage):**   
Une commande show ip route appliquée à un routeur donne le résultat suivant:  
![](https://github.com/cromm24/Hello_World/blob/main/AT2/AT2C1/ExoWordAlain4.png?raw=true)  
Donner la topologie du réseau que vous pouvez déduire de cette table.  

**Exercice 5 (routage):**  
On considère le réseau, représenté par la figure 1, où la machine MA souhaite envoyer un datagramme à la machine MB. Les deux machines n'étant pas sur le même sous-réseau, le datagramme va donc devoir être routé via les deux routeurs R1 et R2. Ce réseau Internet est supporté par trois réseaux physiques Ethernet (3 réseaux IP) dont les adresses Internet, de classe C et de masque 255.255.255.0, sont 193.2.2.0, 193.5.5.0 et 193.8.8.0.  
1. Donnez les adresses source et destination du paquet IP prêt à être envoyé préparé sur MA 
2. Donnez les tables de routage initiales les plus simples (minimales), sur chaque machine (MA, R1, R2 et MB), permettant l'acheminement du paquet de MA vers MB. 3. Donnez les étapes successives nécessaires à cet acheminement, en précisant les adresses utilisées dans les en-têtes des trames Ethernet envoyées pour transporter le paquet ci-dessus.  
![](https://github.com/cromm24/Hello_World/blob/main/AT2/AT2C1/ExoWordAlain5.png?raw=true)  

#### Partie 2

**Exercice 1 - plan d’adressage:**  
A.	Quels hotes comportent un masque de sous-réseau incorrect ?  
B.	En quoi un masque de sous-réseau invalide affecte-t-il ces hôtes ?  
C.	Quel est le masque de sous-réseau correct ?  
![*](https://github.com/cromm24/Hello_World/blob/main/AT2/AT2C1/ExoWordAlain1.png?raw=true)

**Exercice 2 - Détermination du nombre de bits à utiliser pour l’ID sous-réseau:**  
Dans cet exercice, vous devez déterminer combien de bits sont nécessaires pour créer le nombre de sous-réseaux demandés:    
- CAS 1	84 sous-réseaux	 
- CAS 2	145 sous-réseaux  
- CAS 3	7 sous-réseaux	 
- CAS 4	1 sous-réseau	
- CAS 5	15 sous-réseaux	 

**Exercice 3 – Questions de vitesse, de débit et de temps:**  
Un réseau local est destiné à transférer deux types d’informations:  
- Des fichiers texte de 100KO maximum et un temps de transmission minimal de 5s.  
- Des messages interactifs de cent caractères au maximum transmis en moins de 5ms.  

Question 1: Quel est le nom du code informatique historiquement le plus ancien, servant au codage des caractères ?  
Question 2: Sur combien d’octet, ce code, code les caractères ?  
Question 3: Calculer le débit nécessaire pour transférer les fichiers texte, tel que défini dans l’introduction.  
Question 4: Calculer le débit nécessaire pour transférer les messages.  

**Exercice 4 – Routage:**  
Compléter les tables de routages minimales de la machine 112.3.45.67 et du routeur R1.  
![](https://github.com/cromm24/Hello_World/blob/main/AT2/AT2C1/ExoWordAlain4bis.png?raw=true)  

**Exercice 5:**  
En utilisant l’adressage par classe, l’adresse 190.24.12.8/16 fait partie de quel réseau ?  
A -  190.0.0.0  
B - 190.255.255.255  
C - 190.24.0.0  
D- 190.24.12.0  
E - 0.12.24.190  

**Exercice 6:**   
Quel est le rôle du masque de réseau ?   
A -	Il permet de cacher l’adresse IP  
B -	Il détermine l’adresse d’un réseau IP à partir de l’adresse IP d’un poste ?  
C -	Il détermine l’adresse du poste dans le réseau IP  
D -	Il permet de crypter les communications sur le réseau IP  

**Exercice 7:**   
Un réseau a comme masque 255.255.255.224  
Combien de machines peut-il y avoir sur un tel réseau ?    
A – 254  
B – 128  
C – 224  
D – 30  

**Exercice 8:**  
Quel est le masque d’un réseau 193.16.1.0/24 ?  
A – 255.0.0.0  
B – 255.255.0.0  
C – 255.255.255.0  
D – 255.255.255.24  

**Exercice 9:**  
Si une machine possède la configuration IP 97.24.19.252/19, l’adresse 97.24.19.0 peut-elle être assignée à un hôte de son sous-réseau ?  
A -	OUI  
B -	NON  

**Exercice 10:**   
Si une machine possède la configuration IP 184.252.83.109/29, combien d’adresses pourront être assignées aux autres hôtes de son sous réseau ?  
A – 8  
B – 7  
C – 6  
D – 5  

**Exercice 11:**   
Quel est l’adresse IP de la boucle locale ?  
A - 128.0.0.1  
B - 127.0.0.1  
C - 127.0.0.0  
D - 126.0.0.1  

**Exercice 12:**  
L’adresse IP 192.168.255.1 est une :  
A – Adresse de broadcast  
B – Adresse publique  
C – Adresse routable sur internet  
D – adresse privée d’un poste  

**Exercice 13 – Routage:**  
Ce réseau est constitué de deux routeurs possédant les tables de routage décrites dans la figure centrale.  
![](https://github.com/cromm24/Hello_World/blob/main/AT2/AT2C1/ExoWordAlain13.png?raw=true)			
Compléter la table de routage du routeur de gauche  
Compléter la table de routage du routeur de droite  

**Corrigé en pdf: [P1](https://github.com/cromm24/Hello_World/raw/main/AT2/AT2C1/ExoWordAlain_P1_Corrig%C3%A9.pdf) et [P2](https://github.com/cromm24/Hello_World/raw/main/AT2/AT2C1/ExoWordAlain_P2_Corrig%C3%A9.pdf)**  


# Vlan - Théorie
----

**Ressources:**
1. [http://fr.wikipedia.org/wiki/R%C3%A9seau_local_virtuel](http://fr.wikipedia.org/wiki/R%C3%A9seau_local_virtuel)  
2. [http://fr.wikipedia.org/wiki/VLAN_Trunking_Protocol](http://fr.wikipedia.org/wiki/VLAN_Trunking_Protocol)  
3. [http://en.wikipedia.org/wiki/Virtual_LAN](http://en.wikipedia.org/wiki/Virtual_LAN)  
4. [http://www.commentcamarche.net/contents/543-vlan-reseaux-virtuels](http://www.commentcamarche.net/contents/543-vlan-reseaux-virtuels)  
5. [http://www.frameip.com/entete-ethernet/#VLAN_ID](http://www.frameip.com/entete-ethernet/#VLAN_ID)  
6. [http://c2.touta.in/?p=1188](http://c2.touta.in/?p=1188)  
7. [Concept de VLAN via Cisco](https://cisco.goffinet.org/ccna/vlans/concepts-vlan-cisco/)
8. [Configuration VLAN Cisco iOS](https://cisco.goffinet.org/ccna/vlans/configuration-vlan-cisco-ios/)  
9. [Cours labo-cisco](www.labo-cisco.com/fr/articles/administration-reseaux/vlan.html)
10. [Cours iONOS](https://www.ionos.fr/digitalguide/serveur/know-how/fondamentaux-vlan/)  
11. [Un site bien fait sur les VLAN/Trunck](https://formip.com/trunk/)  
12. [Configuration VLAN sur switch Cisco](https://www.clemanet.com/switch-vlan-cisco.php)
13. [Configuration des VLANs sous Cisco IOS](https://cisco.goffinet.org/ccna/vlans/configuration-vlan-cisco-ios/)
14. [Norme 802.1Q avec explication de l'encapsulation](https://en.wikipedia.org/wiki/IEEE_802.1Q)
15. [IT-connect : mise en place vlan/routage inter vlans](https://www.it-connect.fr/mise-en-place-de-vlans-et-de-routage-inter-vlans/)
16. [attaque de switch-ethernet](https://www.frameip.com/attaque-protection-switch-commutateur-ethernet/?video=140#video-140)

**Définition:**

Un réseau local virtuel, communément appelé VLAN (pour Virtual LAN), est un réseau informatique logique indépendant. De nombreux VLAN peuvent coexister sur un même commutateur réseau (switch).    
*Trunck/Acces et TAG/UNTAG, la qualification du VLAN*  


## Les VLAN présentent différents intérêts:  

**Segmentation:** réduire la taille d'un domaine de broadcast.  

**Flexibilité:** possibilité de travailler au niveau 2 (couche liaison) ou au niveau 3 (réseau). Les VLAN fonctionnent au niveau de la couche 2 du modèle OSI. Toutefois, un VLAN est souvent configuré pour se connecter directement à un réseau IP, ce qui donne l'impression de travailler plutôt au niveau de la couche 3. Les VLAN peuvent aussi se baser sur les ports physiques des commutateurs (attention à ne pas confondre les ports « physiques » avec les ports « logiques » du protocole) (en anglais : « port-based »), ce qui correspond au niveau 1 du modèle OSI et non au numéro de port du niveau 4 (par exemple : le port 80 en TCP qui "pointe" vers le service HTTP).  

**Sécurité:** permet de créer un ensemble logique isolé pour améliorer la sécurité. Le seul moyen pour communiquer entre des machines appartenant à des VLAN différents est alors de passer par un routeur.  


## Il existe 3 différents type de VLAN :


**VLAN de niveau 1 (ou VLAN par port):** Il faut ici inclure les ports du commutateur qui appartiendront à tel ou tel VLAN. Cela permet entre autres de pouvoir distinguer physiquement quels ports appartiennent à quels VLAN.  

**VLAN de niveau 2 (ou VLAN par adresse MAC):** Ici l'on indique directement les adresses MAC des cartes réseaux contenues dans les machines que l'on souhaite voir appartenir à un VLAN, cette solution est plus souple que les VLAN de niveau 1, car peu importe le port sur lequel la machine sera connectée, cette dernière fera partie du VLAN dans lequel son adresse MAC sera configurée.  

**VLAN de niveau 3 (ou VLAN par adresse IP):** Même principe que pour les VLAN de niveau 2 sauf que l'on indique les adresses IP (ou une plage d'IP) qui appartiendront à tel ou tel VLAN.  

Pour déployer des VLAN, cela sous entend que le commutateur utilisé soit gérable et qu'il gère les VLAN du niveau désiré, à savoir également que plus le niveau de VLAN est élevé, plus le commutateur sera cher à l'achat.  


## Trunk


*Pour que les VLAN soient propagés sur différents commutateurs à partir d'un seul lien physique via « trunk », l'organisme IEEE a développé la norme 802.1Q. **IEEE 802.1Q**, qui succède à ISL, est aujourd'hui le protocole prédominant.*  

Dans le contexte de VLAN, le terme **trunk** indique un lien de réseau supportant des VLAN multiples entre 2 commutateurs ou entre un commutateur et un routeur, cela fonctionne en utilisant un protocole adapté. En effet pour tenir compte des raccordements multiples sur un lien, les trames d'un VLAN doivent être identifiées avec un protocole commun.  

Il existe deux protocoles :  
* Le protocole IEEE 802.1Q ajoute une étiquette à l'en-tête du paquet Ethernet, la marquant comme appartenant à un certain VLAN, ceci est la méthode préférée maintenant et la seule option valable dans un environnement avec des équipements de fournisseurs multiples.  
* Le protocole propriétaire Inter Switch Link (ISL) pour la virtualisation de réseau local. Il encapsule la trame Ethernet avec sa propre encapsulation, et marque la trame comme appartenant à un VLAN spécifique, dans un réseau composé d'équipement de commutation de la marque Cisco.  

## Divers

**Broadcast:**

Configurer des vlans dans un switch revient en pratique à découper le switch en autant d'autres petits switchs isolés les uns des autres : un vlan est un réseau isolé à part entière. Ceci permet, de réduire la taille du Domaine de Broadcast, donc une bonne partie de traffic inutile. Les broadcast sont des trames destinées à tous les utilisateurs d'un réseau : ils sont donc diffusés sur tous les ports d'un même réseau (vlan)/domaine de broadcast.  
Plus le nombre de machines dans un réseau s'accroit, plus le pourcentage de bande utilisé par les broadcasts augmente.  
Les broadcast ne sont arrêtés que par les routeurs, il faut donc des routeurs pour interconnecter différents vlans.  

**Sécurité:**

On peut également être amené à créer des vlans pour séparer dans un but de sécurité, de confidentialité. On peut très bien relier des réseaux ip différents sur un même switch dans le même vlan, cela fonctionnera, mais la confidentialité ne sera pas assurée et les broadcast d'un réseau se mélangeront à ceux de l'autre.

**Routeur:**

Il existe aussi des switchs qui incorporent la fonction de routeur.  
Ces switch L2/L3 permettent le routage entre ces différents vlans.  


1. On affecte un nom unique au vlan.  
2. On affecte un Id (nbre compris entre 1 et 4095). La façon la plus courante d'utiliser les vlans est celle de vlan par port.  
3. On affecte ensuite un Id à des ports, celui de l'un de 2 vlans qu'on a fait, créant ainsi une matrice de commutation étanche, créant un switch logique.  

A ce moment là, tous les PC qui se trouvent connecté à un port possédant le même vlan Id (situés dans le même vlan donc) peuvent se pinger (pour peu que leur IP respectives soient dans le même réseau).  


C'est là qu'intervient la fonction L3. Avec ces switchs, on peut créer une interface IP logique qu'on associe au vlan Id. On va ainsi pouvoir permettre le routage entre les différents vlan dès qu'on auras déclaré ces IP en tant que passerelle par défaut des PC.  

# Vlan - Pratique
---

## Exercice 1 - Vlan de niveau 1

*Sur packet tracer*  

Réaliser un pkt selon l'image ci-dessous:  

![*](https://github.com/cromm24/Hello_World/blob/main/AT2/AT2C1/Exo1_vlan.jpg?raw=true)

Voici le brief des commandes CLI IOS de Cisco dans le tableau ci-dessous, essayer de ne pas les écrire sans les comprendre.

|Image|Commande|
|:-:|:-:|  
|![*](https://github.com/cromm24/Hello_World/blob/main/AT2/AT2C1/Exo1_configsw.jpg?raw=true)| > `enable` > `configure terminal` > `vlan 2` > `name tech` > `exit` > `vlan 3` > `name compta` > `exit` > `exit` |
|![*](https://github.com/cromm24/Hello_World/blob/main/AT2/AT2C1/Exo1_configsw2.jpg?raw=true)| > `show vlan` |  
|![*](https://github.com/cromm24/Hello_World/blob/main/AT2/AT2C1/Exo1_configsw3.jpg?raw=true)| > `enable` > `configure terminal` > `interface FastEthernetO/1` > `switchport access vlan 2` > `exit` > `interface FastEthernetO/2` > `switchport access vlan 2` > `exit` > `interface FastEthernetO/3` > `switchport access vlan 3` > `exit` > `interface FastEthernetO/4` > `switchport access vlan 3` |  


*Remarques:*  
- N’oubliez pas d’activer l'interface0/0 sur le routeur  
- Attention chez Cisco le vlan 1 est le vlan d’administration réservé  
- PC0 et PC1-> vlan02 (services tech)  
- PC2 et PC3-> vlan03 (services compta)  
- Configurer les vlan dans le switch  

**Le but est que PC0 et PC1 soient cloisonné dans un VLAN et que PC2 et PC3 soient cloisonnés dans un autre.**

**Résultat:**  
![](https://github.com/cromm24/Hello_World/blob/main/AT2/AT2C1/Exo1_vlan2.jpg?raw=true)  

## Exercice 2

*Sur packet tracer*  

Réaliser un pkt selon l'image suivante:  
![*](https://github.com/cromm24/Hello_World/blob/main/AT2/AT2C1/Exo2_exemple.jpg?raw=true)   
- 2 switchs catalyst 2960
- 1 Rézo classe C /24
- 2 VLANs
- 5 postes clients
- 1 Trunk

**Le but est de déclarer la base des Vlanid et ensuite configurer le trunk (essayer de trouver les commandes pour réaliser le trunk qui fait passer le trunk pour titi), dans chaque switchs. Enfin le PC05 doit pinguer le PC04 mais pas le PC01**  

**Résultat:**

![*](https://github.com/cromm24/Hello_World/blob/main/AT2/AT2C1/Exo2.jpg?raw=true)

## Exercice 3

Se familiariser avec l’interface et les commandes des switches

Cisco CCNA exploration 11-5-1-2

Trouver une Cheat sheet IOS en pdf: 
- [Ciquez ici pour la télécharger](https://cheatography.com/tamaranth/cheat-sheets/basic-cisco-ios-commands/pdf/)
- [Cliquez ici pour en télécharger une autre](https://github.com/cromm24/Hello_World/raw/main/AT2/AT2C1/Cisco%20Cheat%20Sheet%20CLS%20IOS.pdf)    

**Cisco Cheat Sheet CLS IOS**  

![](https://github.com/cromm24/Hello_World/blob/main/AT2/AT2C1/steel_sheet_1.jpg?raw=true)
![](https://github.com/cromm24/Hello_World/blob/main/AT2/AT2C1/steel_sheet_2.jpg?raw=true)

## Exercice 4

*Sur Packet Tracer*   

Réaliser un pkt selon l'image suivante:   
![*](https://github.com/cromm24/Hello_World/blob/main/AT2/AT2C1/Exo4_exemple.jpg?raw=true)
- 1 switch
- 3 sous Rézo
- 6 postes
- 1 router avec subnetting de gateway

**Le but est que PC6 doit pinguer tout les vlans. Mais les vlans doivent être compartimenté.**

**Résultat:**
![*](https://github.com/cromm24/Hello_World/blob/main/AT2/AT2C1/Exo4.jpg?raw=true)

Lire la [vidéo](https://youtu.be/TDVih6U_fRw)

## Exercice 5

*Sur Packet Tracer*   

Réaliser un pkt selon l'image suivante:  
![](https://github.com/cromm24/Hello_World/blob/main/AT2/AT2C1/Exo5.png?raw=true)
- 3 switches
- 1 Rézo
- 6 postes
- 2 VLAN
- 2 Trunk
- 1 VTP master-client

*Faire les paramêtrages en commmande CLI*  

**Résultat:**
![](https://github.com/cromm24/Hello_World/blob/main/AT2/AT2C1/Exo5_resultat.jpg?raw=true)

## Aparté

*Voir ensuite la video VTP de **[frameIP](https://www.frameip.com/attaque-protection-switch-commutateur-ethernet/?video=140#video-140)***

## Exercice 6

*Sur Packet Tracer*   

Réaliser un pkt selon l'image suivante:  
![](https://github.com/cromm24/Hello_World/blob/main/AT2/AT2C1/Exo6.png?raw=true)  
- 1 switch
- 3 sous-réseaux
- 6 postes
- 1 router avec subnetting de gateway

*Faire les paramêtrages en commmande CLI*  

**Résultat:**
![]()

# Typologie des switchs
---

Réaliser sous le logiciel XMind un mind mapping de la typologie de commutation afin de bien expliciter le choix d'un achat d'un switch en fonction des différents paramètres à compléter et définir ci-dessous:  
- facteur de forme
- fond de panier
- 802.1Q
- aggrégation
- layer
- support POE/POE+
- STP
- ports physiques
- .....


Vous trouverez en corrigé **[ici](https://github.com/cromm24/Hello_World/raw/main/AT2/AT2C1/Mate%CC%81riel%20Actif%20Re%CC%81zo.xmind)** un fichier complet au format Xmind du mind mapping des éléments actifs d'un réseau local (switch,ap,routeur) et même les serveurs.  

# Architecture de PME avec Vlan de niveau 1 & 2
---

La société DUCRAN souhaite que vous organisiez son réseau.  
Cette société de déménagement possède:  
- 1 service technique (100 employés, 50 postes, 10 bureaux)
- 1 service administratif (20 employés, 20 postes, 5 bureaux)
- 1 service IT (2 employés,4 postes,1 bureau)
- 1 service direction (5 employés, 5 postes, 2 bureaux)

Elle possède une salle serveur:  
- 1 routeur cisco RV180 avec 2 abonnement ADSL en load-balancing/failover:  
  - 193.22.250.1 : Orange sdsl 8 méga  
  - 82.66.32.147: Ovh sdsl 4 méga  
- 1 switch ProCurve 2530-24-POE+  
- 1 serveur AD/DNS/DHCP sous win2012 R2 nommé ad.ducran.lan  
- 1 serveur file share sous win2012 R2 nommé share.ducran.lan  
- 1 proxy nommé proxy.ducran.lan  

En plus (dans le couloir:-)):  
- 1 borne aruba 207 pour l’accueil public ssid:pub

Le reste des services est externalisé  
Le LAN est en 172.16.0.0/24  
Nous allons spécifier les VLAN et les tags  

Lorsque l'on définit les ports associés à chaque VLAN, il y a 3 modes :  

- **Untagged:** Le port est associé qu'à un seul VLAN. C'est à dire que tout équipements raccordés à ce port fera partie du VLAN.  
- **Tagged:** Signifie que les trames qui arrivent et sortent sur le port sont marquées par une en-tête 802.1q supplémentaire dans le champs Ethernet. Un port peut être "tagged" sur plusieurs VLAN différents. L'avantage du mode Tagged est la possibilité d'avoir un serveur pouvant communiquer avec toutes les stations des VLANs sans que les VLANs ne puissent communiquer entre eux.  

- **No:** Aucune configuration dans le VLAN.

[Quelques explications supplémentaires](https://community.hpe.com/t5/Switches-Hubs-and-Modems/Tagged-vs-Untagged/td-p/4004330)

**Objectifs:**  
Créer un schéma de la façade du switch pour faire la synthèse des vlan et des tags.  
Créer au format draw.io le schéma réseau de la structure.  

**Résultats:**  
![Voilà le schéma topo](https://github.com/cromm24/Hello_World/blob/main/AT2/AT2C1/Topo_ducran.png?raw=true)

**Corrigés:**  
Un petit schéma de facade de switch **[ici]**(Créer un schéma de la façade du switch pour faire la synthèse des vlan et des tags)  
Voilà au format google sheet un **[schéma de facade](https://github.com/cromm24/Hello_World/raw/main/AT2/AT2C1/Affectation_vlan_ducran.xlsx)** du  switch ainsi que dans un deuxième onglet une évolution en mode trunk.
Le voici en image:
![image](https://github.com/cromm24/Hello_World/blob/main/AT2/AT2C1/vlan_ducran.jpg?raw=true)

Voilà le corrigé du schéma **[topo](https://drive.google.com/file/d/1Pybw_dwJfc1ik5q1QHX85HBv44xf0sPF/view)**


![*](https://www.mediathequespaysdugier.org/images/articles/numerique/services/2016/images/services-wifi-adapte.jpg)

# WiFI

**Questionnaire sur le WIFI:**

1. Qu'est ce qu'un WLAN?  
    C'est un réseau local sur signal hertzien  
    Wireless Local Area Network  

2. Qu'est ce que la WIFI Alliance?  
    C'est une organisation à but non lucrative qui rassemble les différents acteurs du marché des constructeurs, elle vise à promouvoir les évolutions de la norme.

3. Quelle est la fréquence de fonctionnement du WIFI A?  
    5 ghz

4. Quel est son débit?  
    54 mbs/s soit environ 8Mo/s en débit théorique

5. Peut-on l'utiliser en France ?  
    Désormais oui mais elle est obsolète

6. Quelle est la fréquence de fonctionnement du WIFI B?  
    2,4 ghz

7. Quel est son débit ?  
    11 mbit/s soit environ 1,25Mo/s

8. Quelle est la fréquence de fonctionnement du WIFI G?  
    2,4 ghz

9. Quel est son débit ?  
    54 mb/s soit environ 8Mo/s en débit théorique

10. Quelle est la fréquence de fonctionnement du WIFI N?  
    2,4 gHz à 5ghz

11. Quel est son débit ?  
    De 54mb/s à 600mb/s suivant les technologies et la distance

12. Quelle est la fréquence de fonctionnement du WIFI AC?   
    802.11ac  
    IEEE 802.11ac est un standard de [transmission sans fil](http://fr.wikipedia.org/wiki/Transmission_sans_fil) de la famille [Wi-Fi](http://fr.wikipedia.org/wiki/Wi-Fi), normalisé par l'[IEEE](http://fr.wikipedia.org/wiki/IEEE) le [08/01/2014](http://www.zdnet.fr/actualites/l-ieee-officialise-le-wi-fi-de-nouvelle-generation-39796881.htm), qui permet une connexion sans fil haut débit utilisant une bande de fréquence sous les 6 GHz (qui est communément connue comme la bande des 5 GHz).  
    Les canaux offrent un débit pouvant atteindre 500 Mbps chacun, soit jusqu'à 8 Gbps de débit total grâce au [multiplexage](http://fr.wikipedia.org/wiki/Multiplexage).  

13. Quel est son débit ?  
    Il est variant. Explication [**ici**](https://fr.wikipedia.org/wiki/IEEE_802.11ac)

14. Quelle est la nouvelle norme de fonctionnement du WIFI ?  
    802.11ax   
    Explication des normes [**là**](http://www.frandroid.com/comment-faire/241426_les-differentes-normes-wi-fi-802-11abgnac-quelles-differences-pratique)  

15. Quel est son débit?   
    Jusqu'à 8gbit/s  

16. Trouver une tableau de correspondance entre ces normes avec des lettres et les normes avec des chiffres

![*](https://le-routeur-wifi.com/wp-content/uploads/2018/10/evolution-wifi.png)  
Et un beau [tableau](https://le-routeur-wifi.com/normes-wifi-802-11/)  

| WiFi |802.11|Débit max (Théorie)|Portée|Fréquence (Ghz)|Largeur deBande|Congestion|MIMO|
|:----:|:----:|:-----------------:|:----:|:-------------:|:-------------:|:--------:|:---:|
|WiFi 1|802.11 - 1997|	2 Mbit/s|	20 m|	2,4|	79 ou 22|	Elevée|	Non|
|WiFi 2|802.11a - (1999)|	54 Mbit/s|	35 m|	5|	20|	Faible|	Non|
|WiFi 2|802.11b - (1999)|	11 Mbit/s|	35 m|	2,4|	22|	Elevée|	Oui|
|WiFi 3|802.11g - (2003)|	54 Mbit/s|	38 m|	2,4|	20|	Elevée|	Oui|
|WiFi 4|802.11n - (2006)|	72 - 288 Mbit/s|	70 m|	2,4|	20|	Elevée|	Oui - Max 4|
|WiFi 4|802.11n - (2009)|	150 - 600 Mbit/s|	35 m|	5|	20 ou 40|	Faible|	Oui - Max 4|
|WiFi 5|802.11ac - (2013)|	433 - 1300 Mbit/s|	35 m|	5|	20, 40 ou 80 MHz|	Faible|	Oui - Max 8|
|WiFi 5e|802.11ac - (2013)|	433 - 2600 Mbit/s|	35 m|	5|	20, 40, 80 ou 160 MHz|	Faible|	Oui - Max 8|
|WiFi 5e|802.11ad - (2012)|	Jusqu'à 6750 Mbit/s|	10 m|	60|	2, 160|	Très faible|	Non|
|Wifi 5e||802.11ah - (2016)|	8 Mbit/s|	100 m|	0,9|	1 à 8|	Faible|	Oui - Max 2|
|WiFi 6|802.11ax - 2019| 10Gbit/s| 35m| 1-7Ghz | * | * |

![](https://github.com/cromm24/Hello_World/blob/main/AT2/AT2C1/tableau_wifi.jpg?raw=true)

17. Que signifie MIMO?  
    Multiple input / Multiple Output  
 
18. Qu'est ce que le MIMO?  
    Une norme wifi pré-n qui s'est retrouvé dans la norme N, on multiplie les antennes pour augmenter le débits  

19. Comment s'appelle la gamme professionnelle d'AP de chez Cisco?   
    Aironet. [Site de Cisco](https://www.cisco.com/c/fr_fr/products/wireless/access-points/index.htm)

20. Combien ça coûte?    
    Cela peut coûter de 450 à 1500 euros  

21. Qu'est ce qu'un range extender?  
    C'est un périphérique réseau qui étend la zone couverte par votre AP en prolongeant le signal et en retransmettant le même SSID

22. Qu'est ce qu'un pont wifi?  
    C'est un périphérique réseau qui se connecte à une AP et qui possède au moins une interface réseau Eth RJ45 qui permet d'étendre le réseau filaire comme dans le cas d'une liaison aérienne inter-bâtiment

23. Sur quelle couche du modèle OSI fonctionne une AP?  
    Sur la couche 1 et 2

24. Que signifie SSID?  
    Un SSID (acronyme de Service Set Identifier) est le nom d'un réseau sans fil  

25. Peut-on cacher un SSID?  
    Oui

26. Que fait inssider?  
    Il permet d'identifier les réseaux présents autour de soi de connaître les canaux utilisés la puissance d'émission des bornes faire un peu de zoning/site survey.

27. Qu'est qu'un logiciel de site survey en wifi ?
    C'est un logiciel qui principalement définit les implantations et le zoning de son maillage wifi
    Exmeple: [Acrylic](https://www.acrylicwifi.com/fr/produits-wifi/scanner-de-reseaux-wi-fi-acrylic-wifi-free/) / [AirMAgnet](http://fr.flukenetworks.com/enterprise-network/wireless-network/AirMagnet-Survey)

28. Combien de canaux sont disponibles en France?   
    13 canaux sont disponible, 11 utilisable. Un petit [**tutto**](http://lafibre.info/tutoriels/quel-canal-wi-fi-choisir-pour-optimiser-son-debit/)  
  
29. Qui régule les canaux en France?   
    L'ART qui a fusionné avec l'ARCEP  

30. A-t-on le droit de tous les utiliser?  
    Cela dépend de l'environnement et de la puissance de ses antennes.  

31. Qu'est ce que le PIRE?  
    La puissance de rayonnement d'une antenne (Puissance Isotrope Rayonnée Equivalente)
    https://www.arcep.fr/index.php?id=9272

32. Qu'est ce qu'une antenne Ricoré?
    [Explication](https://fr.wikipedia.org/wiki/Antenne_2,5_GHz_amateur)
    [Conception](https://antenne.ooreka.fr/fiche/voir/505011/fabriquer-une-antenne-ricore)

33. Que signifie WEP?  
    Wired Equivalent Privacy  

34. Que signifie WPA?  
    Wifi Protected Access  

35. De quand date le WPA2?  
    2004 pour la norme , 2006 pour la mise en production  

36. De quand date le WPA3?  
    Juillet 2020
    Petite définition [**ici**](https://www.netspotapp.com/fr/what-is-wpa3.html#Qu'est-ce_que_WPA3)

37. Quelle est la différence entre le WPA et le WPA entreprise?  
    WPA Enterprise : le mode entreprise impose l'utilisation d'une infrastructure d'authentification 802.1x basée sur l'utilisation d'un serveur d'authentification souvent de type Raidus  

38. Quel logiciel permet de cracker des clés ?  
    AirCrack NG dans par exemple la distribution linux [**kali**](https://www.kali.org/)

39. Qu'est une connexion WIFI AD-HOC?  
    C'est une mode de connexion directe entre 2 machines sans passer par une AP(mode infrastructure)  

40. La dernière norme POE permet d'envoyer jusqu'à combien de ampère/volt dans un périphérique?  
    - 25 watt pour la 802.3af-2003
    - 50 watt pour la 802.3at-2009
    - 100 watt pour la 802.3bt

41.  Qu'est ce que le WDS en WIFI?  
    Le Wireless distribution System est une norme qui permet de mailler des AP entre elles sans avoir à toutes les connecter en filaire, le signal wifi est étendu, de même que le SSID, ce qui permet de propager la trame sur tout les points  

42. Le wimax est il du WIFI?  
    Non ce n'est pas la même norme (802.16) même si c'est du hertzien  

43. Quelle technologie puis-je aggréger sur une AP pour authentifier les utilisateurs?  
    Radius  

44. J'ai une AP en WPA2 avec le SSID Caché et une authentification, que me reste il à faire pour ajouter un dernier niveau de sécurité sur ma borne ?   
    Le mac filtering: On dresse une liste des adresses mac de mes postes que j'appaire dans l'interface de gestion de mon AP  


## **Ressources**
- [airmax](https://eu.store.ui.com/collections/operator-airmax-and-ltu)  

## Management d'un réseau Unifi

![*](https://github.com/cromm24/Hello_World/blob/main/AT2/AT2C1/wifi_preuve1.jpg?raw=true)  
![*](https://github.com/cromm24/Hello_World/blob/main/AT2/AT2C1/wifi_preuve2.jpg?raw=true)  
![*](https://github.com/cromm24/Hello_World/blob/main/AT2/AT2C1/wifi_preuve3.jpg?raw=true)  
![*](https://github.com/cromm24/Hello_World/blob/main/AT2/AT2C1/wifi_preuve4.jpg?raw=true)  
![*](https://github.com/cromm24/Hello_World/blob/main/AT2/AT2C1/wifi_preuve5.jpg?raw=true)  
![*](https://github.com/cromm24/Hello_World/blob/main/AT2/AT2C1/wifi_preuve6.jpg?raw=true)

***Remarque: Je n'ai pas mis dans la md les fichiers persos d'alain, comme les fichiers word du P4 ou les pdf du wifi***
