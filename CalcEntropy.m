function e = CalcEntropy(vector)
    pos = countPos(vector)
    neg = length(vector)-pos;
    
    posProportion = pos /(pos+neg);
    negProportion = neg /(pos+neg);

    e = - posProportion*log2(posProportion) - p(negProportion)*log2(negProportion);
end