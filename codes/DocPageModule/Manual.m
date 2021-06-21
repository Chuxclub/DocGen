% ======================================================================= %
% ========================= LA TOOLBOX DOCGEN =========================== %
% ======================================================================= %

%                    -------------------------                            %
% Auteurs: Marien Couvertier (script original), Florian Legendre (m�j)    %
%                                                                         %
% Objectif: Fournir des fonctions globales utilis�es dans DocGenScript.m  %
% pour mettre �jour la documentation d'un projet.                        %
%                                                                         %
% IMPORTANT: Modifiez les variables globales dans "properties" ci-dessous %
%            selon votre syst�me                                          %
%                                                                         %
% IMPORTANT 2: Si vous �tes sous Linux, allez dans PathsTB.m pour         %
%              configurer le caract�re de s�paration des fichiers appel�  %
%              SEP_TOKEN.                                                 %
%                                                                         %
%                    -------------------------                            %



classdef (Abstract) Manual
    
    properties (Constant, Access = private)
        DOC_NAME = 'Notice';
    end
    
    % ################ GESTION DES NOTICES ################ %
    methods(Static)
        
        % ================ Cr�er une notice locale ================ %
        function makeLocalManual(fid, path, publishOptions)
            % ---------- On r�cup�re les noms des scripts du dossier ---------- %
            FileInfos = FilesTB.getFiles(path, '*.m', "");
            k=0;
            for i=1:length(FileInfos)
                if FileInfos(i).isdir==0 %pour g�rer les sous dossiers pr�sents
                    k=k+1;
                    ListF{k,1}=FileInfos(i).name;
                end
            end
            
            % ---------- On publie les fichiers ---------- %
            % Pr�allocation:
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
        
        
        % ================ Cr�er une notice globale ================ %
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