function [ res ] = goThroughTree( tree, AU )
%GOTHROUGHTREE takes a row of AU values and process it through a tree
    if (isempty(tree.kids))
       res = tree.class;
       return
    end
    
    if (AU(tree.op) == 0)
        res = goThroughTree(tree.kids{1}, AU);
    else
        res = goThroughTree(tree.kids{2}, AU);
    end
end

