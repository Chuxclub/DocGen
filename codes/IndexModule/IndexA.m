%% Index alphab�tiques

% Auteurs: Florian Legendre (script original)
% Objectif: Fournir les m�thodes sp�cifiques aux index alphab�tiques.


%%  Le code source
classdef IndexA < Index
    methods
        function obj = IndexA(pattern, src, dest)
            obj@Index(pattern, src, dest);
        end
        
        % ~~~~~~~~~~ Construction de l'index alphab�tique:
        function makeIndexA(obj, fid)
            UtilsTB.clearScript();
            
            % R�cup�ration et tri des scripts publi�s en html (ils doivent 
            % donc avoir �t� publi�s avant de lancer cette m�thode). La 
            % r�cup�ration est limit�e au dossier courant d�fini dans la 
            % propri�t� Src de l'indexA instanci�:
            fileInfosStruct = FilesTB.getFiles([obj.getSrc() '\Notice'], obj.getPattern(), "");
            fileNamesArr = PathsTB.excludeFromPathsStruct('ManPage_', fileInfosStruct);
            sortedFilesList = SortsTB.bubbleSortCaseUnsensitive(fileNamesArr);
            
            % On �crit l'index alphab�tique par des balises html directement 
            % dans le fichier d�sign� par le fid:
            fprintf(fid, '%% <ul>\n');
            
            previousInitial = 'a';
            for i=1:numel(sortedFilesList)
                if (i == 1 && sortedFilesList{i}(1) == 'a') || sortedFilesList{i}(1) ~= previousInitial
                    previousInitial = sortedFilesList{i}(1);
                    fprintf(fid, '%% </ul>\n');
                    fprintf(fid, ['%% <h5> --- ' upper(previousInitial) ' --- </h5>\n']);
                    fprintf(fid, '%% <ul>\n');
                end
                
                linei{i,1} = ['% <li> <a href="' sortedFilesList{i} '"> ' sortedFilesList{i}(1:end-5) ' </a>'];
                fprintf(fid,'%s </li>\n',linei{i});
            end
            
            fprintf(fid, '%% </ul>\n');
        end
    end
end