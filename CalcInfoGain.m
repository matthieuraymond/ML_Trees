function ig = CalcInfoGain(entropyEmoBinaryTarget, EmoBinaryTarget, currentAU)
    ones = sum(currentAU);
    zeros = length(currentAU)-ones;

    ig = entropyEmoBinaryTarget - (ones/length(currentAU))*AUOnesEntropy(EmoBinaryTarget, currentAU) - (zeros/length(currentAU))*AUZerosEntropy(EmoBinaryTarget, currentAU);
end