clear;

load('cleandata_students.mat');

x = x(101:end,:);
y = y(101:end);

T(1) = CreateEmoTree(x, [1:45]', calBinTarget(y, 1));
T(2) = CreateEmoTree(x, [1:45]', calBinTarget(y, 2));
T(3) = CreateEmoTree(x, [1:45]', calBinTarget(y, 3));
T(4) = CreateEmoTree(x, [1:45]', calBinTarget(y, 4));
T(5) = CreateEmoTree(x, [1:45]', calBinTarget(y, 5));
T(6) = CreateEmoTree(x, [1:45]', calBinTarget(y, 6));

clear('x','y');
load('cleandata_students.mat');

p = zeros(100,1);
nbErrors = 0;

for i = 1 : 100
   p(i) = predict(T, x(i,:));
   if p(i) ~= y(i)
      nbErrors = nbErrors + 1; 
   end
end