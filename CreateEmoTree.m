function [EmoTree] = CreateEmoTree(originalTree, originalAUs, EmoBinaryTarget)  
    load('cleandata_students.mat');
    
    %OP is AU index
    %KIDS is an array of 1 row and two columns corresponding to the child nodes
    %CLASS is either 0 or 1 (value of leaf)
    
   % treeL = struct('class', 0);
    %treeR = struct('class', 1);
    %treeL.kids = cell(0);
    %treeR.kids = cell(0);
    %leaf = struct('class', 0);
    %leaf.kids = cell(0);
   
    EmoTree = struct('op', 'node', 'kids', [], 'class', []);
    EmoTree.kids = cell(1,2);
    
  
    
   
    % ***** CASE 1: ALL EXAMPLES ARE CLASSIFIED TO THE EMO LABEL *****
    if sum(EmoBinaryTarget) == length(EmoBinaryTarget)
        EmoTree.class = '1';
        % Shouldn't we creat a case where all examples are negative???
        
    % *** END CASE 1: ALL EXAMPLES ARE CLASSIFIED TO THE EMO LABEL ***
    
    %*************** CASE 2: TREE IS EMPTY => MUST BE LEAF **************
    else if isempty(originalAUs)
            EmoTree.class = majorityValue(EmoBinaryTarget);
    %*************** END CASE 2: TREE IS EMPTY => MUST BE LEAF **********
   
    
    %*************** CASE 3: INTERNAL NODE (NOT LEAF) *******************
    %choosing best attribute based on info gain     
    else
        %calculate entropy for current level/current function call
        entropyEmoBinaryTarget = CalcEntropy(EmoBinaryTarget);
        
        for j = 1:length(originalAUs) % traverses columns
            currentAU = originalTree(1:length(originalTree), j);
            AUsIGs = zeros (length(originalAUs),1);
            AUsIGs(j) = CalcInfoGain(entropyEmoBinaryTarget, currentAU);
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

            if (isempty(rightMatrix))
                EmoTree.class = majorityValue(EmoBinaryTarget);
            else
                rightSubEmoTree = CreateEmoTree(rightEmoBinaryTarget, rightMatrix, originalAUs); % right side recursion
            end
            
            if (isempty(leftMatrix))
                EmoTree.class = majorityValue(EmoBinaryTarget);
            else
                leftSubEmoTree = CreateEmoTree(leftEmoBinaryTarget, leftMatrix, originalAUs); % left side recursion
            end
       
            EmoTree.kids{0} = leftSubEmoTree;
            EmoTree.kids{1} = rightSubEmoTree;
        end
    end
    %*************** END CASE 3: INTERNAL NODE (NOT LEAF) *******************
end
            
