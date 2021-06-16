% ======================================================================= %
% ========================= LA TOOLBOX DOCGEN =========================== %
% ======================================================================= %

%                    -------------------------                            %
% Auteurs: Florian Legendre (script original)                             %
%                                                                         %
% Objectif: Fournir les méthodes spécifiques aux index alphabétiques.     %
%                                                                         %
%                    -------------------------                            %


classdef IndexA < Index
    methods
        function obj = IndexA(pattern, level, src, dest)
            obj@Index(pattern, level, src, dest);
        end
        
        % ~~~~~~~~~~~ Construction de l'index hiérarchique:
        function makeIndexA(obj, fid)
            UtilsTB.clearScript();
            
            % Récupération et tri des scripts publiés en html (ils doivent 
            % donc avoir été publiés avant de lancer cette méthode). La 
            % récupération est limitée au dossier courant défini dans la 
            % propriété Src de l'indexA instancié:
            fileInfosStruct = FilesTB.getFiles([obj.getSrc() '\Notice'], obj.getPattern(), "");
            fileNamesArr = PathsTB.excludeFromPaths('Index', fileInfosStruct);
            sortedFilesList = sort(lower(fileNamesArr));
            
            % On écrit l'index alphabétique par des balises html directement 
            % dans le fichier désigné par le fid:
            fprintf(fid, '\n%%%%\n%% <html>\n');
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
            fprintf(fid, '%% </html>');
        end
    end
end