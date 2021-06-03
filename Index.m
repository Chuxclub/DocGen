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
        function objDest = getDest(~)
            objDest = obj.dest;
        end
        
        function objLevel = getLevel(~)
            objLevel = obj.level;
        end
        
        function objPattern = getPattern(~)
            objPattern = obj.pattern;
        end
        
        function objSrc = getSrc(~)
            objSrc = obj.src;
        end
    end
end