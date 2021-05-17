% ======================================================================= %
% =================== SCRIPT DE G�N�RATION DE NOTICES =================== %
% ======================================================================= %

%                    -------------------------                            %
% Auteurs: Marien Couvertier (script original), Florian Legendre (m�j)

% Objectif: Script pour g�n�rer la documentation de chaque fonction se 
% trouvant dans le dossier cible (si la syntaxe des fonctions est 
% respect�e!) 
%
% Ce script g�n�re �galement un document maitre appel� Index Nom_du_dossier
% regroupant l'ensemble des fonctions pr�sentes avec un lien vers leur
% documentation. 
%                    -------------------------                            % 


% D�but du script:
clear variables
close all
clc


% ================== R�CUP�RATION DES DONN�ES =================== %
% ---------- L'utilisateur donne le chemin du dossier dont il faut g�n�rer la documentation ---------- %
path=input('Collez le chemin absolu o� les fonctions � lister se trouvent: ','s');
cd(path);

% ---------- On r�cup�re le nom du dossier ---------- % 
htap = flip(path);

% SI LINUX:
moN = strtok(htap,'/');
% SI WINDOWS:
%moN = strtok(htap,'\');

Nom = flip(moN);

% ---------- On r�cup�re les noms des scripts du dossier ---------- % 
FileInfos = dir(path); 
k=0;
for i=1:length(FileInfos)
    if FileInfos(i).isdir==0 %pour g�rer les sous dossiers pr�sents
        k=k+1;    
        ListF{k,1}=FileInfos(i).name;
    end
end


% ========================= PUBLICATION ========================= %
% ---------- On pr�pare les options de publication ---------- %
publishOptions.format='html';
mkdir Notice;

% SI LINUX:
publishOptions.outputDir=[path '/Notice']; 
% SI WINDOWS:
%publishOptions.outputDir=[path '\Notice']; 

publishOptions.evalCode = false;


% ---------- On pr�pare le contenu de l'index ---------- % 
% Header du dossier ma�tre (le nom du dossier dont on g�n�re la doc):
Header = ['%% ' Nom];
filename = ['Index' Nom '.m']; 
fid = fopen(filename,'wt');

% Titre du dossier:
fprintf(fid,'%s\n',Header);
fprintf(fid,'%s\n\n','%% Main Functions');
fprintf(fid,'%s\n','%%');

% ---------- On publie les fichiers ---------- %
% Pr�allocation:
nbFichiers = numel(ListF);
linei=cell(nbFichiers,1);
for i=1:nbFichiers
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


% =============== NETTOYAGE DES FICHIERS INUTILES =============== %
delete(filename);