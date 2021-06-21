%% Pages de manuel

% Auteurs: Marien Couvertier (script original), Florian Legendre (màj)    

% Objectif: Fournir des fonctions globales utilisées dans DocGenScript.m  
% pour générer des pages de manuel (aussi appelées notices). Une page de 
% manuel étant l'association d'un index local ou global avec un README 
% local ou global.


%%  Le code source
classdef (Abstract) Manual
    
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