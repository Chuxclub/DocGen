% ======================================================================= %
% ============== SCRIPT DE G�N�RATION DE LA NOTICE GLOBALE ============== %
% ======================================================================= %

%                    -------------------------                            %
% Auteurs: Marien Couvertier (script original), Florian Legendre (m�j)

% Objectif: Script pour g�n�rer une page globale r�f�ren�ant toutes les 
% documentations g�n�r�es du projet
%                    -------------------------                            %


% D�but du script:
clear variables
close all
clc

% SI LINUX:
GLOBAL_NOTICE_PATH = '/home/crex/projects/MatLab_Template/docs';
% SI WINDOWS:
%GLOBAL_NOTICE_PATH = 'C:\Users\flori\projects\MatLab_Template\docs';

addpath(genpath(GLOBAL_NOTICE_PATH))
cd(GLOBAL_NOTICE_PATH)


% ================== R�CUP�RATION DES DONN�ES =================== %
% SI LINUX:
[~,~]=dos('find ../codes | grep .html > List.txt');
% SI WINDOWS:
% [~,~]=dos('dir /s /b ..\codes\**\*.html > List.txt');

LISTE=importdata('List.txt');

h=0;
for i=1:numel(LISTE)
A{i,1}=strfind(LISTE{i,1},'Index');
    if ~isempty(A{i,1})
        h=h+1;
        ListeIndex{h,1}=LISTE{i,1};
        
        ListFlip = flip(ListeIndex{h,1});
        
        % SI LINUX => '/':
        moN = strtok(ListFlip,'/');
        % SI WINDOWS:
        %moN = strtok(ListFlip,'\'); 
        
        Nom{h,1} = flip(moN);
    end
end


% ========================= PUBLICATION ========================= %
% ---------- On pr�pare les options de publication ---------- %  
publishOptions.format = 'html';
publishOptions.outputDir = GLOBAL_NOTICE_PATH;
publishOptions.evalCode = false;


% ---------- On cr�e le script (.m) de l'index global qui sera publi� ---------- % 
filename = ('IndexGlobal.m'); 
fid = fopen(filename,'wt');

% ---------- On pr�pare le contenu de l'index global (son .m) ---------- % 
fprintf(fid,'%s\n\n','%% Index Global');
fprintf(fid,'%s\n\n','%% Purpose');
fprintf(fid,'%s\n','% Index global de toute la documentation des fonctions contenues dans les diff�rents dossiers');
fprintf(fid,'%s\n\n','%% Main Index');
fprintf(fid,'%s\n','%%');

%  ---------- On publie l'index global ---------- %
% Pr�allocation:
for i=1:numel(ListeIndex)
   ListeFormat{i,1} = ['% * <' ListeIndex{i} ' '  ListeIndex{i}(1:end-5) '>']; % (1:end-5) pour enlever le .html 
   fprintf(fid,'%s\n',ListeFormat{i});
end
fclose(fid);

% Publication:
publish(filename,publishOptions);


% =============== NETTOYAGE DES FICHIERS INUTILES =============== %
delete List.txt;
delete IndexGlobal.m;