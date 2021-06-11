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



classdef (Abstract) Manual
    
    properties (Constant, Access = private)
        DOC_NAME = 'Notice';
    end   
    
    % ################ GESTION DES NOTICES ################ %
    methods(Static)

        % ================ Créer une notice locale ================ %
        function makeLocalManual(fid, path, publishOptions)
            % ---------- On récupère les noms des scripts du dossier ---------- %
            FileInfos = FilesTB.getFiles(path, '*.m', "");
            k=0;
            for i=1:length(FileInfos)
                if FileInfos(i).isdir==0 %pour gérer les sous dossiers présents
                    k=k+1;
                    ListF{k,1}=FileInfos(i).name;
                end
            end
            
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
            for i=1:nbFichiers
                publish(ListF{i},publishOptions);
            end
        end
        
        
        % ================ Créer une notice globale ================ %
        function makeGlobalManual(fid, src, dest, isIndexExhaustive)
            % ----------------- Récupération des données ---------------- %
            % SI LINUX:
            % [~,~]=dos(['find ' src ' | grep .html > List.txt']);
            % SI WINDOWS:
            [~,~]=dos(['dir /s /b ' src '\*.html > List.txt']);
            LISTE=importdata('List.txt');
            
            h=0;
            for i=1:numel(LISTE)
                A{i,1}=strfind(LISTE{i,1},'Index');
                if ~isempty(A{i,1})
                    h=h+1;
                    ListeIndex{h,1}=LISTE{i,1};
                    Nom{h,1} = PathsTB.cropToLastNode(ListeIndex{h,1});
                end
            end
            
            % ---------- On prépare le contenu de l'index global (son .m) ---------- %
            fprintf(fid,'%s\n\n','%% Index Global');
            fprintf(fid,'%s\n\n','%% Purpose');
            fprintf(fid,'%s\n','% Index global de toute la documentation des fonctions contenues dans les différents dossiers');
            fprintf(fid,'%s\n\n','%% Main Index');
            fprintf(fid,'%s\n','%%');
            
            %  ---------- On crée l'index global ---------- %
            % Préallocation:
            indexT = IndexT('*.html', 10, src, dest);
            indexT.makeIndexGlobal(fid, isIndexExhaustive);
            
            % --------- Nettoyage des fichiers devenus inutiles --------- %
            delete List.txt;
        end
    end
end