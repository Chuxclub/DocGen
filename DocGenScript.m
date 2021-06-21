% ======================================================================= %
% ========== LE SCRIPT DE MISE A JOUR DE VOTRE DOCUMENTATION ============ %
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


%% Configuration de DocGen
% Configuration de DocGen => pour plus d'optimisation ex�cutez cette 
%                            section qu'une seule fois (Ctrl+Entr�e).
docgenCodesPath = 'D:\Git\projects\wip\DocGenTest\lib\DocGen\codes';
projectCodesPath = 'D:\Git\projects\wip\DocGenTest\codes';
projectGlobalDocDest = 'D:\Git\projects\wip\DocGenTest\docs';
addpath(docgenCodesPath);

% ~~~~~~~ Initialisation de DocGen avec configurations ~~~~~~~ %
% Argument 1: auteurs
% Argument 2: contact
% Argument 3: nom du projet
% Argument 4: nom long du projet
% Argument 5: chemin vers les codes sources du projet
% Argument 6: chemin vers la destination de la notice globale
% Argument 7: chemin vers les modules de DocGen
% Argument 8: symbole s�paration des chemins ('/' SI LINUX)
docGen = DocGen('Marien Couvertier, Florian Legendre', ...
                'florian.legendre@etu.univ-poitiers.fr',  ... 
                docgenCodesPath, ...
                projectCodesPath, ...
                projectGlobalDocDest, ...
                'DocGen', ...       
                'GAD Matlab cr�� par Robioss', ...
                '\');


%% Cr�ation des documentations locales aux modules

% ~~~~~~~ Fonction et g�n�ration des notices locales ~~~~~~~ %
% Argument 1: La racine �partir de laquelle on g�n�re la notice locale.
% Argument 2: Est-ce qu'on �value les fonctions des scripts pr�sents dans 
%             la racine ou non?
docGen.makeLocalDoc([projectCodesPath '\Fonctions\Math'], false);
docGen.makeLocalDoc([projectCodesPath '\Fonctions\Plot'], false);
docGen.makeLocalDoc([projectCodesPath '\Fonctions\Plot\Video'], false);
docGen.makeLocalDoc([projectCodesPath '\Fonctions\Spatial_Location'], false);
docGen.makeLocalDoc([projectCodesPath '\Programmes'], false);


%% Cr�ation de la documentation globale au projet

% ~~~~~~~ Fonctionnement et g�n�ration de la (ou des?) notice globale  ~~~~~~~ %
% Argument 1: La racine �partir de laquelle on g�n�re la notice globale. 
% Argument 2: La destination où on place la notice globale. 
% Argument 3: On affiche tous les fichiers '.html' ou seulement les 
%             index des notices locales.
docGen.makeGlobalDoc(projectCodesPath, projectGlobalDocDest, true);

             
%% Suppression rapide d'une ou plusieurs notices
%DocGen.deleteNotice('E:\Git\projects\wip\DocGenTest\codes\Fonctions\Spatial_Location');

