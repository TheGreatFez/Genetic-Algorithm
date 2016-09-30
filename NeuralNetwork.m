InputsSize = 6;
OutputsSize = 4;
HiddenLayers = 7;
HiddenNodes = 5;
WeightsSize = 1+HiddenLayers;
MaxSize = max(InputsSize,max(OutputsSize,HiddenNodes));

Weights = -1*ones(MaxSize,MaxSize,WeightsSize);
% Generate the weights
for layer=1:WeightsSize
    if layer == 1
        Nodes1 = InputsSize;
    else
        Nodes1 = HiddenNodes;
    end
    
    if layer == WeightsSize
        Nodes2 = OutputsSize;
    else
        Nodes2 = HiddenNodes;
    end
    
    for NodeIndex1 =1:Nodes1
        for NodeIndex2 =1:Nodes2
            Weights(NodeIndex1,NodeIndex2,layer) = 2*rand()-1;
        end
    end
end

Input = 2*ones(InputsSize,1);
PrevNodes = 0;
Nodes = zeros(MaxSize);
Output = 0;
Nodes_Check = zeros(MaxSize,WeightsSize);
for layer=1:WeightsSize
   if layer == 1
       PrevNodes = Input;
       Size1 = InputsSize;
       Size2 = HiddenNodes;
       for Node = 1:Size1
           Nodes_Check(Node,layer) = PrevNodes(Node,1);
       end
   elseif layer == WeightsSize
       Size1 = HiddenNodes;
       Size2 = OutputsSize;
   else
       Size1 = HiddenNodes;
       Size2 = HiddenNodes;
   end
   Nodes = zeros(Size2,1);
   for Node2 =1:Size2
       for Node1 =1:Size1
       Nodes(Node2,1) = Nodes(Node2,1) + PrevNodes(Node1)*Weights(Node1,Node2,layer);
       end
   end
   for Node = 1:Size2
       Nodes(Node,1) = 1/(1+exp(-1*Nodes(Node,1)));
       Nodes_Check(Node,layer+1) = Nodes(Node,1);
   end
   PrevNodes = Nodes;
   if layer == WeightsSize
       Output = Nodes;
   end
end