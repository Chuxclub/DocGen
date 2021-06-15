% ======================================================================= %
% ========== LE SCRIPT DE MISE √Ä JOUR DE VOTRE DOCUMENTATION ============ %
% ======================================================================= %

%                    -------------------------                            %
% Auteurs: Marien Couvertier (script original), Florian Legendre (m‡j)    %
%                                                                         %
% Objectif: Fournir un espace unique de mise ‡†jour de la documentation   %
% du projet.                                                              %
%                                                                         %
% IMPORTANT: Modifiez les variables globales dans DocGen.m, dans          %
% "properties" selon votre systËme                                        %
%                    -------------------------                            %


%% Cr√©ation de la documentation

% ~~~~~~~ Initialisation de DocGen avec configurations ~~~~~~~ %
% Argument 1: auteurs
% Argument 2: contact
% Argument 3: nom du projet
% Argument 4: nom long du projet
% Argument 5: chemin vers DocGen
% Argument 6: symbole sÈparation des chemins ('/' SI LINUX)
docGen = DocGen('Marien Couvertier, Florian Legendre', ...                 
                'florian.legendre@etu.univ-poitiers.fr',  ...              
                'DocGen', ...                                              
                'GAD Matlab made in Robioss', ...                          
                'D:\Git\projects\wip\DocGenTest\lib\DocGen', ...           
                '\');

            
% ~~~~~~~ Fonction et gÈnÈration des notices locales ~~~~~~~ %
% Argument 1: La racine √†partir de laquelle on g√©n√®re la notice locale.
% Argument 2: Est-ce qu'on Èvalue les fonctions des scripts pr√©sents dans 
%             la racine ou non?
docGen.makeLocalDoc('D:\Git\projects\wip\DocGenTest\codes\Fonctions\Math', false);
docGen.makeLocalDoc('D:\Git\projects\wip\DocGenTest\codes\Fonctions\Plot', false);
docGen.makeLocalDoc('D:\Git\projects\wip\DocGenTest\codes\Fonctions\Plot\Video', false);
docGen.makeLocalDoc('D:\Git\projects\wip\DocGenTest\codes\Fonctions\Spatial_Location', false);


% ~~~~~~~ Fonctionnement et g√©n√©ration de la (ou des?) notice globale  ~~~~~~~ %
% Argument 1: La racine √† partir de laquelle on g√©n√®re la notice globale. 
% Argument 2: La destination o√π on place la notice globale. 
% Argument 3: On affiche tous les fichiers '.html' ou seulement les 
%             index des notices locales.
docGen.makeGlobalDoc('D:\Git\projects\wip\DocGenTest\codes', ...
                     'D:\Git\projects\wip\DocGenTest\docs', false);

                 
%% Suppression rapide d'une ou plusieurs notices
%DocGen.deleteNotice('E:\Git\projects\wip\DocGenTest\codes\Fonctions\Spatial_Location');

