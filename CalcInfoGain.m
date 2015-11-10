function ig = CalcInfoGain(entropyEmoBinaryTarget, currentAU)
    ones = countPos(currentAU);
    zeros = length(currentAU)-pos;

    ig = entropyEmoBinaryTarget - (ones/length(currentAU))*AUOnesEntropy(entropyEmoBinaryTarget, currentAU) - (zeros/length(currentAU))*AUZerosEntropy(entropyEmoBinaryTarget, currentAU);
end