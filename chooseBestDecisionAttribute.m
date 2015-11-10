function result = ChooseBestDecisionAttribute(AUsIGs, originalAUs)
    bestAU = AUsIGs(1);
    for i = 2:length(AUsIGs)
        if AUsIGs(i) > bestAU
            bestAU = originalAUs(i);
            AUcolumn = originalAUs(i, :);
            originalAUs(i, :) = [];
            index = i;
        end
    end
    result = struct('bestAU', bestAU, 'originalAUs', originalAUs, 'AUcolumn', AUcolumn, 'index', index);
end