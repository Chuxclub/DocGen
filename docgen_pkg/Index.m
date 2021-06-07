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
        level;
        src;
        dest;
    end
    
    methods 
        function obj = Index(pattern, level, src, dest)
            obj.pattern = pattern;
            obj.level = level;
            obj.src = src;
            obj.dest = dest;
        end
        
        % ============ GETTERS ============ %
        function objDest = getDest(obj)
            objDest = obj.dest;
            return;
        end
        
        function objLevel = getLevel(obj)
            objLevel = obj.level;
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