%% LE SCRIPT DE MISE A JOUR DE VOTRE DOCUMENTATION

% -> Auteurs:   Marien Couvertier (script original), Florian Legendre (màj)    
% -> Objectif:  Fournir un espace unique de mise à jour de la documentation   
%               du projet.
% -> IMPORTANT: Modifiez le fichier docgenConfigs.m AVANT d'exécuter ce      
%               script!


%% Configuration de DocGen
run CONFIGME.m; 


%% Création des documentations locales aux modules

% ~~~~~~~ Génération des notices locales ~~~~~~~ %
% Argument 1: La racine à partir de laquelle on génère la notice locale.
% Argument 2: Est-ce qu'on évalue les fonctions des scripts présents dans 
%             la racine ou non?
docGen.makeLocalDoc([projectCodesPath '\DocPageModule'], false);
docGen.makeLocalDoc([projectCodesPath '\IndexModule'], false);
docGen.makeLocalDoc([projectCodesPath '\MatlabModule'], false);
docGen.makeLocalDoc([projectCodesPath '\StringModule'], false);


%% Création de la documentation globale au projet

% ~~~~~~~ Génération de la (ou des?) notice globale  ~~~~~~~ %
% Argument 1: La racine à partir de laquelle on génère la notice globale. 
% Argument 2: La destination où on place la notice globale. 
% Argument 3: On affiche tous les fichiers '.html' ou seulement les 
%             index des notices locales.
docGen.makeGlobalDoc(projectCodesPath, projectGlobalDocDest, true);

             
%% Suppression rapide d'une ou plusieurs notices
%DocGen.deleteNotice('E:\Git\projects\wip\DocGenTest\codes\Fonctions\Spatial_Location');

