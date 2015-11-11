function [ res ] = predict( T, AU)
    %PREDICT predicts which class a row a AU belongs to, based on 6 trees
    %given in order
    % in T.

    classification = zeros(6, 1);

    for i = 1:6
       classification(i) = goThroughTree(T(i), AU); 
    end

    % First attempt : taking the maximum

    [~, res] = max(classification);
end

