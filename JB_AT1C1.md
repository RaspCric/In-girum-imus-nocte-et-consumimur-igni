![](https://media-exp1.licdn.com/dms/image/C4D0BAQEJIrLeIu3hgg/company-logo_200_200/0/1568885231849?e=2159024400&v=beta&t=VmG6ouGc0bZv7vXQLokouf_RUEIRI32PnPfz92LVwa4)

# TSSR AT1C1 - TP : Création d'une petite infra host only

*MAJ le 11/06/2021 par T.CHERRIER*

## CONTEXTE RESEAU

le réseau host only est en **classe B privé /25** dans la plage 
*172.16.0.0 à 172.16.31.255*

* Contruire un réseau host-only dans VirtualBox en n'assignant **pas de serveur DHCP** à VirtualBox
* La dernière adresse possible est celle de la gateway sur l'Host
* L'avant dernière est celle sur windows serveur 2019
* Celle juste avant est celle du serveur apache
* la première via DHCP sera celle du poste client

**Choisir également un nom de domaine du type bobdy.lan ou rantanp.lan**

## CREATION DE 3 VMs

**VM1 : windows 7 32 bits** avec les logiciels suivants:

* 7zip
* SumatraPDF
* Notepad++
* une auvre navigateur que IE/Edge
* le poste sera intégré au domaine mondomaine.lan

**VM2 : windows serveur 2019** avec les logiciels suivants:

* 7zip
* SumatraPDF
* Notepad++
* une auvre navigateur que IE/Edge
* Installer le role AD de base
* Configurer à minima le serveur DNS avec un alias www.mondomaine.lan sur la VM3

**VM3 : Debian10 64bits** avec un serveur apache minimal

- Installastion d'apache en ligne de commande :  
> `apt install apache2`   

- Modification de la page d'index avec un chat en ascii :  
> `_nano /var/www/html/index.html_`    

- Paramêtre de la machine pour lui attribué une ip fixe en modifiant le fichier :  
> `_/etc/network/interfaces_` 

- Pas de HTTPS


## PLAN DE ROUTAGE FINAL


**_Conclusion_: On peut attendre la page d'index du serveur Apache via le poste client.** 
___
# *Automatisation de l'installation de logiciel*  

_création d'une VM WIN10 pro minimale avec les guest additions_  
*creation d'un clone du master via VB*


### **ninite** 
- Changement de nom du pc  
- changement de workgroup  
- Bureau à distance  
- Windows update  
- Centre de réseau et partage profil privé  
- Régle de ping dans le pare feu  
- Création d'un user Bdagen puis connection sur son profil  
- Installation de soft via ninite :  Chrome Mozilla Notepad sumatra vlc zoom  


### **Soft2Base**  
- Téléchargement de Soft2Base  
- Choix des app à installer  
- Lancement de l'installation silencieuse des softs  

### **AutoIT**  
- Téléchargement de AutoIT  
- Rédaction d'un script pour l'automatisation de l'installation de TeamViewer   
  

### **WPI**
- Téléchargement de WPI  
- Lancement du soft  
- Ajout d'un soft non présent dans la liste  
- Mise a jour d'un soft obsolète  

### **Chocolatey**
- Commande pour installer chocolatey :  
> `@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"`    

- Ouverture du shell windows en élévation de privilège    
- lancement de la commande // fin de l'installation  
- Executer dans la console:  
> choco install firefox => install non silencieuse  
> choco install firefox -y => install avec confirmation auto    

- création d'un script en .bat dans un dossier  `/C:script/`  :  
    - il doit lancer silencieusement l'installation d'une dizaine de soft   
    - il doit outrepasser l'UAC  
 ==> voir dépot chocolatey  

### **WINGET**

- Téléchargement du https://aka.ms/AppInstaller_InsiderProgram puis mise à jour pour installer winget.  
- Rédaction d'un script en .bat pour faire un lancement automatique de l'installation des softs  


___
# *Créer, configurer et manipuler des machines virtuelles*  

*Copie du master*   
Sur ce nouveau master, installation de plusieurs softs puis téléchargement de l'ADK (Windows Assessment and Deployment Kit) ainsi que les extensions.  
Installation de l'ensemble du Kit.  

1er essai :  
- modifier les fichiers de language via WSIM (Windows System Install Manager) et enregistrer le fichier à la racine d'une clé usb en le nommant : Autounattend.xml pour **rendre silencieuses** (automatiser) les étapes de language lors de l'installation.  
- lancement d'une VM test en démarrant sur ce fichier pour vérifier.  

### _Challenge : Automatiser une installation de Win10_  
Pour réussir ce challenge, vous devez automatiser une installation de Windows 10 Pro sur une VM :  

VM : Container Windows 10 x64 / HDD : 60 Go Dynamique / Carte réseau : Bridge  

Cahier des charges:  

- Langue : Fr  
- Partitions type MBR  
- System 500 Mo  
- C:\Windows : 30 Go  
- D:\Data : le reste du HDD virtuel  
- Comptes utilisateurs :  
    - TSSR : Administrateur   
    - Password : tssr2021  
    - VISA : Utilisateur  
    - Password : visa  
- Nom du poste : CEFXX   
- Infos OEM :  
    - 9h00 à 18h00  
    - glpi.cefim-formation.org  

==> Voir le dépot du script Autounattend.xml  

___
# *Création d'une clé E2B*

1. Téléchargement du logiciel  
2. Installation de E2B sur une clé  
3. Téléchargement des driver ("only needed")  
4. Téléchargement des mises a jour via wsusoffline (pour installation des MAJ en offline)  
5. On ajoute les isos ( WIN10 et DEBIAN9 )  
6. On place le fichier Autounattend dans le bon répertoire  
7. On fait la procédure décrite dans le moodle pour Chocolatey:  
    - Téléchargement du logiciel  
    - Bloquage des connexions et intallations en ligne via des fichier OfflineChoco.tag et NoInternet.tag qu'on met dans le dossier `\ISO\WINDOWSINSTALLS\CONFIGS\SDI_CHOCO`  
    - Création d'un fichier `MyStartup.cmd` avec le code d'installation de Chocolatey  
