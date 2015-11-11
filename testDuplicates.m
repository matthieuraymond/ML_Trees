function [ res ] = testDuplicates( x , targets )
    res = false;
    for (i = 1:length(x) - 1)
       row = x(i,:);
       for (j = i + 1 :length(x))
           if (x(j,:) == row) & (targets(i) ~= targets(j))
               res = true;
               i
               j
           end
       end
    end
end

