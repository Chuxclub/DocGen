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
Si vous êtes sous Linux, allez dans le fichier codes/DocGen.m. Dans la fonction
"noticeGlobale" commentez la ligne associée à Windows et décommentez celle
associée à Linux.

Maintenant allez dans le fichier PathsTB.m et modifiez la constante SEP_TOKEN
comme indiqué dans le fichier.

Une fois cela fait vous pouvez utiliser DocGen en suivant cette méthode:

* Dans MatLab, ouvrez DocGenScript
* Renseignez les chemins absolus des dossiers de votre projet dont vous souhaitez
   faire la notice
* Renseignez le paramètre booléen indiquant si vous souhaitez ou non une évaluation
   de votre code
* Exécutez le script


<!-- ================================== -->
<!-- ====== README DEVELOPPEUR ======== -->
<!-- ================================== -->
## README Développeur

### Que contient ce dossier?
Ce projet a été construit sur la base d'un template et contient les dossiers suivants:

* codes/ => rassemble tous les modules et scripts matlab
* data/  => rassemble toutes les données expérimentales ou bases de données. Ce dossier
            n'est pas utilisé par DocGen mais il est tout de même versionné pour partager
            l'arborescence de DocGen. Peut-être qu'un jour une fonctionnalité aura besoin
            de cet espace
* docs/  => rassemble tous les éléments de documentation __globale__ du projet
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
