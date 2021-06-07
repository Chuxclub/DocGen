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
addpath('E:\Git\projects\wip\DocGenTest\lib\DocGen\docgen_pkg');

DocGen.notice('E:\Git\projects\wip\DocGenTest\codes\Fonctions\Math', false);
DocGen.notice('E:\Git\projects\wip\DocGenTest\codes\Fonctions\Plot', false);
DocGen.notice('E:\Git\projects\wip\DocGenTest\codes\Fonctions\Plot\Video', false);
DocGen.notice('E:\Git\projects\wip\DocGenTest\codes\Fonctions\Spatial_Location', false);

DocGen.noticeGlobale(true);

%% Suppression rapide d'une ou plusieurs notices
%DocGen.deleteNotice('E:\Git\projects\wip\DocGenTest\codes\Fonctions\Spatial_Location');