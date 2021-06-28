# DocGen
Auteur(s): Marien Couvertier, Florian Legendre
Date de début du projet: 12/04/2021


<!-- ================================== -->
<!-- ====== README UTILISATEUR ======== -->
<!-- ================================== -->
## README Utilisateur

### Pourquoi ce projet?
DocGen vous permet de générer une documentation de type Notebook automatiquement
en utilisant la fonction "Publish" de MatLab. DocGen n'écrit donc pas les
commentaires à votre place mais il donne les fichiers html avec une mise en page
agréable à la lecture ainsi qu'une table des matières.


### Comment utiliser ce projet?
1. Ouvrez le fichier "1_CONFIGME.m" et suivez les commentaires de ce fichier pour
   configurer DocGen selon votre projet
2. Ouvrez le fichier "2_RUNME.m" et entrez les notices locales que vous voulez
   générer
3. Générez votre documentation en interprétant le script "2_README.m"


<!-- ================================== -->
<!-- ====== README DEVELOPPEUR ======== -->
<!-- ================================== -->
## README Développeur

### Que contient ce dossier?
Ce projet a été construit sur la base d'un template et contient les dossiers suivants:

* 1_CONFIGME.m => Fichier permettant de configurer DocGen selon votre projet (vous pourrez
                  y renseigner le nom de votre projet, où sont ses codes sources, etc.)

* 2_RUNME.m    => Fichier où vous préciserez les notices locales et où vous génèrerez automatiquement
                  la documentation de votre projet par exécution de ce script dans MatLab
                  
* codes/ => rassemble tous les modules et scripts matlab nécessaires au fonctionnement de DocGen

* data/  => rassemble toutes les données expérimentales ou bases de données. Ce dossier
            n'est pas utilisé par DocGen mais il est tout de même versionné pour partager
            l'arborescence de DocGen. Peut-être qu'un jour une fonctionnalité aura besoin
            de cet espace

* docs/  => rassemble tous les éléments de documentation __globale__ de DocGen, y compris un manuel
            utilisateur exhaustif et un manuel technique pour les contributeurs de ce projet

* lib/   => rassemble toutes les librairies de fonctions directement utilisables
            dans les scripts matlab par un simple addpath(). Comme pour data/, ce dossier
            n'est pour l'instant pas utilisé par DocGen mais pourrait l'être un jour

* out/   => espace réservé aux outputs de DocGen utilisés pour générer sa documentation
            ou fournir des fichiers de debugging (log d'erreurs, etc.)

* res/   => contient toutes les ressources utiles au projet ou parfois des archives
            du projet


### Comment contribuer?

#### Prérequis à la contribution

##### DocGen
Pour la documentation de ce projet nous utilisons le projet lui-même DocGen ainsi
que Latex pour les manuels utilisateurs et développeur.


#### Exigences concernant les contributions

##### Git/SourceSup
Afin de renforcer et sécuriser la collaboration tous les projets sont versionnés
sous Git et déposés sur SourceSup. Pour tout renseignement sur l'utilisation de
Git vous pouvez cloner le projet de formation à l'adresse suivante (vous devez
avoir un compte sourcesup): https://sourcesup.renater.fr/projects/gitlearn.

L'autoformation à Git prend environ 10h pour être pleinement autonome sur cet
outils. Le parcours de formation est indiqué dans le README.

##### Messages de vos commits
Dans vos messages, faites figurer les informations suivantes: Quoi? Où? Pourquoi?

Exemple:
git commit -m "J'ai ajouté une fonction filtreMouvements() dans mouvPlot.m afin
d'éliminer les erreurs de mesure du capteur"

##### Granularité des commits
De trop petits commits = un historique surchargé. De trop gros commits = de gros
risques de pertes si on a besoin de revenir en arrière.

En d'autres termes: faire des commits rassemblant 2 à 3 changements maximums.



### Par où commencer?
Dans docs/DEV_MANUAL.pdf vous trouverez un chapitre contenant le cahier des charges
et une liste des fonctionnalités à implémenter ou des extensions possibles. Prenez
un élément de cette liste, et commencez à envisager des solutions et/ou à coder.

Suivez également suivre la documentation générée par DocGen <a href="./docs/ManPage_Global.html">ici</a>

REFEREZ-VOUS AU MANUEL DU DEVELOPPEUR EN CAS DE SOUCIS! Et n'hésitez surtout pas
à contacter les auteurs en cas de besoin.
