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
DocGen.notice('/home/crex/projects/MatLab_Template/codes/Math', false);
DocGen.notice('/home/crex/projects/MatLab_Template/codes/Plot', false);
%DocGen.notice('/home/crex/projects/MatLab_Template/codes/Plot/Video', false);

DocGen.noticeGlobale();

%% Suppression rapide d'une ou plusieurs notices
%DocGen.deleteNotice('/home/crex/projects/MatLab_Template/codes/Plot/Video');