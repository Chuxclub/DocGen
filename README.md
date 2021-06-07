# DocGen
Auteurs: Marien Couvertier, Florian Legendre

## À quoi sert DocGen?
DocGen vous permet de générer une documentation de type Notebook automatiquement en utilisant la fonction "Publish" de MatLab. DocGen n'écrit donc pas les commentaires à votre place mais il donne les fichiers html avec une mise en page agréable à la lecture ainsi qu'une table des matières.

## Comment utiliser DocGen?
Avant toute chose, allez dans le fichier docgen_pkg/DocGen.m. Sous le champ "properties" vous verrez des constantes. Modifiez les valeurs de celles-ci ou commentez/décommentez selon votre système et l'arborescence de votre projet. Une fois cela fait vous pouvez utiliser DocGen en suivant cette méthode:

1. Dans MatLab, ouvrez DocGenScript
2. Renseignez les chemins absolus des dossiers de votre projet dont vous souhaitez faire la notice
3. Renseignez le paramètre booléen indiquant si vous souhaitez ou non une évaluation de votre code
4. Exécutez le script
