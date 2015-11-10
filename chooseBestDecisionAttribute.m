function result = ChooseBestDecisionAttribute(AUsIGs, originalAUs)
    bestAU = AUsIGs(1);
    for i = 2:length(AUsIGs)
        if AUsIGs(i) > bestAU
            index = originalAUs(i);
            bestAU = AUsIGs(i);
        end
    end
    
    AUcolumn = originalAUs(index, :);
    originalAUs(index, :) = [];
    
    result = struct('bestAU', bestAU, 'originalAUs', originalAUs, 'AUcolumn', AUcolumn, 'index', index);
end