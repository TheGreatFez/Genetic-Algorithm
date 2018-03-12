function [ Child ] = Mate( Mom, Dad, Bit_Size, Genes, Mutation_Rate, Mutation_Size )
%MATE Summary of this function goes here
%   Detailed explanation goes here

for i = 1:length(Genes)
    Mom_Gene = round(((Mom(i)-Genes(i).base)/Genes(i).range)*(2^Bit_Size - 1));
    Dad_Gene = round(((Dad(i)-Genes(i).base)/Genes(i).range)*(2^Bit_Size - 1));
    Mate_Bits = 0;
    Child_Gene = 0;
    
    for j = 1:Bit_Size
        % Choose the parents genes
        if rand >= .5;
            % Mom passes the trait
            Mate_Bits = bitset(Mate_Bits,j,1);
            Child_Gene = bitset(Child_Gene,j,bitget(Mom_Gene,j));
        else
            % Dad passes the trait
            Mate_Bits = bitset(Mate_Bits,j,0);
            Child_Gene = bitset(Child_Gene,j,bitget(Dad_Gene,j));
        end        
        
    end
    
    Child.genes(i,1) = (Child_Gene/(2^Bit_Size - 1))*Genes(i).range + Genes(i).base;
    
    % Random Mutation based on Mutation_Rate % chance
    sign = 0;
    if (rand <= Mutation_Rate)
       if rand <= .5
           sign = -1;
       else
           sign = 1;
       end
       
       Child.genes(i,1) = min(max(Child.genes(i,1) + sign*rand*(Mutation_Size)*Genes(i).range,Genes(i).base),Genes(i).base + Genes(i).range);
            
    end

end

