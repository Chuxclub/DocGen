%% Boîte à outils contenant des algorithmes de tri

% Auteurs: Florian Legendre (script original)                             

% Objectif: Fournir des méthodes de tri utilisables sur n'importe quel   
%           projet Matlab                                                 


%%  Le code source
classdef SortsTB
    methods(Static)
        function sortedArray = bubbleSortCaseUnsensitive(arrayToSort)
            sortedArray = arrayToSort;
            M = length(sortedArray);
            for i = 1:M-1
                for j = 1:M-1
                    curr = sortedArray{j};
                    next = sortedArray{j+1};
                    if upper(convertCharsToStrings(curr)) > upper(convertCharsToStrings(next))
                        sortedArray{j} = next;
                        sortedArray{j+1} = curr;
                    end
                end
            end
        end
    end
end