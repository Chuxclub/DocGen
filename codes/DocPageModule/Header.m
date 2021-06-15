% ======================================================================= %
% ========================= LA TOOLBOX DOCGEN =========================== %
% ======================================================================= %

%                    -------------------------                            %
% Auteurs: Florian Legendre (script original)                             %
%                                                                         %
% Objectif: Fournir les m√©thodes sp√©cifiques pour g√©n√©rer les header des  %
%           pages de documentation.                                       %
%                                                                         %
%                    -------------------------                            %


classdef (Abstract) Header
    methods (Static)
        function makeHeader(fid, title, longTitle, authors, contact)
            fprintf(fid, '%%%%');
            fprintf(fid, '\n%% <html>');
            fprintf(fid, ' <div class="header" style="background-color: #ffd384; height: fit-content; padding: 20px 20px 5px 20px;  width: auto; "> ');
            fprintf(fid, [' <h1 style="font-size: 28px; margin: 0 0 10px"> ' title ' </h1>']);
            fprintf(fid, [' <caption> ' longTitle ' </caption><br/><br/><br/><br/>']);
            fprintf(fid, ['<p style="margin: 0 0 5px; padding:  10px 0 0 0">Auteurs: ' authors '</p>']);
            fprintf(fid, ['<p>Nous contacter: <a href="mailto:' contact '">' contact '</a> </p>']);
            
            fprintf(fid, ['<p style="margin: 0 0 10px; padding: 0"> Documentation gÈnÈrÈe le <span style="font-size: 14px; font-weight: bold;">' datestr(datetime('today')) '</span></p>']);
            fprintf(fid, ' </div>');
            fprintf(fid, ' </html>\n');
        end
    end
end