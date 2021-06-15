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
            fileInfos = FilesTB.getFiles([obj.getSrc() '\Notice'], obj.getPattern(), '');
            
            % ---------- On récupère les noms des html du dossier ---------- %
            k=0;
            for i=1:length(fileInfos)
                if fileInfos(i).isdir==0 %pour gérer les sous dossiers présents
                    k=k+1;
                    ListF{k}=fileInfos(i).name;
                end
            end
            
            sortedFilesList = sort(lower(ListF));
            
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