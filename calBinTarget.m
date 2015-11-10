function [binary] = calBinTarget(label)
    load('cleandata_students.mat');
    binary = zeros(length(x), 1);
    for i = 1:length(y)
        if y(i) == label
            binary(i) = 1;
        end
    end
end
        
  
