function mode = majorityValue(vector)
    ones = sum(vector);
    
    mode = floor(100*ones/length(vector));
end