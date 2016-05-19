% Final answer we are looking for
Answer = 7;


Generation_Limit = 3;
Pop_Size = 100;
Bit_Size = 32;
% Chance that a bit will mutate
Mutation_Rate = 1;
%0 - 100
Gene_Range = 100;
% Population indexes
Max_Bit = 2^Bit_Size-1;
Genes_Total = 1;
% gene1 = Guess for Answer
gene1 = 1; 
fitness = Genes_Total + 1;
% Last value in the population array
Array_Size = fitness;

population = zeros(Pop_Size,fitness);
% Start the initial population
for i = 1:Pop_Size
    
    population(i,gene1) = rand*Gene_Range;
    population(i,fitness) = abs(Answer - population(i,gene1));
    
end

for i = 1:Generation_Limit
    
  SortedFitness = sort(population(:,fitness));
  Mom_Fit = SortedFitness(1);
  Dad_Fit = SortedFitness(2);
  
  Mom = -1;
  Dad = -1;
  
  while ((Mom < 0) & (Dad < 0) )
      
      for j = 1:Pop_Size
          check = j;
          if (Mom_Fit == population(check,fitness))
              Mom = population(check,:);
          end
          
          if (Dad_Fit == population(check,fitness))
              
              Dad = population(check,:);
          end
          
          
      end
      
  end
  for j = 1:Pop_Size
  
      Child = Mate(Mom,Dad,Bit_Size,Genes_Total,Gene_Range,Array_Size,Mutation_Rate);
      population(j,:) = Child;
      population(j,fitness) = abs(Answer - population(j,gene1));
      
  end
  
end

Average = mean(population(:,1));