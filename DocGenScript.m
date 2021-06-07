% ======================================================================= %
% ========== LE SCRIPT DE MISE À JOUR DE VOTRE DOCUMENTATION ============ %
% ======================================================================= %

%                    -------------------------                            %
% Auteurs: Marien Couvertier (script original), Florian Legendre (màj)    %
%                                                                         %
% Objectif: Fournir un espace unique de mise à jour de la documentation   %
% du projet.                                                              %
%                                                                         %
% IMPORTANT: Modifiez les variables globales dans DocGen.m, dans          %
% "properties" selon votre système                                        %
%                    -------------------------                            %


%% Création de la documentation

% Chemin vers les modules utilisés par ce script:
addpath('E:\Git\projects\wip\DocGenTest\lib\DocGen\codes');

% Fonction et génération des notices locales:
% Premier argument   = la racine à partir de laquelle on génère la notice locale.
% Second argument    = est-ce qu'on évalue les fonctions des scripts
%                      présents dans la racine ou non?
DocGen.notice('E:\Git\projects\wip\DocGenTest\codes\Fonctions\Math', false);
DocGen.notice('E:\Git\projects\wip\DocGenTest\codes\Fonctions\Plot', false);
DocGen.notice('E:\Git\projects\wip\DocGenTest\codes\Fonctions\Plot\Video', false);
DocGen.notice('E:\Git\projects\wip\DocGenTest\codes\Fonctions\Spatial_Location', false);

% DocGen.notice('E:\Git\projects\wip\DocGenTest\lib\DocGen\codes', false);


% Fonctionnement et génération de la (ou des?) notice globale:
% Premier argument   = la racine à partir de laquelle on génère la notice globale. 
% Second argument    = la destination où on place la notice globale. 
% Troisième argument = on affiche tous les fichiers '.html' ou seulement les 
%                      index des notices locales.
DocGen.noticeGlobale('E:\Git\projects\wip\DocGenTest\codes', ...
                     'E:\Git\projects\wip\DocGenTest\docs', true);
                 
% DocGen.noticeGlobale('E:\Git\projects\wip\DocGenTest\lib\DocGen\codes', ...
%                      'E:\Git\projects\wip\DocGenTest\lib\DocGen\docs', true);

                 
%% Suppression rapide d'une ou plusieurs notices
%DocGen.deleteNotice('E:\Git\projects\wip\DocGenTest\codes\Fonctions\Spatial_Location');

