function index = chooseBestDecisionAttribute(originalTree, originalAUs, EmoBinaryTarget)

    %calculate the entropy for binary target vector 
    BinaryTargetEntropy = CalcEntropy(EmoBinaryTarget);

    %to store information gain for all attributes (AUs) to compare them later
    width = length(originalAUs);
    height = length(EmoBinaryTarget);
    AUsIGs = zeros(width,1);
    
    for j = 1:width % traverses columns
        currentAU = originalTree(:, j);
        numberOnes = sum(currentAU);
        numberZeros = height - numberOnes;
        oneTarget = [];
        zeroTarget = [];
        for k = 1:height;
            if (currentAU(k) == 1)
                oneTarget = [oneTarget ; EmoBinaryTarget(k)];
            else
                zeroTarget = [zeroTarget ; EmoBinaryTarget(k)];
            end
        end
        AUsIGs(j) = BinaryTargetEntropy - (numberOnes/height)*CalcEntropy(oneTarget) - (numberZeros/height)*CalcEntropy(zeroTarget);
    end

    bestAU = AUsIGs(1);
    index = 1;

    for i = 2:length(AUsIGs)
        if AUsIGs(i) > bestAU
            bestAU = AUsIGs(i);
            index = i;    
        end
    end 
end