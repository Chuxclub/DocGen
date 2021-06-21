% ======================================================================= %
% ========================= LA TOOLBOX DOCGEN =========================== %
% ======================================================================= %

%                    -------------------------                            %
% Auteurs: Marien Couvertier (script original), Florian Legendre (màj)    %
%                                                                         %
% Objectif: Fournir des fonctions globales utilisées dans DocGenScript.m  %
% pour mettre à jour la documentation d'un projet.                        %
%                                                                         %
% IMPORTANT: Modifiez les variables globales dans "properties" ci-dessous %
%            selon votre système                                          %
%                                                                         %
% IMPORTANT 2: Si vous êtes sous Linux, allez dans PathsTB.m pour         %
%              configurer le caractère de séparation des fichiers appelé  %
%              SEP_TOKEN.                                                 %
%                                                                         %
%                    -------------------------                            %



classdef (Abstract) Manual
    
    properties (Constant, Access = private)
        DOC_NAME = 'Notice';
    end
    
    % ################ GESTION DES NOTICES ################ %
    methods(Static)
        
        % ================ Créer une notice locale ================ %
        function makeLocalManual(fid, path, publishOptions)
            % ---------- On récupère les noms des scripts du dossier ---------- %
            FileInfos = FilesTB.getFiles(path, '*.m', "");
            k=0;
            for i=1:length(FileInfos)
                if FileInfos(i).isdir==0 %pour gérer les sous dossiers présents
                    k=k+1;
                    ListF{k,1}=FileInfos(i).name;
                end
            end
            
            % ---------- On publie les fichiers ---------- %
            % Préallocation:
            nbFichiers = numel(ListF);
            
            % Publication:
            for i=1:nbFichiers
                publish(ListF{i}, publishOptions);
            end
            
            fprintf(fid,'\n%%%% \n%% <html> <div style="display: table; width: 100%%;">');
            fprintf(fid, '\n%% <div style="display: table-cell; vertical-align: top;">\n');
            indexA = IndexA('*.html', path, './');
            indexA.makeIndexA(fid);
            fprintf(fid, '%% </div>');
            
            readme = FilesTB.getFiles(path, 'README.html', "");
            
            if ~isempty(readme)
                fprintf(fid, "\n%% <div style='display: table-cell; float: right;'> <iframe src='..\\README.html' style='height: 80vh; width:70vw;'> </iframe> </div>");
            end
            
            fprintf(fid,'\n%% </div> </html>');
        end
        
        
        % ================ Créer une notice globale ================ %
        function makeGlobalManual(fid, src, dest, isIndexExhaustive)
            fprintf(fid,'\n%%%% \n%% <html> <div style="display: table; width: 100%%;">');
            fprintf(fid, '\n%% <div style="display: table-cell; vertical-align: top;">');
            indexT = IndexT('*.html', src, dest);
            indexT.makeIndexT(fid, isIndexExhaustive);
            fprintf(fid, '\n%% </div>');
            
            readme = FilesTB.getFiles(src, 'README.html', "");
            
            if ~isempty(readme)
                fprintf(fid, "\n");
                htmlTag = ["% <div style='display: table-cell; float: right;'> <iframe src='file:///" src "\README.html' style='height: 80vh; width:70vw;'></iframe> </div>"];
                fprintf(fid, "%s", htmlTag);
            end
            
            fprintf(fid,'\n%% </div> </html>');
            
            % --------- Nettoyage des fichiers devenus inutiles --------- %
            delete List.txt;
        end
    end
end