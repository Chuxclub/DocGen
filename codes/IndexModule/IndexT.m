% ======================================================================= %
% ========================= LA TOOLBOX DOCGEN =========================== %
% ======================================================================= %

%                    -------------------------                            %
% Auteurs: Florian Legendre (script original)                             %
%                                                                         %
% Objectif: Fournir les méthodes communes aux index hiérarchiques.        %
%                                                                         %
%                    -------------------------                            %



classdef IndexT < Index
    
    % ############ Méthodes principales ############ %
    methods
        % ~~~~~~~~~~~ Constructeur de l'objet "index hiérarchique":
        function obj = IndexT(pattern, depth, src, dest)
            obj = obj@Index(pattern, depth, src, dest);
        end
        
        % ~~~~~~~~~~~ Construction de l'index hiérarchique:
        function makeIndexT(obj, fid, isExhaustive)
            UtilsTB.clearScript();
            FilesTB.getFiles(obj.getSrc(), obj.getPattern(), 'List.txt');
            
            if ~isExhaustive
                indexList = PathsTB.selectFromPaths('Index', 'List.txt');
            else
                indexList=importdata('List.txt');
            end
            
            subPathsList = PathsTB.excludeFromPathsList('README.html', indexList); 
            subPathsList = PathsTB.cropPaths(subPathsList, [obj.getSrc() PathsTB.setgetVar]);
            sortedSubPathsList = SortsTB.bubbleSortCaseUnsensitive(subPathsList);
            globalIndexArray = obj.globalIndexArrMake(sortedSubPathsList);
            obj.generateHTML(globalIndexArray, fid);
        end
    end
    
    
    % ############ Méthodes auxiliaires (cf. MANUEL_DEV.pdf) ############ %
    methods (Access = private)
        
        % ~~~~~~~~~~~ Index hiérarchique en tableau :        
        function globalIndexArray = globalIndexArrMake(obj, subpathsList)
            % Algorithm initialization %
            appendIdx = 1;
            nbSubpaths = numel(subpathsList);
            precPathRow = PathsTB.explodeSubpath(subpathsList{1}{1}, PathsTB.setgetVar);
            nbNodes = numel(precPathRow);
            for i=1:nbNodes
                nodePath = [obj.getSrc() PathsTB.setgetVar ...
                    PathsTB.concatSubpathFromNodesRow(precPathRow, 1, i)];
                globalIndexArray{appendIdx} = [i, precPathRow(i), nodePath];
                appendIdx = appendIdx + 1;
            end
            
            % Global index making %
            for i=2:nbSubpaths
                currentSubpathRow = PathsTB.explodeSubpath(subpathsList{i}{1}, PathsTB.setgetVar);
                nbNodes = numel(currentSubpathRow);
                
                updatePrecPath = false;
                for j=1:nbNodes
                    if j > numel(precPathRow) || ~strcmp(precPathRow(j), currentSubpathRow(j))
                        updatePrecPath = true;
                    end
                    
                    if updatePrecPath
                        nodePath = [obj.getSrc() PathsTB.setgetVar ...
                            PathsTB.concatSubpathFromNodesRow(currentSubpathRow, 1, j)];
                        globalIndexArray{appendIdx} = [j, currentSubpathRow(j), nodePath];
                        precPathRow(j) = currentSubpathRow(j);
                        appendIdx = appendIdx + 1;
                    end
                end
            end
        end
        
        
        % ~~~~~~~~~~~ Index hiérarchique en HTML appel de la récursive:
        function generateHTML(obj, globalIndexArray, fid)
            fprintf(fid, '%% <html>');
            if(size(globalIndexArray) ~= 0)
                [~] = obj.generateHTML_aux(globalIndexArray, fid, 1);
            end
            fprintf(fid, '\n%% </html>');
        end
        
        
        % ~~~~~~~~~~~ Index hiérarchique en HTML - la récursive:
        function newPos = generateHTML_aux(obj, globalIndexArray, fid, pos)
            fprintf(fid, '\n%% \t<ul>');
            
            while pos <= size(globalIndexArray, 2)
                % ~~~~~~~~ GESTION VARIABLES ~~~~~~~~ %
                % Pour la lisibilité de ce code %
                currentNodeDepth = globalIndexArray{pos}{1};
                currentNodeName = globalIndexArray{pos}{2};
                currentNodePath = globalIndexArray{pos}{3};
                
                % Essentiel pour gérer les fermetures de balise %
                if(pos+1 <= size(globalIndexArray, 2))
                    nextDepth = globalIndexArray{pos+1}{1};
                else
                    nextDepth = 0;
                end
                
                % ~~~~~~~~ GESTION HTML ~~~~~~~~ %
                % Ouverture d'une entrée %
                fprintf(fid, '\n%% \t<li>');
                
                % Gestion du contenu des entrées %
                if contains(currentNodeName, '.html')
                    fprintf(fid, '<a href="file:///%s">%s</a>', currentNodePath, currentNodeName);
                else
                    fprintf(fid, '%s', currentNodeName);
                end
                
                % Fermeture des entrées selon la profondeur %
                if(currentNodeDepth < nextDepth)
                    pos = obj.generateHTML_aux(globalIndexArray, fid, pos+1);
                elseif(currentNodeDepth > nextDepth)
                    for i=1:currentNodeDepth-nextDepth
                        fprintf(fid, '\n%% </li>\n%% </ul>');
                    end
                    
                    if nextDepth ~= 0
                        fprintf(fid, '\n%% </li>');
                    end
                    break;
                else
                    fprintf(fid, '\n%% </li>');
                end
                
                % On boucle %
                pos = pos+1;
            end
            
            newPos = pos;
        end
    end
end