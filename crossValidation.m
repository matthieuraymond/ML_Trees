clear;

load('cleandata_students.mat');
%load('noisydata_students.mat');

originalX = x;
originalY = y;

n = length(y);

errSum = 0;

for k = 1:9
    starting = floor(k * n / 10);
    ending = floor((k+1) * n / 10);
    testSet = x(starting:ending,:);
    testRes = y(starting:ending);
    x(starting:ending,:) = [];
    y(starting:ending,:) = [];
    
    T(1) = CreateEmoTree(x, [1:45]', calBinTarget(y, 1));
    T(2) = CreateEmoTree(x, [1:45]', calBinTarget(y, 2));
    T(3) = CreateEmoTree(x, [1:45]', calBinTarget(y, 3));
    T(4) = CreateEmoTree(x, [1:45]', calBinTarget(y, 4));
    T(5) = CreateEmoTree(x, [1:45]', calBinTarget(y, 5));
    T(6) = CreateEmoTree(x, [1:45]', calBinTarget(y, 6));
    
    nbError = 0;
    
    for i = 1 : (1 + ending - starting)
        predicted = predict(T, testSet(i,:));
        if (predicted ~= testRes(i))
           nbError = nbError + 1; 
        end
    end
    
    avg = nbError/(1 + ending - starting);
    
    errSum = errSum + avg;
    
    x = originalX;
    y = originalY;
end

100*errSum/9