% ======================================================================= %
% ========================= LA TOOLBOX DOCGEN =========================== %
% ======================================================================= %

%                    -------------------------                            %
% Auteurs: Marien Couvertier (script original), Florian Legendre (màj)    %
%                                                                         %
% Objectif: Fournir des fonctions globales utilisées dans DocGenScript.m  %
% pour mettre à jour la documentation d'un projet.                        %
%                                                                         %
% IMPORTANT: Modifiez les variables globales dans "properties" ci-dessous %
%            selon votre système                                          %
%                                                                         %
% IMPORTANT 2: Si vous êtes sous Linux, allez dans PathsTB.m pour         %
%              configurer le caractère de séparation des fichiers appelé  %
%              SEP_TOKEN.                                                 %
%                                                                         %
%                    -------------------------                            %



classdef (Abstract) DocGen
    
    properties (Constant, Access = private)
        DOC_NAME = 'Notice';
    end   
    
    % ################ GESTION DES NOTICES ################ %
    methods(Static)
        
        % ================ Créer une notice locale ================ %
        function makeLocalDoc(path, eval)
            UtilsTB.clearScript();
            cd(path);
            folderToDocument = PathsTB.cropToLastNode(path);
            
            % ---------- On prépare les options de publication ---------- %
            publishOptions.format='html';
            mkdir(DocGen.DOC_NAME);
            publishOptions.outputDir=[path PathsTB.getSepToken() DocGen.DOC_NAME];
            publishOptions.evalCode = eval;
            
            
            % ---------- On crée le script (.m) de la notice locale qui sera publiée ---------- %
            docPageName = ['Index' folderToDocument '.m'];
            fid = fopen(docPageName,'wt');
            
            Header.makeHeader(fid, 'DocGen Project', 'GAD Matlab made in Robioss', ... 
                              'Marien Couvertier, Florian Legendre');
            
            % ---------- On prépare le contenu de l'index ---------- %
            % Header du dossier maître (le nom du dossier dont on génère la doc):
            header = ['Notice locale du module: ' folderToDocument];
            
            % Titre du dossier:
            fprintf(fid,'\n%%%% \n%% <html> <h2 style="border-bottom: 0; color:#d55000; font-size:1.3em; margin-top: 50px;"> %s </h2> </html>\n',header);
            fprintf(fid,'\n%%%% \n%% <html> <h3 style="border-bottom: 1px solid #d6d4d4; margin-bottom: 0;"> Main Functions </h3> </html>\n');
            fprintf(fid,'%s\n','%%');
                      
            Manual.makeLocalManual(fid, path, publishOptions);
            
            % ----------------------- Publication ----------------------- %
            publish(docPageName,publishOptions);
            
            % --------- Nettoyage des fichiers devenus inutiles --------- %
            fclose(fid);
            delete(docPageName);
        end
        
        
        % ================ Créer une notice globale ================ %
        function makeGlobalDoc(src, dest, isIndexExhaustive)
            UtilsTB.clearScript();
            addpath(genpath(dest))
            cd(dest)
            
            % ---------- On prépare les options de publication ---------- %
            publishOptions.format = 'html';
            publishOptions.outputDir = dest;
            publishOptions.evalCode = false;
            
            % ---------- On crée le script (.m) de la notice globale qui sera publiée ---------- %
            filename = ('IndexGlobal.m');
            fid = fopen(filename,'wt');
            
            Header.makeHeader(fid, 'DocGen Project', 'GAD Matlab made in Robioss', ... 
                              'Marien Couvertier, Florian Legendre');
                          
            Manual.makeGlobalManual(fid, src, dest, isIndexExhaustive);
            
            % ----------------------- Publication ----------------------- %
            publish(filename,publishOptions);
            
            % --------- Nettoyage des fichiers devenus inutiles --------- %
            fclose(fid);
            delete IndexGlobal.m;
        end
    end
end