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
    
    EmoTree = struct();
    
    % ****** CASE 1: ALL EXAMPLES ARE CLASSIFIED TO THE EMO LABEL *******
    if sum(EmoBinaryTarget) == length(EmoBinaryTarget)
       EmoTree = struct('class', 1);
    elseif sum(EmoBinaryTarget) == length(EmoBinaryTarget)
       EmoTree = struct('class', 0);
    % ***** END CASE 1: ALL EXAMPLES ARE CLASSIFIED TO THE EMO LABEL ****
    
    
    %*************** CASE 2: TREE IS EMPTY => MUST BE LEAF **************
    elseif isempty(originalAUs)
            EmoTree.class = majorityValue(EmoBinaryTarget);
    %*************** END CASE 2: TREE IS EMPTY => MUST BE LEAF **********
   
    
    %*************** CASE 3: INTERNAL NODE (NOT LEAF) *******************
    %choosing best attribute based on info gain     
    else
        %calculate entropy for current level/current function call
        entropyEmoBinaryTarget = CalcEntropy(EmoBinaryTarget);
        AUsIGs = zeros (length(originalAUs),1);
        
        for j = 1:length(originalAUs) % traverses columns
            currentAU = originalTree(1:length(originalTree), j);
            AUsIGs(j) = CalcInfoGain(entropyEmoBinaryTarget, EmoBinaryTarget, currentAU);
        end
        
        result = chooseBestDecisionAttribute(AUsIGs, originalAUs);
        EmoTree.op = result.bestAU;
        bestAU = result.AUcolumn;
        originalAUs = result.originalAUs;
        originalTree(result.index, :) = [];
        
        % create subtrees (split)
        leftMatrix = [];
        rightMatrix = []; 
        leftEmoBinaryTarget = [];
        rightEmoBinaryTarget = [];
        
        % create right subtree
        for z =1:length(bestAU)
            if (bestAU(z) == 1)
                rightMatrix = [rightMatrix; originalTree(z,:)];  % check syntax
                rightEmoBinaryTarget = [rightEmoBinaryTarget; EmoBinaryTarget(z, 1)];
            end
        end
        
        % create left subtree
        for w =1:length(bestAU)
        	if (bestAU(w) == 0)
            	leftMatrix = [leftMatrix; originalTree(w,:)]; % check syntax
                leftEmoBinaryTarget = [leftEmoBinaryTarget; EmoBinaryTarget(w, 1)];
            end
        end

        RightEmoTree = struct();
        if (isempty(rightMatrix))
            RightEmoTree.class = majorityValue(EmoBinaryTarget);
        else
            RightEmoTree = CreateEmoTree(rightEmoBinaryTarget, rightMatrix, originalAUs); % right side recursion
        end
        EmoTree.kids(2) = RightEmoTree;
        
        LeftEmoTree = struct();
        if (isempty(leftMatrix))
            LeftEmoTree.class = majorityValue(EmoBinaryTarget);
        else
            LeftEmoTree = CreateEmoTree(leftEmoBinaryTarget, leftMatrix, originalAUs); % left side recursion
        end
        EmoTree.kids(1) = LeftEmoTree;
        
    end
    %*************** END CASE 3: INTERNAL NODE (NOT LEAF) *******************
end
            
