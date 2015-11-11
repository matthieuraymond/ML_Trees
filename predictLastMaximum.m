function [ res ] = predictLastMaximum( T, AU)
    %PREDICT predicts which class a row a AU belongs to, based on 6 trees
    %given in order
    % in T.

    classification = zeros(6, 2); %value, depth

    for i = 1:6
       [classification(i,1), classification(i,2)] = goThroughTreeDepth(T(i), AU); 
    end

    % First attempt : taking the maximum
    % Snd: the max farest from the root

    m = classification(1,1);
    %%

    res = 1;
    
    for i = 2:6
       if classification(i,1) > m
            m = classification(i,1);
            res = i;
       elseif classification(i,1) == m
                m = classification(i,1);
                res = i;
       end
    end
end