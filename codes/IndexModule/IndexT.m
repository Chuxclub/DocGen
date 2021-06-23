%% Index hi�rarchiques

% Auteurs: Florian Legendre (script original)
% Objectif: Fournir les m�thodes communes aux index hi�rarchiques


%%  Le code source
classdef IndexT < Index
    
    % ############ M�thodes principales ############ %
    methods
        % ~~~~~~~~~~~ Constructeur de l'objet "index hi�rarchique":
        function obj = IndexT(pattern, src, dest)
            obj = obj@Index(pattern, src, dest);
        end
        
        % ~~~~~~~~~~~ Construction de l'index hi�rarchique:
        function makeIndexT(obj, fid, isExhaustive)
            UtilsTB.clearScript();
            FilesTB.getFiles(obj.getSrc(), obj.getPattern(), 'List.txt');
            
            if ~isExhaustive
                indexList = PathsTB.selectFromPaths('ManPage_', 'List.txt');
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
    
    
    % ############ M�thodes auxiliaires (cf. MANUEL_DEV.pdf) ############ %
    methods (Access = private)
        
        % ~~~~~~~~~~~ Index hi�rarchique en tableau :        
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
        
        
        % ~~~~~~~~~~~ Index hi�rarchique en HTML appel de la r�cursive:
        function generateHTML(obj, globalIndexArray, fid)
            if(size(globalIndexArray) ~= 0)
                [~] = obj.generateHTML_aux(globalIndexArray, fid, 1);
            end
        end
        
        
        % ~~~~~~~~~~~ Index hi�rarchique en HTML - la r�cursive:
        function newPos = generateHTML_aux(obj, globalIndexArray, fid, pos)
            fprintf(fid, '\n%% \t<ul>');
            
            while pos <= size(globalIndexArray, 2)
                % ~~~~~~~~ GESTION VARIABLES ~~~~~~~~ %
                % Pour la lisibilit� de ce code %
                currentNodeDepth = globalIndexArray{pos}{1};
                currentNodeName = globalIndexArray{pos}{2};
                currentNodePath = globalIndexArray{pos}{3};
                
                % Essentiel pour g�rer les fermetures de balise %
                if(pos+1 <= size(globalIndexArray, 2))
                    nextDepth = globalIndexArray{pos+1}{1};
                else
                    nextDepth = 0;
                end
                
                % ~~~~~~~~ GESTION HTML ~~~~~~~~ %
                % Ouverture d'une entr�e %
                fprintf(fid, '\n%% \t<li>');
                
                % Gestion du contenu des entr�es %
                if contains(currentNodeName, '.html')
                    fprintf(fid, '<a href="file:///%s">%s</a>', currentNodePath, currentNodeName);
                else
                    fprintf(fid, '%s', currentNodeName);
                end
                
                % Fermeture des entr�es selon la profondeur %
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