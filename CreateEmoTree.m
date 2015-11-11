function [EmoTree] = CreateEmoTree(originalTree, originalAUs, EmoBinaryTarget)  
    %load('cleandata_students.mat');
    
    %OP is AU index
    %KIDS is an array of 1 row and two columns corresponding to the child nodes
    %CLASS is either 0 or 1 (value of leaf)
    
    %treeL = struct('class', 0);
    %treeR = struct('class', 1);
    %treeL.kids = cell(0);
    %treeR.kids = cell(0);
    %leaf = struct('class', 0);
    %leaf.kids = cell(0);
    
    %clean useless action units
    z = 1;
    height = length(EmoBinaryTarget);
    if height > 1
        while (z <= length(originalAUs))
            s = sum(originalTree);
            if (s == height | s == 0)
                originalAUs(z) = []; %deleteing the AU from indexes
                originalTree(:, z) = []; %deleting the AU from data
            else
                z = z + 1;
            end
        end
    end
    
    EmoTree = struct();
    
    % ****** CASE 1: ALL EXAMPLES ARE CLASSIFIED TO THE EMO LABEL *******
    if sum(EmoBinaryTarget) == length(EmoBinaryTarget)
       EmoTree.class = 100;
       EmoTree.kids = [];
       EmoTree.op = -1;
    elseif sum(EmoBinaryTarget) == 0
       EmoTree.class = 0;
       EmoTree.kids = [];
       EmoTree.op = -1;
    % ***** END CASE 1: ALL EXAMPLES ARE CLASSIFIED TO THE EMO LABEL ****
    
    
    %*************** CASE 2: TREE IS EMPTY => MUST BE LEAF **************
    elseif isempty(originalAUs)
       EmoTree.class = majorityValue(EmoBinaryTarget);
       EmoTree.kids = [];
       EmoTree.op = -1;
    %*************** END CASE 2: TREE IS EMPTY => MUST BE LEAF **********
   
    
    %*************** CASE 3: INTERNAL NODE (NOT LEAF) *******************
    %choosing best attribute based on info gain     
    else        
        %calculate best decision attribute   
        bestAUIndex = chooseBestDecisionAttribute(originalTree, originalAUs, EmoBinaryTarget);
        EmoTree.op = originalAUs(bestAUIndex);
        AUcolumn = originalTree(:, bestAUIndex);
        %delete datas for the recursion
        originalAUs(bestAUIndex) = []; %deleteing the AU from indexes
        originalTree(:, bestAUIndex) = []; %deleting the AU from data
        
        if (EmoTree.op == 2)
            'stop';
        end
        
        % create subtrees (split)
        leftMatrix = [];
        rightMatrix = [];
        leftEmoBinaryTarget = [];
        rightEmoBinaryTarget = [];
        
        % create left and right subtree
        for z =1:length(AUcolumn)
            if (AUcolumn(z) == 1)
                rightMatrix = [rightMatrix ; originalTree(z,:)];  % check syntax
                rightEmoBinaryTarget = [rightEmoBinaryTarget ; EmoBinaryTarget(z)];
            else
                leftMatrix = [leftMatrix ; originalTree(z,:)];  % check syntax
                leftEmoBinaryTarget = [leftEmoBinaryTarget ; EmoBinaryTarget(z)];
            end
        end
        
        LeftEmoTree = struct();
        if (isempty(leftMatrix))
            LeftEmoTree.class = majorityValue(EmoBinaryTarget);
            LeftEmoTree.kids = [];
            LeftEmoTree.op = -1;
        else
            LeftEmoTree = CreateEmoTree(leftMatrix, originalAUs, leftEmoBinaryTarget); % left side recursion
        end
        
        RightEmoTree = struct();
        if (isempty(rightMatrix))
            RightEmoTree.class = majorityValue(EmoBinaryTarget);
            RightEmoTree.kids = [];
            RightEmoTree.op = -1;
        else
            RightEmoTree = CreateEmoTree(rightMatrix, originalAUs, rightEmoBinaryTarget); % right side recursion
        end
        
        EmoTree.kids = {LeftEmoTree, RightEmoTree};
        
    end
    %*************** END CASE 3: INTERNAL NODE (NOT LEAF) *******************
end
            
