% ======================================================================= %
% =================== SCRIPT DE GÉNÉRATION DE NOTICES =================== %
% ======================================================================= %

%                    -------------------------                            %
% Auteurs: Marien Couvertier (script original), Florian Legendre (màj)

% Objectif: Script pour générer la documentation de chaque fonction se 
% trouvant dans le dossier cible (si la syntaxe des fonctions est 
% respectée!) 
%
% Ce script génère également un document maitre appelé Index Nom_du_dossier
% regroupant l'ensemble des fonctions présentes avec un lien vers leur
% documentation. 
%                    -------------------------                            % 


% Début du script:
clear variables
close all
clc


% ================== RÉCUPÉRATION DES DONNÉES =================== %
% ---------- L'utilisateur donne le chemin du dossier dont il faut générer la documentation ---------- %
path=input('Collez le chemin absolu où les fonctions à lister se trouvent: ','s');
cd(path);

% ---------- On récupère le nom du dossier ---------- % 
htap = flip(path);

% SI LINUX:
moN = strtok(htap,'/');
% SI WINDOWS:
%moN = strtok(htap,'\');

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


% ========================= PUBLICATION ========================= %
% ---------- On prépare les options de publication ---------- %
publishOptions.format='html';
mkdir Notice;

% SI LINUX:
publishOptions.outputDir=[path '/Notice']; 
% SI WINDOWS:
%publishOptions.outputDir=[path '\Notice']; 

publishOptions.evalCode = false;


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