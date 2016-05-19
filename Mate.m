function [ Child ] = Mate( Mom, Dad, Bit_Size, Genes_Total, Gene_Range, Array_Size, Mutation_Rate )
%MATE Summary of this function goes here
%   Detailed explanation goes here
Child = zeros(1,Array_Size);
for i = 1:Genes_Total
    Mom_Gene = round((Mom(i)/Gene_Range)*(2^Bit_Size - 1));
    Dad_Gene = round((Dad(i)/Gene_Range)*(2^Bit_Size - 1));
    Mate_Bits = 0;
    Mutate_Bits = 0;
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
        % Random Mutation based on 10% chance
        if (rand <= Mutation_Rate/100)
            if bitget(Child_Gene,j) == 0
                Child_Gene = bitset(Child_Gene,j,1);
            else
                Child_Gene = bitset(Child_Gene,j,0);
            end                
            
            Mutate_Bits = bitset(Mutate_Bits,j,1);
            
        end
        
        Child(1,i) = (Child_Gene/(2^Bit_Size - 1))*Gene_Range;
    end

end

