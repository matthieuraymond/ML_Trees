function [ res ] = predictRandom( T, AU)
    %PREDICT predicts which class a row a AU belongs to, based on 6 trees
    %given in order
    % in T.

    classification = zeros(6, 1); %value, depth

    for i = 1:6
       classification(i) = goThroughTreeDepth(T(i), AU); 
    end

    m = classification(1);
    possible = [1];
    
    for i = 2:6
       if classification(i,1) > m
            m = classification(i);
            possible = [i];
       elseif classification(i,1) == m
            m = classification(i);
            possible = [possible, i];
       end
    end
    
    res = possible(randi([1 length(possible)],1,1));
end
