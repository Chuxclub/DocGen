%% LE SCRIPT DE MISE A JOUR DE VOTRE DOCUMENTATION

% -> Auteurs:   Marien Couvertier (script original), Florian Legendre (m�j)    
% -> Objectif:  Fournir un espace unique de mise �jour de la documentation   
%               du projet.
% -> IMPORTANT: Modifiez le fichier docgenConfigs.m AVANT d'ex�cuter ce      
%               script!


%% Configuration de DocGen
run CONFIGME.m; 


%% Cr�ation des documentations locales aux modules

% ~~~~~~~ G�n�ration des notices locales ~~~~~~~ %
% Argument 1: La racine �partir de laquelle on g�n�re la notice locale.
% Argument 2: Est-ce qu'on �value les fonctions des scripts pr�sents dans 
%             la racine ou non?
docGen.makeLocalDoc([projectCodesPath '\DocPageModule'], false);
docGen.makeLocalDoc([projectCodesPath '\IndexModule'], false);
docGen.makeLocalDoc([projectCodesPath '\MatlabModule'], false);
docGen.makeLocalDoc([projectCodesPath '\StringModule'], false);


%% Cr�ation de la documentation globale au projet

% ~~~~~~~ G�n�ration de la (ou des?) notice globale  ~~~~~~~ %
% Argument 1: La racine �partir de laquelle on g�n�re la notice globale. 
% Argument 2: La destination o� on place la notice globale. 
% Argument 3: On affiche tous les fichiers '.html' ou seulement les 
%             index des notices locales.
docGen.makeGlobalDoc(projectCodesPath, projectGlobalDocDest, true);

             
%% Suppression rapide d'une ou plusieurs notices
%DocGen.deleteNotice('E:\Git\projects\wip\DocGenTest\codes\Fonctions\Spatial_Location');

