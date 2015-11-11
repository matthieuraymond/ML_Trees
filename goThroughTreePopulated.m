function [ res, depth ] = goThroughTreePopulated( tree, AU )
%GOTHROUGHTREE takes a row of AU values and process it through a tree
%Returns the class and it population
    if (isempty(tree.kids))
       res = tree.class;
       depth = tree.op;
       return
    end
    
    if (AU(tree.op) == 0)
        [res depth] = goThroughTreePopulated(tree.kids{1}, AU);
    else
        [res depth] = goThroughTreePopulated(tree.kids{2}, AU);
    end
end
