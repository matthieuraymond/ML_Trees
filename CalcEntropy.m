function e = CalcEntropy(vector)
    pos = sum(vector);
    neg = length(vector)-pos;
    
    if (pos * neg == 0)
        e = 0;
        return
    end
    
    posProportion = pos /(pos+neg);
    negProportion = neg /(pos+neg);

    e = - posProportion*log2(posProportion) - negProportion * log2(negProportion);
end