# AT1C1 Automatisation de l'installation de logiciel

# création dune VM windows 10 pro en avancé poour la plus petite possible avec juste guest additions
---

# creation d'un clone via VB


## ninite 
Changement de nom du pc  
changement de workgroup  
Bureau à distance  
Windows update  
centre de réseau et partage profil privé  
régle de ping dans le pare feu  
création d'un user Bdagen puis connection sur son profil  
installation de soft via ninite :  Chrome Mozilla Notepad sumatra vlc zoom  


## Soft2Base

téléchargement de Soft2Base, choix des app à installer puis lancement de l'installation silencieuse des softs 

## AutoIT
téléchargement de AutoIT et rédaction d'un script pourr l'automatisation de l'installation de TeamViewer  
  

## WPI
téléchargement de WPI  
lancement du soft
ajout d'un soft non présent dans la liste  
mise a jour d'un soft obsolète  

## Chocolatey

explication de la commande : @"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"  

ouverture du shell windows en élévation de privilège (click droit sur cmd) 
lancement de la commande  // fin de l'installation  
dans cmd lancement de la commande :  
    choco install firefox => install non silencieuse  
    choco install firefox -y => install avec confirmation auto  
creation d'un script en .bat dans un dossier  /C:script/  
    il doit lancer silencieusement l'installation d'une dizaine de soft   
    et il doit outrepasser l'UAC  