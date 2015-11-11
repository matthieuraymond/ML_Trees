function [ res, depth ] = goThroughTree( tree, AU )
%GOTHROUGHTREE takes a row of AU values and process it through a tree
%Returns the class and the depth
    if (isempty(tree.kids))
       res = tree.class;
       depth = 0;
       return
    end
    
    if (AU(tree.op) == 0)
        [a b] = goThroughTree(tree.kids{1}, AU);
        res = a;
        depth = b + 1;
    else
        [a b] = goThroughTree(tree.kids{2}, AU);
        res = a;
        depth = b + 1;
    end
end

