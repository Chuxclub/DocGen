% ======================================================================= %
% ========================= LA TOOLBOX DOCGEN =========================== %
% ======================================================================= %

%                    -------------------------                            %
% Auteurs: Florian Legendre (script original)                             %
%                                                                         %
% Objectif: Fournir des méthodes permettant de récupérer des listes de    %
%           de fichiers, de manipuler ces listes, etc.                    %
%                                                                         %
%                    -------------------------                            %


classdef (Abstract) FilesTB
    methods(Static)
        function fileList = getFiles(src, pattern, filename)
            if filename == ""
                fileList = dir([src PathsTB.getSepToken() pattern]);
            else
                sepToken = PathsTB.getSepToken();
                dos(['dir /s /b ' src sepToken pattern ' > ' filename]);
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