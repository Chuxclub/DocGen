% ======================================================================= %
% ========================= LA TOOLBOX DOCGEN =========================== %
% ======================================================================= %

%                    -------------------------                            %
% Auteurs: Florian Legendre (script original)                             %
%                                                                         %
% Objectif: Fournir les méthodes spécifiques pour générer les header des  %
%           pages de documentation.                                       %
%                                                                         %
%                    -------------------------                            %


classdef (Abstract) Header
    methods (Static)
        function makeHeader(fid, title, longTitle, authors)
            fprintf(fid, '%%%%');
            fprintf(fid, '\n%% <html>');
            fprintf(fid, ' <div class="header" style="background-color: #ffd384; height: fit-content; padding: 20px 20px 5px 20px;  width: auto; "> ');
            fprintf(fid, [' <h1 style="font-size: 28px;"> ' title ' </h1>']);
            fprintf(fid, [' <caption> ' longTitle ' </caption><br/><br/><br/><br/>']);
            fprintf(fid, ['<p>' authors '</p>']);
            fprintf(fid, ['<p> Documentation générée le <span style="font-size: 14px; font-weight: bold;">' datestr(datetime('today')) '</span></p>']);
            fprintf(fid, ' </div>');
            fprintf(fid, ' </html>');
        end
    end
end