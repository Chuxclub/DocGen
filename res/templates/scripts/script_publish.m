% script publish
clear variables
clc
close all

publishOptions.format='html';
%publishOptions.format='pdf';
publishOptions.outputDir='/home/crex/matlab/MATLAB_LIB_Marien_Couvertier/Fonctions/Filtres/Notice';
publishOptions.evalCode = false;

% publish('filtre_butterworth_bas.m',publishOptions)
% publish('filtre_butterworth_haut.m',publishOptions)

publish('IndexFiltrage.m',publishOptions);