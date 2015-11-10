function e = AUOnesEntropy(EmoBinaryTarget, currentAU)
    sumOnes = 0;
    sumNeg = 0;
    sumPos = 0;
  
    for i =1:length(currentAU)
        if currentAU(i) == 1
        sumOnes = sumOnes+1;
            if EmoBinaryTarget(i) == 1
                sumPos = sumPos+1;           
            else
                sumNeg = sumNeg+1;
            end
        end
     end

    posProportion = sumPos/sumOnes;
    negProportion = sumNeg/sumOnes;

    e = - posProportion*log2(posProportion) - negProportion*log2(negProportion);
end