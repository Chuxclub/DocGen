%% Configuration de DocGen

% ~~~~~~~ Initialisation des chemins 'racines' utilisés par DocGen ~~~~~~~ %
% Pour chacun des chemins ci-dessous, remplacez les chaînes de caractères.
% Chemin 1 (docgenCodesPath): chemin absolu vers la racine des codes sources de DocGen
% Chemin 2 (projectCodesPath): chemin absolu vers la racine des codes sources de votre projet
% Chemin 3 (projectGlobalDocDest): chemin absolu vers le dossier où sera placé la notice globale de votre projet

docgenCodesPath = 'E:\Git\projects\wip\DocGen\codes';
projectCodesPath = 'E:\Git\projects\wip\DocGen\codes';
projectGlobalDocDest = 'E:\Git\projects\wip\DocGen\docs';

% Sautez cette ligne...
addpath(docgenCodesPath);


% ~~~~~~~ Initialisation de DocGen avec configurations ~~~~~~~ %
% Argument 1: auteurs
% Argument 2: contact
% Argument 3 (déjà configuré ci-dessus): chemin vers les modules de DocGen
% Argument 4 (déjà configuré ci-dessus): chemin vers les codes sources du projet
% Argument 5 (déjà configuré ci-dessus): chemin vers la destination de la notice globale
% Argument 6: nom du projet
% Argument 7: nom long du projet
% Argument 8: symbole séparation des chemins ('/' SI LINUX)

docGen = DocGen('Marien Couvertier, Florian Legendre', ...
                'florian.legendre@etu.univ-poitiers.fr',  ... 
                docgenCodesPath, ...
                projectCodesPath, ...
                projectGlobalDocDest, ...
                'DocGen', ...       
                'GAD Matlab créé par Robioss', ...
                '\');
