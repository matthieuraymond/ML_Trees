clear;

load('T.mat');
load('noisydata_students.mat');

n = length(y);

nbErrors = 0;

for i = 1:n
    p = predict(T,x(i,:));
    if p ~= y(i)
      nbErrors = nbErrors + 1; 
    end
end

100*nbErrors/n