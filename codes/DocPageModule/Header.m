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
        function makeHeader(fid, title, longTitle, authors, contact)
            fprintf(fid, '%%%%');
            fprintf(fid, '\n%% <html>');
            fprintf(fid, ' <div class="header" style="background-color: #ffd384; height: fit-content; padding: 20px 20px 5px 20px;  width: auto; "> ');
            fprintf(fid, [' <h1 style="font-size: 28px; margin: 0 0 10px"> ' title ' </h1>']);
            fprintf(fid, [' <caption> ' longTitle ' </caption><br/><br/><br/><br/>']);
            fprintf(fid, ['<p style="margin: 0 0 5px; padding:  10px 0 0 0">Auteurs: ' authors '</p>']);
            fprintf(fid, ['<p>Nous contacter: <a href="mailto:' contact '">' contact '</a> </p>']);
            
            fprintf(fid, ['<p style="margin: 0 0 10px; padding: 0"> Documentation générée le <span style="font-size: 14px; font-weight: bold;">' datestr(datetime('today')) '</span> par DocGen</p>']);
            fprintf(fid, ' </div>');
            fprintf(fid, ' </html>\n');
        end
        
        function makeHyperButton(fid, href, content)
            fprintf(fid, '%%%%');
            fprintf(fid, '\n%% <html>');
            fprintf(fid, '<style>.button {display: block; width: 115px; height: 25px; background: #ffd384; padding: 10px; text-align: center; border-radius: 5px; color: white; font-weight: bold; line-height: 25px; }</style>');
            hyperButton = ['<a href="file:///' [href '\IndexGlobal.html'] '" class="button">' content '</a>'];
            fprintf(fid, "%s", hyperButton);
            fprintf(fid, ' </html>\n');
        end
    end
end