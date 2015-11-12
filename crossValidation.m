clear;

%load('cleandata_students.mat');
load('noisydata_students.mat');

originalX = x;
originalY = y;
trainingSize = 9;
n = length(y);

errSum = 0;
confusionMatrix = zeros(6);

for k = 1:trainingSize
    starting = floor(k * n / 10);
    ending = floor((k+1) * n / 10);
    testSet = x(starting:ending,:);
    testRes = y(starting:ending);
    x(starting:ending,:) = [];
    y(starting:ending,:) = [];
    predictedSize = length(testRes);
    predictedSet=[predictedSize:1];
    
    T(1) = CreateEmoTree(x, [1:45]', calBinTarget(y, 1));
    T(2) = CreateEmoTree(x, [1:45]', calBinTarget(y, 2));
    T(3) = CreateEmoTree(x, [1:45]', calBinTarget(y, 3));
    T(4) = CreateEmoTree(x, [1:45]', calBinTarget(y, 4));
    T(5) = CreateEmoTree(x, [1:45]', calBinTarget(y, 5));
    T(6) = CreateEmoTree(x, [1:45]', calBinTarget(y, 6));
    nbError = 0;
    
    for i = 1 : (1 + ending - starting)
        %predicted = predictRandom(T, testSet(i,:));
        %predicted = predictDepth(T, testSet(i,:));
        predicted = predictPopulation(T, testSet(i,:));
        
        predictedSet(i,1) = predicted;
        if (predicted ~= testRes(i))
           nbError = nbError + 1;
        end
    end
    
    confusionMatrix = confusionMatrix + buildConfusionMatrix(testRes,predictedSet,6);
    
    avg = nbError/(1 + ending - starting);
    
    errSum = errSum + avg;
    
    x = originalX;
    y = originalY;
end

confusionMatrix = confusionMatrix / trainingSize;
meanRecall = computeMeanRecall(confusionMatrix);
meanPrecision = computeMeanPrecision(confusionMatrix);
meanF1 = CalcF(meanPrecision,meanRecall);

for i = 1: size(confusionMatrix,1)
    TP = confusionMatrix(i,i);
    FN = sum(confusionMatrix(i,:)) - TP;
    FP = sum(confusionMatrix(:,i)) - TP;
    classRecalls(i,1) = calculateRecall(TP, FN);
    classPrecisions(i,1) = calculatePrecision(TP, FP);
end

100*errSum/9