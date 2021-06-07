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
        GLOBAL_NOTICE_SRC = 'E:\Git\projects\wip\DocGenTest\codes';
        GLOBAL_NOTICE_DEST = 'E:\Git\projects\wip\DocGenTest\docs';
        
        % SI LINUX:
        %RECOVER_HTML_CMD = ['find ' DocGen.GLOBAL_NOTICE_SRC ' | grep .html > List.txt'];
        % SI WINDOWS:
        RECOVER_HTML_CMD = ['dir /s /b ' DocGen.GLOBAL_NOTICE_SRC '\*.html > List.txt'];
        
        DOC_NAME = 'Notice';
    end
    
    methods(Static)
        % ============= GESTION DES NOTICES ============= %
        function deleteNotice(path)
            rmdir([path PathsTB.getSepToken() DocGen.DOC_NAME], 's');
        end
        
        function notice(path, eval)
            UtilsTB.clearScript();
            cd(path);
            
            % ---------- On récupère le nom du dossier ---------- %
            Nom = PathsTB.getFileFromAbsolutePath(path);
            
            % ---------- On récupère les noms des scripts du dossier ---------- %
            FileInfos = FilesTB.getFiles(path, '*.m', "");
            k=0;
            for i=1:length(FileInfos)
                if FileInfos(i).isdir==0 %pour gérer les sous dossiers présents
                    k=k+1;
                    ListF{k,1}=FileInfos(i).name;
                end
            end
            
            % ---------- On prépare les options de publication ---------- %
            publishOptions.format='html';
            mkdir(DocGen.DOC_NAME);
            publishOptions.outputDir=[path PathsTB.getSepToken() DocGen.DOC_NAME];
            publishOptions.evalCode = eval;
            
            % ---------- On prépare le contenu de l'index ---------- %
            % Header du dossier maître (le nom du dossier dont on génère la doc):
            Header = ['%% ' Nom];
            filename = ['Index' Nom '.m'];
            fid = fopen(filename,'wt');
            
            % Titre du dossier:
            fprintf(fid,'%s\n',Header);
            fprintf(fid,'%s\n\n','%% Main Functions');
            fprintf(fid,'%s\n','%%');
            
            
            % ---------- On publie les fichiers ---------- %
            % Préallocation:
            nbFichiers = numel(ListF);
            linei=cell(nbFichiers,1);
            for i=1:nbFichiers
                % Création de l'index (cf. Markup) par une bullet list
                % (% *) et hyperliens (< ... >):
                linei{i,1} = ['% * <' ListF{i}(1:end-2) '.html ' ListF{i}(1:end-2) '>'];
                fprintf(fid,'%s\n',linei{i});
            end
            
            % Publication:
            fclose(fid);
            for i=1:nbFichiers
                publish(ListF{i},publishOptions);
            end
            
            %  ---------- On publie l'index ---------- %
            publish(filename,publishOptions);
            
            % --------- Nettoyage des fichiers devenus inutiles --------- %
            delete(filename);
        end
        
        function noticeGlobale(isIndexExhaustive)
            UtilsTB.clearScript();
            
            addpath(genpath(DocGen.GLOBAL_NOTICE_DEST))
            cd(DocGen.GLOBAL_NOTICE_DEST)
            
            % ----------------- Récupération des données ---------------- %
            [~,~]=dos(DocGen.RECOVER_HTML_CMD);
            LISTE=importdata('List.txt');
            
            h=0;
            for i=1:numel(LISTE)
                A{i,1}=strfind(LISTE{i,1},'Index');
                if ~isempty(A{i,1})
                    h=h+1;
                    ListeIndex{h,1}=LISTE{i,1};
                    Nom{h,1} = PathsTB.getFileFromAbsolutePath(ListeIndex{h,1});
                end
            end
            
            % ---------- On prépare les options de publication ---------- %
            publishOptions.format = 'html';
            publishOptions.outputDir = DocGen.GLOBAL_NOTICE_DEST;
            publishOptions.evalCode = false;
            
            % ---------- On crée le script (.m) de l'index global qui sera publié ---------- %
            filename = ('IndexGlobal.m');
            fid = fopen(filename,'wt');
            
            % ---------- On prépare le contenu de l'index global (son .m) ---------- %
            fprintf(fid,'%s\n\n','%% Index Global');
            fprintf(fid,'%s\n\n','%% Purpose');
            fprintf(fid,'%s\n','% Index global de toute la documentation des fonctions contenues dans les différents dossiers');
            fprintf(fid,'%s\n\n','%% Main Index');
            fprintf(fid,'%s\n','%%');
            
            %  ---------- On publie l'index global ---------- %
            % Préallocation:
            indexT = IndexT('*.html', 10, DocGen.GLOBAL_NOTICE_SRC, DocGen.GLOBAL_NOTICE_DEST);
            indexT.makeIndexGlobal(fid, isIndexExhaustive);
            
            % Publication:
            publish(filename,publishOptions);
            
            % --------- Nettoyage des fichiers devenus inutiles --------- %
            delete List.txt;
            fclose(fid);
            delete IndexGlobal.m;
        end
    end
end