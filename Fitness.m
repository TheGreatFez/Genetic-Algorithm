function [ fitness ] = Fitness( Child_Genes, Genes_Total, Fitness_Checks )
%User defined fitness calculation to determine the performance of each set
%of genes

fitness = 0;

for i = 1:Genes_Total
    
    fitness = fitness + abs(Fitness_Checks(i) - Child_Genes(i));

end

