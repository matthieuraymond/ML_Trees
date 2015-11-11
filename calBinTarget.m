function [binary] = calBinTarget(y, label)
    binary = zeros(length(y), 1);
    for i = 1:length(y)
        if y(i) == label
            binary(i) = 1;
        end
    end
end
        
  
