% ======================================================================= %
% ========================= LA TOOLBOX DOCGEN =========================== %
% ======================================================================= %

%                    -------------------------                            %
% Auteurs: Marien Couvertier (script original), Florian Legendre (màj)    %
%                                                                         %
% Objectif: Fournir des fonctions globales utilisées dans DocGenScript.m  %
% pour mettre à jour la documentation d'un projet.                        %
%                                                                         %
% IMPORTANT: Modifiez les variables globales dans "properties" ci-dessous %
%            selon votre système                                          %
%                                                                         %
% IMPORTANT 2: Si vous êtes sous Linux, allez dans PathsTB.m pour         %
%              configurer le caractère de séparation des fichiers appelé  %
%              SEP_TOKEN.                                                 %
%                                                                         %
%                    -------------------------                            %



classdef (Abstract) DocGen
    
    properties (Constant, Access = private)
        DOC_NAME = 'Notice';
    end   
    
    % ################ GESTION DES NOTICES ################ %
    methods(Static)
        
        % ================ Créer une notice locale ================ %
        function makeLocalDoc(path, eval)
            UtilsTB.clearScript();
            cd(path);
            folderToDocument = PathsTB.cropToLastNode(path);
            
            % ---------- On prépare les options de publication ---------- %
            publishOptions.format='html';
            mkdir(DocGen.DOC_NAME);
            publishOptions.outputDir=[path PathsTB.getSepToken() DocGen.DOC_NAME];
            publishOptions.evalCode = eval;
            
            docPageName = ['Index' folderToDocument '.m'];
            fid = fopen(docPageName,'wt');
            
            Header.makeHeader(fid, 'DocGen Project', 'GAD Matlab made in Robioss', ... 
                              'Marien Couvertier, Florian Legendre');
            
%             % ---------- On prépare le contenu de l'index ---------- %
%             % Header du dossier maître (le nom du dossier dont on génère la doc):
%             Header = ['%% ' folderToDocument];
%             
%             % Titre du dossier:
%             fprintf(fid,'%s\n',Header);
%             fprintf(fid,'%s\n\n','%% Main Functions');
%             fprintf(fid,'%s\n','%%');
%                       
%             Manual.makeLocalManual(fid, path, eval);
            
            %  ---------- On publie l'index ---------- %
            publish(docPageName,publishOptions);
            
            % --------- Nettoyage des fichiers devenus inutiles --------- %
            fclose(fid);
            delete(docPageName);
        end
        
        
        % ================ Créer une notice globale ================ %
        function makeGlobalDoc(src, dest, isIndexExhaustive)
            Manual.makeGlobalManual(src, dest, isIndexExhaustive);
        end
    end
end