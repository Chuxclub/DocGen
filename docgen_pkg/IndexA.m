% ======================================================================= %
% ========================= LA TOOLBOX DOCGEN =========================== %
% ======================================================================= %

%                    -------------------------                            %
% Auteurs: Florian Legendre (script original)                             %
%                                                                         %
% Objectif: Fournir les méthodes spécifiques aux index alphabétiques.     %
%                                                                         %
%                    -------------------------                            %


classdef IndexA < Index
    methods
        function obj = IndexA(pattern, level, src, dest)
            obj@Index(pattern, level, src, dest);
        end
    end
end