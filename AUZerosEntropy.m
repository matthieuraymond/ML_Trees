function e = AUZerosEntropy(EmoBinaryTarget, currentAU)
    sumZeros = 0;
    sumNeg = 0;
    sumPos = 0;
  
    for i =1:length(currentAU)
        if currentAU(i) == 0
        sumZeros = sumZeros+1;
            if EmoBinaryTarget(i) == 1
                sumPos = sumPos+1;           
            else
                sumNeg = sumNeg+1;
            end
        end
     end

    posProportion = sumPos/sumZeros;
    negProportion = sumNeg/sumZeros;

    e = - posProportion*log2(posProportion) - negProportion*log2(negProportion);
end