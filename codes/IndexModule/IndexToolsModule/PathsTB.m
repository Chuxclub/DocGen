% ======================================================================= %
% ========================= LA TOOLBOX DOCGEN =========================== %
% ======================================================================= %

%                    -------------------------                            %
% Auteurs: Florian Legendre (script original)                             %
%                                                                         %
% Objectif: Fournir des méthodes permettant de manipuler des chaînes de   %
%           caractères représentant des chemins absolus.                  %
%                                                                         %
%                    -------------------------                            %


classdef PathsTB
    properties (Constant, Access = private)
        % Token de séparation des fichiers dans les chemins absolus. 
        % Configuration nécessaire pour certains algorithmes utilisés dans
        % DocGen. Si linux -> '/' :
        SEP_TOKEN = '\'; 
    end
    
    methods(Static)
        % =================== GETTERS =================== %
        function sepToken = getSepToken()
            sepToken = PathsTB.SEP_TOKEN;
        end
        
        % ============== LA BOITE A OUTILS ============== %
        function nodePath = concatSubpathFromNodesRow(pathRow, start, stop)
            subPathUptoNode = pathRow(1, [start:stop]);
            nodePath = strjoin(subPathUptoNode, PathsTB.SEP_TOKEN);
        end
        
        function subPathsList = cropPaths(pathsList, pattern)
            nbPaths = numel(pathsList);
            for i=1:nbPaths
                subPathsList{i} = erase(pathsList{i}, pattern);
            end
        end
        
        function nodeName = cropToLastNode(path)
            htap = flip(path);
            emanelif = strtok(htap, PathsTB.getSepToken());
            nodeName = flip(emanelif);
        end
        
        function explodedSubpath = explodeSubpath(subPath, explodeDelimiter)
            explodedSubpath = regexp(subPath, explodeDelimiter, 'split');
        end
        
        function matchingPathsList = selectFromPaths(pattern, filename)
            htmlList=importdata(filename);
            
            h=0;
            nbHtmlFiles = numel(htmlList);
            for i=1:nbHtmlFiles
                A{i,1}=strfind(htmlList{i,1}, pattern);
                if ~isempty(A{i,1})
                    h = h+1;
                    matchingPathsList{h,1} = htmlList{i,1};
                end
            end
        end 
    end
end