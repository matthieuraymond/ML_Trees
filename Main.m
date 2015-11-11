clear;
load('cleandata_students.mat');

AngerTree = CreateEmoTree(x, [1:45]', calBinTarget(y, 1));

DisgustTree = CreateEmoTree(x, [1:45]', calBinTarget(y, 2));

FearTree = CreateEmoTree(x, [1:45]', calBinTarget(y, 3));

HappinessTree = CreateEmoTree(x, [1:45]', calBinTarget(y, 4));

SadnessTree = CreateEmoTree(x, [1:45]', calBinTarget(y, 5));

SurpriseTree = CreateEmoTree(x, [1:45]', calBinTarget(y, 6));

DrawDecisionTree(AngerTree, 'Anger');
%DrawDecisionTree(DisgustTree, 'Disgust');
%DrawDecisionTree(FearTree, 'Fear');
%DrawDecisionTree(HappinessTree, 'Happiness');
%DrawDecisionTree(SadnessTree, 'Sadness');
%DrawDecisionTree(SurpriseTree, 'Surprise');

clear('x');
clear('y');
%save('trees.mat');