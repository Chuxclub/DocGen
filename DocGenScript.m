% ======================================================================= %
% ========== LE SCRIPT DE MISE À JOUR DE VOTRE DOCUMENTATION ============ %
% ======================================================================= %

%                    -------------------------                            %
% Auteurs: Marien Couvertier (script original), Florian Legendre (m�j)    %
%                                                                         %
% Objectif: Fournir un espace unique de mise �jour de la documentation   %
% du projet.                                                              %
%                                                                         %
% IMPORTANT: Modifiez les variables globales dans DocGen.m, dans          %
% "properties" selon votre syst�me                                        %
%                    -------------------------                            %


%% Création de la documentation

% Chemin vers les modules utilisés par ce script:
addpath('D:\Git\projects\wip\DocGenTest\lib\DocGen\codes');
addpath('D:\Git\projects\wip\DocGenTest\lib\DocGen\codes\DocPageModule');
addpath('D:\Git\projects\wip\DocGenTest\lib\DocGen\codes\IndexModule');
addpath('D:\Git\projects\wip\DocGenTest\lib\DocGen\codes\IndexModule\IndexToolsModule');

docGen = DocGen('Marien Couvertier, Florian Legendre', 'florian.legendre@etu.univ-poitiers.fr',  ...
                 'DocGen', 'GAD Matlab made in Robioss', '\');

% Fonction et g�n�ration des notices locales:
% Premier argument   = la racine à partir de laquelle on génère la notice locale.
% Second argument    = est-ce qu'on évalue les fonctions des scripts
%                      présents dans la racine ou non?
docGen.makeLocalDoc('D:\Git\projects\wip\DocGenTest\codes\Fonctions\Math', false);
docGen.makeLocalDoc('D:\Git\projects\wip\DocGenTest\codes\Fonctions\Plot', false);
docGen.makeLocalDoc('D:\Git\projects\wip\DocGenTest\codes\Fonctions\Plot\Video', false);
docGen.makeLocalDoc('D:\Git\projects\wip\DocGenTest\codes\Fonctions\Spatial_Location', false);


% % Fonctionnement et génération de la (ou des?) notice globale:
% % Premier argument   = la racine à partir de laquelle on génère la notice globale. 
% % Second argument    = la destination où on place la notice globale. 
% % Troisième argument = on affiche tous les fichiers '.html' ou seulement les 
% %                      index des notices locales.
docGen.makeGlobalDoc('D:\Git\projects\wip\DocGenTest\codes', ...
                     'D:\Git\projects\wip\DocGenTest\docs', false);

                 
%% Suppression rapide d'une ou plusieurs notices
%DocGen.deleteNotice('E:\Git\projects\wip\DocGenTest\codes\Fonctions\Spatial_Location');

