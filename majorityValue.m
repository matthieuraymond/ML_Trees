function mode = majorityValue(vector)
    ones = sum(vector);
    zeros = length(vector) - ones;
    
    if ones > zeros
        mode = 1;
    else
        mode = 0;
    end
end