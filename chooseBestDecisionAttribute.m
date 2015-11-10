function result = ChooseBestDecisionAttribute(AUsIGs, originalAUs)
    bestAU = AUsIGs(1);
    index = 1;
    
    for i = 2:length(AUsIGs)
        if AUsIGs(i) > bestAU
            index = i;
            bestAU = AUsIGs(i);
        end
    end
    
    result = index;
end