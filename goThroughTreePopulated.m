function [ res, pop ] = goThroughTreePopulated( tree, AU )
%GOTHROUGHTREE takes a row of AU values and process it through a tree
%Returns the class and the depth
    if (isempty(tree.kids))
       res = tree.class;
       pop = tree.nbExamples;
       return
    end
    
    if (AU(tree.op) == 0)
        [res, pop] = goThroughTreePopulated(tree.kids{1}, AU);
    else
        [res, pop] = goThroughTreePopulated(tree.kids{2}, AU);
    end
end
