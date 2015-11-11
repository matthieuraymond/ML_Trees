function [ res ] = predictMostPopulated( T, AU)
    %PREDICT predicts which class a row a AU belongs to, based on 6 trees
    %given in order
    % in T.

    classification = zeros(6, 2); %value, depth

    for i = 1:6
       [classification(i,1), classification(i,2)] = goThroughTreePopulated(T(i), AU); 
    end

    % First attempt : taking the maximum
    % Snd: the max populated

    m = classification(1,1);
    d = classification(1,2);
    res = 1;
    
    for i = 2:6
       if classification(i,1) > m
            m = classification(i,1);
            d = classification(i,2);
            res = i;
       elseif classification(i,1) == m
           if classification(i,2) > d
                m = classification(i,1);
                d = classification(i,2);
                res = i;
           end
       end
    end
end

