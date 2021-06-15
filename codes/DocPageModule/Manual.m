% ======================================================================= %
% ========================= LA TOOLBOX DOCGEN =========================== %
% ======================================================================= %

%                    -------------------------                            %
% Auteurs: Marien Couvertier (script original), Florian Legendre (m�j)    %
%                                                                         %
% Objectif: Fournir des fonctions globales utilis�es dans DocGenScript.m  %
% pour mettre à jour la documentation d'un projet.                       %
%                                                                         %
% IMPORTANT: Modifiez les variables globales dans "properties" ci-dessous %
%            selon votre syst�me                                          %
%                                                                         %
% IMPORTANT 2: Si vous �tes sous Linux, allez dans PathsTB.m pour         %
%              configurer le caract�re de s�paration des fichiers appel�  %
%              SEP_TOKEN.                                                 %
%                                                                         %
%                    -------------------------                            %



classdef (Abstract) Manual
    
    properties (Constant, Access = private)
        DOC_NAME = 'Notice';
    end   
    
    % ################ GESTION DES NOTICES ################ %
    methods(Static)

        % ================ Cr�er une notice locale ================ %
        function makeLocalManual(fid, path, publishOptions)
            % ---------- On r�cup�re les noms des scripts du dossier ---------- %
            FileInfos = FilesTB.getFiles(path, '*.m', "");
            k=0;
            for i=1:length(FileInfos)
                if FileInfos(i).isdir==0 %pour g�rer les sous dossiers pr�sents
                    k=k+1;
                    ListF{k,1}=FileInfos(i).name;
                end
            end
            
            % ---------- On publie les fichiers ---------- %
            % Pr�allocation:
            nbFichiers = numel(ListF);
            
            % Publication:
            for i=1:nbFichiers
                publish(ListF{i}, publishOptions);
            end
            
            indexA = IndexA('*.html', 10, path, './');
            indexA.makeIndexA(fid);
        end
        
        
        % ================ Cr�er une notice globale ================ %
        function makeGlobalManual(fid, src, dest, isIndexExhaustive)
            % ----------------- R�cup�ration des données ---------------- %
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
            
            % ---------- On pr�pare le contenu de l'index global (son .m) ---------- %
            fprintf(fid,'%s\n\n','%% Index Global');
            fprintf(fid,'%s\n\n','%% Purpose');
            fprintf(fid,'%s\n','% Index global de toute la documentation des fonctions contenues dans les diff�rents dossiers');
            fprintf(fid,'%s\n\n','%% Main Index');
            fprintf(fid,'%s\n','%%');
            
            %  ---------- On cr�e l'index global ---------- %
            % Pr�allocation:
            indexT = IndexT('*.html', 10, src, dest);
            indexT.makeIndexT(fid, isIndexExhaustive);
            
            % --------- Nettoyage des fichiers devenus inutiles --------- %
            delete List.txt;
        end
    end
end