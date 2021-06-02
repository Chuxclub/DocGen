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
% selon votre système                                                     %
%                    -------------------------                            % 


classdef (Abstract) DocGen
    properties (Constant, Access = private)
        % SI LINUX:
        %GLOBAL_NOTICE_SRC = '/home/crex/projects/MatLab_Template/codes';
        % SI WINDOWS:
        GLOBAL_NOTICE_SRC = 'E:\Git\projects\wip\DocGenTest\codes';
        
        % SI LINUX:
        %GLOBAL_NOTICE_DEST = '/home/crex/projects/MatLab_Template/docs';
        % SI WINDOWS:
        GLOBAL_NOTICE_DEST = 'E:\Git\projects\wip\DocGenTest\docs';
        
        % SI LINUX:
        %SEP_TOKEN = '/';
        % SI WINDOWS:
        SEP_TOKEN = '\';
        
        % SI LINUX:
        %RECOVER_HTML_CMD = ['find ' DocGen.GLOBAL_NOTICE_SRC ' | grep .html > List.txt'];
        % SI WINDOWS:
        RECOVER_HTML_CMD = ['dir /s /b ' DocGen.GLOBAL_NOTICE_SRC '\*.html > List.txt'];
        
        DOC_NAME = 'Notice';
    end
    
    methods(Static)
        function deleteNotice(path)
            cd(path);
            rmdir(DocGen.DOC_NAME, 's');
        end
        
        function indexList = indexSelect(file)
            htmlList=importdata(file);

            h=0;
            nbHtmlFiles = numel(htmlList);
            for i=1:nbHtmlFiles
                A{i,1}=strfind(htmlList{i,1},'Index');
                if ~isempty(A{i,1})
                    h = h+1;
                    indexList{h,1} = htmlList{i,1};
                end
            end
        end
        
        function recoverDocs()
            [~,~] = dos(DocGen.RECOVER_HTML_CMD);
        end
        
        function subpathsList = rootRemove(indexList, pathRoot)
            nbIndexes = numel(indexList);
            for i=1:nbIndexes
                subpathsList{i} = erase(indexList{i}, pathRoot);
            end
        end
        
        function explodedSubpathRow = explodeSubpath(subPath)
            explodedSubpathRow = regexp(subPath,DocGen.SEP_TOKEN,'split');
        end
        
        function nodePath = recoverNodePath(fullSubpathRow,  nodePos)
            subRowUptoNode = fullSubpathRow(1, [1:nodePos]);
            nodePath = [DocGen.GLOBAL_NOTICE_SRC DocGen.SEP_TOKEN strjoin(subRowUptoNode, DocGen.SEP_TOKEN) ''];
        end
        
        function globalIndexArray = globalIndexArrMake(subpathsList)
            
            % Init Data structures %
            appendIdx = 1;
            nbSubpaths = numel(subpathsList);
            precPathRow = DocGen.explodeSubpath(subpathsList{1});
            nbNodes = numel(precPathRow);
            for i=1:nbNodes
                nodePath = DocGen.recoverNodePath(precPathRow, i);
                globalIndexArray{appendIdx} = [i, precPathRow(i), nodePath];
                appendIdx = appendIdx + 1;
            end
            
            % Global index making %
            for i=2:nbSubpaths
                currentSubpathRow = DocGen.explodeSubpath(subpathsList{i});
                nbNodes = numel(currentSubpathRow);
                
                updatePrecPat = false;
                for j=1:nbNodes
                    if j > numel(precPathRow) || ~strcmp(precPathRow(j), currentSubpathRow(j))
                        updatePrecPat = true;
                    end

                    if updatePrecPat
                        nodePath = DocGen.recoverNodePath(currentSubpathRow, j);
                        globalIndexArray{appendIdx} = [j, currentSubpathRow(j), nodePath];
                        precPathRow(j) = currentSubpathRow(j);
                        appendIdx = appendIdx + 1;
                    end
                end
            end
        end
        
        function noticeGlobalTest()
            DocGen.clearScript();
            DocGen.recoverDocs();
            indexList = DocGen.indexSelect('List.txt');
            delete('List.txt');
            subpathsList = DocGen.rootRemove(indexList, [DocGen.GLOBAL_NOTICE_SRC '\']);
            globalIndexArray = DocGen.globalIndexArrMake(subpathsList);
            
            % Debug %
%             filename = 'rootRemoveDebug.txt';
%             fid = fopen(filename,'wt');
%             nbIndexes = numel(subpathsList);
%             for i=1:nbIndexes
%                  fprintf(fid, '%s\n', subpathsList{i});
%             end
%             fclose(fid);

            % Debug %
            filename = 'globalIndexArrMakeDebug.txt';
            fid = fopen(filename,'wt');
            celldisp(globalIndexArray);
            %fprintf(fid, '%s', globalIndexArray(:));
%             nbNodes = numel(globalIndexArray);
%             for i=1:nbNodes
%                 for j=1:numel( globalIndexArray{i})
%                     fprintf(fid, 'Depth: %s ', globalIndexArray(j, i));
%                     fprintf(fid, 'Node: %s ', globalIndexArray(j, i));
%                     fprintf(fid, 'Path: %s\n', globalIndexArray(j, i));
%                     fprintf(fid, '\n\n');
%                 end
%             end
            fclose(fid);
        end
        
        function notice(path, eval)
            DocGen.clearScript();
            cd(path);
            
            % ---------- On récupère le nom du dossier ---------- %
            htap = flip(path);
            moN = strtok(htap,DocGen.SEP_TOKEN);
            Nom = flip(moN);
            
            % ---------- On récupère les noms des scripts du dossier ---------- %
            FileInfos = dir(path);
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
            publishOptions.outputDir=[path DocGen.SEP_TOKEN DocGen.DOC_NAME];
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
        
        function noticeGlobale()
            DocGen.clearScript();
            
            addpath(genpath(DocGen.GLOBAL_NOTICE_DEST))
            cd(DocGen.GLOBAL_NOTICE_DEST)
            
            % ----------------- Récupération des données ---------------- %
            [~,~]=dos(DocGen.RECOVER_HTML_CMD);
            % toto = input("stop:");
            LISTE=importdata('List.txt');
            
            h=0;
            for i=1:numel(LISTE)
                A{i,1}=strfind(LISTE{i,1},'Index');
                if ~isempty(A{i,1})
                    h=h+1;
                    ListeIndex{h,1}=LISTE{i,1};
                    
                    ListFlip = flip(ListeIndex{h,1});
                    moN = strtok(ListFlip,DocGen.SEP_TOKEN);
                    Nom{h,1} = flip(moN);
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
            for i=1:numel(ListeIndex)
                % Création de l'index (cf. Markup) par une bullet list 
                % (% *) et hyperliens (< ... >):
                ListeFormat{i,1} = ['% * <' ListeIndex{i} ' '  Nom{i}(1:end-5) '>']; % (1:end-5) pour enlever le .html
                fprintf(fid,'%s\n',ListeFormat{i});
            end
            fclose(fid);
            
            % Publication:
            publish(filename,publishOptions);
            
            % --------- Nettoyage des fichiers devenus inutiles --------- %
            delete List.txt;
            delete IndexGlobal.m;
        end
    end
    
    methods (Static, Access = private)
        function clearScript()
            % Début du script:
            clear variables
            close all
            clc
        end
    end
end