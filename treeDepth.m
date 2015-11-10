function [ n ] = treeDepth( tree )
    if isempty(tree.kids)
        n = 0;
        return
    end
    
    a = treeDepth(tree.kids{1});
    b = treeDepth(tree.kids{2});
    
    if a > b
        n = a + 1;
    else
        n = b + 1;
    end

end

