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
    lenY = length(y);
    
    bin1 = calBinTarget(y, 1);
    bin2 = calBinTarget(y, 2);
    bin3 = calBinTarget(y, 3);
    bin4 = calBinTarget(y, 4);
    bin5 = calBinTarget(y, 5);
    bin6 = calBinTarget(y, 6);
    
    T(1) = CreateEmoTree(x, [1:45]', bin1);
    T(2) = CreateEmoTree(x, [1:45]', bin2);
    T(3) = CreateEmoTree(x, [1:45]', bin3);
    T(4) = CreateEmoTree(x, [1:45]', bin4);
    T(5) = CreateEmoTree(x, [1:45]', bin5);
    T(6) = CreateEmoTree(x, [1:45]', bin6);
    S1(1) = sum(bin1);
    S1(2) = sum(bin2);
    S1(3) = sum(bin3);
    S1(4) = sum(bin4);
    S1(5) = sum(bin5);
    S1(6) = sum(bin6);
    S0(1) = lenY - S1(1);
    S0(2) = lenY - S1(2);
    S0(3) = lenY - S1(3);
    S0(4) = lenY - S1(4);
    S0(5) = lenY - S1(5);
    S0(6) = lenY - S1(6);
    nbError = 0;
    
    for i = 1 : (1 + ending - starting)
        %predicted = predictRandom(T, testSet(i,:));
        %predicted = predictDepth(T, testSet(i,:));
        predicted = predictPopulation(T, testSet(i,:), S0, S1);
        
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