![](https://media-exp1.licdn.com/dms/image/C4D0BAQEJIrLeIu3hgg/company-logo_200_200/0/1568885231849?e=2159024400&v=beta&t=VmG6ouGc0bZv7vXQLokouf_RUEIRI32PnPfz92LVwa4)

# TSSR AT1C1 - TP : Création d'une petite infra host only


*MAJ le 11/06/2021 par T.CHERRIER*


##CONTEXTE RESEAU

le réseau host only est en **classe B privé /25** dans la plage 
*172.16.0.0 à 172.16.31.255*

* Contruire un réseau host-only dans VirtualBox en n'assignant **pas de serveur DHCP** à VirtualBox
* La dernière adresse possible est celle de la gateway sur l'Host
* L'avant dernière est celle sur windows serveur 2019
* Celle juste avant est celle du serveur apache
* la première via DHCP sera celle du poste client

**Choisir également un nom de domaine du type bobdy.lan ou rantanp.lan**

3 VMS décrites ci-dessous

##VMs

**VM1 : windows 7 32 bits** avec les logiciels suivants:

* 7zip
* SumatraPDF
* Notepad++
* une auvre navigateur que IE/Edge
* le poste sera intégré au domaine mondomaine.lan
* installer les GuestAdditions

**VM2 : windows serveur 2019** avec les logiciels suivants:

* 7zip
* SumatraPDF
* Notepad++
* une auvre navigateur que IE/Edge
* Installer le role AD de base
* Configurer à minima le serveur DNS avec un alias www.mondomaine.lan sur la VM3
* Configurer un partage de fichier sur un deuxième disque dur partionné et nommé DATA
* installer les GuestAdditions




**VM3 : Debian10 64bits** avec un serveur apache minimal

* Installer Apache2
* Customiser une page HTML d'index avec un chat 
* Pas de HTTPS


