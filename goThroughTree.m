function [ res, pop ] = goThroughTree( tree, AU )
%GOTHROUGHTREE takes a row of AU values and process it through a tree
%Returns the class and the depth
    if (isempty(tree.kids))
       res = tree.class;
       pop = tree.op;
       return
    end
    
    if (AU(tree.op) == 0)
        [res, pop] = goThroughTree(tree.kids{1}, AU);
    else
        [res, pop] = goThroughTree(tree.kids{2}, AU);
    end
end

