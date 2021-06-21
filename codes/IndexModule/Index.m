%% Index hiérarchiques

% Auteurs: Florian Legendre (script original)
% Objectif: Fournir les méthodes communes à n'importe quel type d'index


%%  Le code source
classdef (Abstract) Index
    properties (Access = private)
        pattern;
        src;
        dest;
    end
    
    methods 
        function obj = Index(pattern, src, dest)
            obj.pattern = pattern;
            obj.src = src;
            obj.dest = dest;
        end
        
        % ============ GETTERS ============ %
        function objDest = getDest(obj)
            objDest = obj.dest;
            return;
        end
        
        function objPattern = getPattern(obj)
            objPattern = obj.pattern;
            return;
        end
        
        function objSrc = getSrc(obj)
            objSrc = obj.src;
            return;
        end
    end
end