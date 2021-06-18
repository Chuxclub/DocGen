% ======================================================================= %
% ========== LE SCRIPT DE MISE A JOUR DE VOTRE DOCUMENTATION ============ %
% ======================================================================= %

%                    -------------------------                            %
% Auteurs: Marien Couvertier (script original), Florian Legendre (màj)    %
%                                                                         %
% Objectif: Fournir un espace unique de mise à jour de la documentation   %
% du projet.                                                              %
%                                                                         %
% IMPORTANT: Modifiez les variables globales dans DocGen.m, dans          %
% "properties" selon votre système                                        %
%                    -------------------------                            %

%% Configuration de DocGen
% Configuration de DocGen => pour plus d'optimisation exécutez cette 
%                            section qu'une seule fois (Ctrl+Entrée).
docgenCodesPath = 'E:\Git\projects\wip\DocGenTest\lib\DocGen\codes';
addpath(docgenCodesPath);


% ~~~~~~~ Initialisation de DocGen avec configurations ~~~~~~~ %
% Argument 1: auteurs
% Argument 2: contact
% Argument 3: nom du projet
% Argument 4: nom long du projet
% Argument 5: chemin vers DocGen
% Argument 6: symbole séparation des chemins ('/' SI LINUX)
docGen = DocGen('Marien Couvertier, Florian Legendre', ...                 
                'florian.legendre@etu.univ-poitiers.fr',  ...              
                'DocGen', ...                                              
                'GAD Matlab créé par Robioss', ...                          
                docgenCodesPath, ...           
                '\');


%% Création de la documentation

% ~~~~~~~ Fonction et génération des notices locales ~~~~~~~ %
% Argument 1: La racine à partir de laquelle on génère la notice locale.
% Argument 2: Est-ce qu'on évalue les fonctions des scripts présents dans 
%             la racine ou non?
docGen.makeLocalDoc('E:\Git\projects\wip\DocGenTest\codes\Fonctions\Math', false);
docGen.makeLocalDoc('E:\Git\projects\wip\DocGenTest\codes\Fonctions\Plot', false);
docGen.makeLocalDoc('E:\Git\projects\wip\DocGenTest\codes\Fonctions\Plot\Video', false);
docGen.makeLocalDoc('E:\Git\projects\wip\DocGenTest\codes\Fonctions\Spatial_Location', false);
docGen.makeLocalDoc('E:\Git\projects\wip\DocGenTest\codes\Programmes', false);


% ~~~~~~~ Fonctionnement et génération de la (ou des?) notice globale  ~~~~~~~ %
% Argument 1: La racine à partir de laquelle on génère la notice globale. 
% Argument 2: La destination oÃ¹ on place la notice globale. 
% Argument 3: On affiche tous les fichiers '.html' ou seulement les 
%             index des notices locales.
docGen.makeGlobalDoc('E:\Git\projects\wip\DocGenTest\codes', ...
                     'E:\Git\projects\wip\DocGenTest\docs', true);

                
%% Suppression rapide d'une ou plusieurs notices
%DocGen.deleteNotice('E:\Git\projects\wip\DocGenTest\codes\Fonctions\Spatial_Location');

