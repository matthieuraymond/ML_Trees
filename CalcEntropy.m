function e = CalcEntropy(vector)
    pos = sum(vector);
    neg = length(vector)-pos;
    
    posProportion = pos /(pos+neg);
    negProportion = neg /(pos+neg);

    e = - posProportion*log2(posProportion) - negProportion * log2(negProportion);
end