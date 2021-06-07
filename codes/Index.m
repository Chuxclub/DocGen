% ======================================================================= %
% ========================= LA TOOLBOX DOCGEN =========================== %
% ======================================================================= %

%                    -------------------------                            %
% Auteurs: Florian Legendre (script original)                             %
%                                                                         %
% Objectif: Fournir les méthodes communes à n'importe quel type d'index.  %
%                                                                         %
%                    -------------------------                            %


classdef (Abstract) Index
    properties (Access = private)
        pattern;
        depth;
        src;
        dest;
    end
    
    methods 
        function obj = Index(pattern, depth, src, dest)
            obj.pattern = pattern;
            obj.depth = depth;
            obj.src = src;
            obj.dest = dest;
        end
        
        % ============ GETTERS ============ %
        function objDest = getDest(obj)
            objDest = obj.dest;
            return;
        end
        
        function objDepth = getDepth(obj)
            objDepth = obj.depth;
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