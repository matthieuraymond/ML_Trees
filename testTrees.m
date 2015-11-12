function [ res ] = testTrees( T, x )
%testTrees output a vector of prediction for the x data matrix    
     [n, ~] = size(x);
     res = zeros(n, 1);

     for i = 1 : n
        res(i) = predictPopulation(T, x(i,:));
     end

end

