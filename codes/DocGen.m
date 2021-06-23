%% DocGen

% Auteurs: Marien Couvertier (script original), Florian Legendre (màj)    

% Objectif: Fournir des fonctions globales utilisées dans DocGenScript.m  
% pour mettre à jour la documentation d'un projet.                        


%%  Le code source
classdef DocGen
    properties (SetAccess = immutable)
        AUTHORS;
        CONTACT;
        DOC_NAME = 'Notice';
        PROJECT_CODES_PATH;
        PROJECT_GLOBAL_DOC_DEST;
        PROJECT_NAME;
        PROJECT_SUBNAME;
    end   
    
    % ################ GESTION DES NOTICES ################ %
    methods
        % ================ Constructeur d'une instance de DocGen ================ %
        function obj = DocGen(authors, contact, docGenPath, projectCodesPath, projectGlobalDocDest, ...
                              projectName, projectSubname, sepToken)
            addpath([docGenPath '\DocPageModule']);
            addpath([docGenPath '\IndexModule']);
            addpath([docGenPath '\MatlabModule']);
            addpath([docGenPath '\StringModule']);
            
            obj.AUTHORS = authors;
            obj.CONTACT = contact;
            obj.PROJECT_CODES_PATH = projectCodesPath;
            obj.PROJECT_GLOBAL_DOC_DEST = projectGlobalDocDest;
            obj.PROJECT_NAME = projectName;
            obj.PROJECT_SUBNAME = projectSubname;
            PathsTB.setgetVar(sepToken);
        end
        
        % ================ Créer une notice locale ================ %
        function makeLocalDoc(obj, path, eval)
            UtilsTB.clearScript();
            cd(path);
            folderToDocument = PathsTB.cropToLastNode(path);
            
            % ---------- On prépare les options de publication ---------- %
            publishOptions.format='html';
            mkdir(obj.DOC_NAME);
            publishOptions.outputDir=[path PathsTB.setgetVar obj.DOC_NAME];
            publishOptions.evalCode = eval;
            
            % ---------- On crée la page .m de la notice locale qui sera publiée ---------- %
            docPageName = ['ManPage_' folderToDocument '.m'];
            fid = fopen(docPageName,'wt');
            
            Header.makeHeader(fid, obj.PROJECT_NAME, obj.PROJECT_SUBNAME, obj.AUTHORS, obj.CONTACT);
            Header.makeHyperButton(fid, obj.PROJECT_GLOBAL_DOC_DEST, "Accueil");
            
            % Header du dossier maître (le nom du dossier dont on génère la doc):
            header = ['Notice locale du module: ' folderToDocument];
            
            % Titre du dossier:
            fprintf(fid,'\n%%%% \n%% <html> <style> .content{padding: 0 20px 20px 20px;} </style> </html>\n');
            fprintf(fid,'\n%%%% \n%% <html> <h2 style="border-bottom: 0; color:#d55000; font-size:1.3em; margin-top: 50px;"> %s </h2> </html>\n',header);
            fprintf(fid,'\n%%%% \n%% <html> <h3 style="border-bottom: 1px solid #d6d4d4; margin-bottom: 0;"> Main Functions </h3> </html>\n');
            
            Manual.makeLocalManual(fid, path, publishOptions);
            
            % ----------------------- Publication ----------------------- %
            publish(docPageName,publishOptions);
            
            % --------- Nettoyage des fichiers devenus inutiles --------- %
            fclose(fid);
            delete(docPageName);
        end
        
        
        % ================ Créer une notice globale ================ %
        function makeGlobalDoc(obj, src, dest, isIndexExhaustive)
            UtilsTB.clearScript();
            addpath(genpath(dest))
            cd(dest)
            
            % ---------- On prépare les options de publication ---------- %
            publishOptions.format = 'html';
            publishOptions.outputDir = dest;
            publishOptions.evalCode = false;
            
            % ---------- On crée la page .m de la notice globale qui sera publiée ---------- %
            docPageName = ('ManPage_Global.m');
            fid = fopen(docPageName,'wt');
            
            Header.makeHeader(fid, obj.PROJECT_NAME, obj.PROJECT_SUBNAME, obj.AUTHORS, obj.CONTACT);
            
            % Header du dossier maître (le nom du dossier dont on génère la doc):
            header = 'Page d''accueil';
            
            % Titre du dossier:
            fprintf(fid,'\n%%%% \n%% <html> <style> .content{padding: 0 20px 20px 20px;} </style> </html>\n');
            fprintf(fid,'\n%%%% \n%% <html> <h2 style="border-bottom: 0; color:#d55000; font-size:1.3em; margin-top: 50px;"> %s </h2> </html>\n',header);
            fprintf(fid,'\n%%%% \n%% <html> <h3 style="border-bottom: 1px solid #d6d4d4; margin-bottom: 0;"> Main Functions </h3> </html>\n');
            fprintf(fid,'%s\n','%%');
            
            Manual.makeGlobalManual(fid, src, dest, isIndexExhaustive);
            
            % ----------------------- Publication ----------------------- %
            publish(docPageName,publishOptions);
            
            % --------- Nettoyage des fichiers devenus inutiles --------- %
            fclose(fid);
            delete ManPage_Global.m;
        end
    end
end