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
    properties (Constant, Access = private)
        
    end
    
    properties (Access = private)
        
    end
    
    methods
        function obj = IndexT()
            obj@Index(pattern, level, src, dest);
        end
    end
    
    methods (Access = private)
        
    end
end