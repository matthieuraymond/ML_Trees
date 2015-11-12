function [ res ] = predictPopulation( T, AU)
    %PREDICT predicts which class a row a AU belongs to, based on 6 trees
    %given in order
    % in T.

    classification = zeros(6, 2); %value, depth

    for i = 1:6
       [classification(i,1), classification(i,2)] = goThroughTreePopulated(T(i), AU); 
    end

    % First attempt : taking the maximum
    % Snd: the max farthest from the root
    
    clashBetween0 = sum(classification(:,1)) == 0;
    

    m = classification(1,1);
    if clashBetween0
        d = classification(1,2)/(T(1).nbExamples - T(1).nbOnes);
    else
        d = classification(1,2)/T(1).nbOnes;
    end
    res = 1;
    
    for i = 2:6
       if classification(i,1) > m
            m = classification(i,1);
            if clashBetween0
                d = classification(1,2)/(T(i).nbExamples - T(i).nbOnes);
            else
                d = classification(1,2)/T(i).nbOnes;
            end
            res = i;
       elseif classification(i,1) == m
           if clashBetween0 %take the less populated
               di = classification(i,2)/(T(i).nbExamples - T(i).nbOnes);
               if  di < d
                    m = classification(i,1);
                    d = di;
                    res = i;
               end
           else
               di = classification(i,2)/T(i).nbOnes;
               if di > d
                    m = classification(i,1);
                    d = di;
                    res = i;
               end
           end
       end
    end

end

