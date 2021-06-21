%% Boîte à outils permettant de gérer les fichiers du système

% Auteurs: Florian Legendre (script original)                             

% Objectif: Fournir des méthodes permettant de récupérer des listes de  
%           de fichiers, de manipuler ces listes, etc.                    


%%  Le code source
classdef (Abstract) FilesTB
    methods(Static)
        function fileList = getFiles(src, pattern, filename)
            pathFilesSep = PathsTB.setgetVar;
            
            if filename == ""
                fileList = dir([src pathFilesSep pattern]);
            else
                dos(['dir /s /b ' src pathFilesSep pattern ' > ' filename]);
            end
        end
        
        function getFilesDebug(src, pattern)
            FilesTB.getFiles(src, pattern, 'fetchFilesList.txt');
            
            input(['You are in fetchFiles debug mode. This is just a '...
                'prompt. Feel free to check fetchFilesList.txt to be sure '...
                'that the correct files are being fetched. Press Enter '...
                'when you are done.']);
            
            delete fetchFilesList.txt;
        end
    end
end