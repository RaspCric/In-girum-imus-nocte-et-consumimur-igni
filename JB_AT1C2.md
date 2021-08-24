![*](https://media-exp1.licdn.com/dms/image/C4D0BAQEJIrLeIu3hgg/company-logo_200_200/0/1568885231849?e=2159024400&v=beta&t=VmG6ouGc0bZv7vXQLokouf_RUEIRI32PnPfz92LVwa4)

# TSSR AT1C2 - TP : Configuration d'une petite infra IPBX avec 2 softphones


*MAJ le 18/06/2021 par T.CHERRIER et JB FONTANET*

---

### Généralités:

Une communication c'est **64kb**/s de consommation de bande passante  
Une infrastructures dans lalquelle on place de la VoIP doit avoir QOS + VLAN + POE  

* QOS pour prioriser un traffic minimum de la voix quand le reste est surchargé selon la règle *64kbpsXNbDeLigneSimultanéee*
* VLAN pour isoler le traffic VOIP dans un réseau spécifique
* POE (ou POE+) pour Alimenter les IPPhones

### Contexte
Création d'une VM avec 2Go de RAM minimal sur un noyau Linux branche Debian10x64bits avec l'ISO current récupérée sur [mirror.xivo.solutions]  

![VM Xivo](https://raw.githubusercontent.com/cromm24/Hello_World/IPBX/VM%20xivo.jpg)  

Nous installerons par la suite deux softphones, 1 sur le Win10 Hôte et 1 sur un smartphone Android/Ios
 
## PARAMETRAGE DE L'INTERFACE WEB

Récupération de  l'adresse IP sur la VM : 192.168.X.X (selon votre box/routeur)

Connection via cette IP sur le wizzard XIVO depuis notre poste hôte en https avec un certificat auto-signé (Warning potentiel mais vous forcez votre navigateur à accepter tout de même)
  
* Choix de la langue francaise
* Validation de la licence GNU GPL 
* Nom de l'hôte : IPBX  
* Domaine : tssr.lan  
* Password  
* Adresse IP : 192.168.X.X (eth0) à mettre de préférence en IP Fixe ou à laisser en DHCP si petite maquette temporaire
* Gateway : 192.168.X.X (celle fournie par votre box/routeur ) 
* DNS : 192.168.1.254  (celle fournie par votre box/routeur),dans une vrai infra nous renseignons ici le serveur DNS local qui est souvent le DC1 de l'AD  
    _SUIVANT_  
* Entité : CONTOSO (le nom de notre entreprise) 
* Noms affiché : Appels internes  
* Début de l'intervalle des numéro : 100  
* Fin de l'intervalle : 199  
    _SUIVANT_  
    _VALIDER_

----

Xivo c'est plus qu'un IPBX (il intègre plein d'autres services), Gaia c'est le nom de son dashboard.
Astérisk est un processus principal qui vas gérer les flux d'IP.

## **Configuration Générale de Xivo**

### Gestion:  

Définir un contexte d'entreprise Entités:

* Ligne téléphonique extérieur
* e-mail de la socièté
* addresse url de la société
* addresse, ville, CP


**Général**: laisser coché, permet de relancer les services automatiques après une modification.  
**Certificats SSL**: pas besoin car connection déjà sécurisée même si auto-signée, dans une infra locale complète on monte une PKI mais là pas besoin.   
**Serveurs LDAP**: Permet d'importer les users d'un AD. 

=> aucun autre changement dans la partie **Gestion**  


**Contexte d'approvionnement:**

Ip phone :il faut les approvisionner

Les softphones pas besoin.  
**Modèles de terminaison** : si on rajoute un appareil, il se base sur ce template. Mettre le protocole En SIP
**Greffons**: ajouts du pack xivo-cisco-spa-7.5.5 

*Un softphone n'a pas besoin de greffons*

==> APPLICATIONS DES MODIFICATIONS = DONE !

## Services IPBX 
 
**Protocole SIP**: on lui fait confiance ! _"Touche pas à ca petit con"_  :-)  
**Messageries vocales**: fréquences 8khz ca donne un mauvais son, vous pouvez changer la sonneries

**Terminaison:**  
Terminaison physique, on a pas d'ip phones donc pas besoin ici

Pour qu'un softphone sonne il faut qu'il y ai un utilisateur et une ligne d'attribué.  
  
Attributions des Lignes sur Utilisateurs ou l'inverse, les deux sont interdépendants.  


Lignes (= compte SIP dans l'entité CONTOSO):  

* Associer à l'utilisateur un identifiant et un mdp (c'est XIVO qui les générent)  
* Création de 2 lignes : Bruno Dagen et Vincent Tim  

**Utilisateurs:**    

* Ajouter un compte: Bruno Dagen  
* Ajouter un compte: Vincent Tim  

_FUSION de la  LIGNE et du USER:_  
Lignes -> Modifier -> Lignes : attribuer un numéro de ligne (ex: BDAGEN 100; VTIM 101)  
lignes / User / compte SIP : TOUT DOIT ETRE LIEE  

___
![Wizard Xivo](https://raw.githubusercontent.com/cromm24/Hello_World/IPBX/wizard%20xivo.jpg)  
___

## LA CONFIGURATION SERVEUR EST TERMINEE !

___

## *Exercice:*  
Utiliser 2 softphones: 1 sur son PC & 1 sur son Smartphones.  
Utiliser l'application ZoiPer ou Jitsi ou autre.  
Configurer le wizard du Xivo comme ci dessus.  
=> Il faut pouvoir s'appeller de l'un à l'autre.   

### *Correction:*

La Vm Xivo étant deja monté et paramêtré, on passe à l'installation et la configuration du ZoiPer:  
1. On installe Zoiper sur le pc hôte et sur le smartphone. On le configure en rentrant le login et le mdp donné par le wizard de xivo pour chacun des appareils. On renseigne le nom de domaine(qui est l'adresse Ip du serveur Xivo) : 192.168.1.12  

![*](https://raw.githubusercontent.com/cromm24/Hello_World/IPBX/parametragre%20zoiper.jpg)  

2. Ensuite on s'appelle de l'un vers l'autre et vice-versa.  

![*](https://raw.githubusercontent.com/cromm24/Hello_World/IPBX/Appelle%20vers%20101.jpg)
![*](https://raw.githubusercontent.com/cromm24/Hello_World/IPBX/Android%20Zoiper%20preuve%20appel.jpg)