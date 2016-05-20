% Final answer we are looking for
Answer1 = 500;
Answer2 = 250;
Answer3 = 750;
Target = 10;

Generation_Limit = 100;
Pop_Size = 100;
Bit_Size = 32;
% Chance that a bit will mutate and overall size of mutation
Mutation_Rate = 1/100;
Mutation_Size = 1/100;
%0 - 100
Gene_Range = 1000;
% Population indexes
Max_Bit = 2^Bit_Size-1;
Genes_Total = 3;
% gene1 = Guess for Answer
gene1 = 1; 
gene2 = 2;
gene3 = 3;
fitness = Genes_Total + 1;
% Last value in the population array
Array_Size = fitness;

population = zeros(Pop_Size,fitness);
children = zeros(Pop_Size,fitness);
% Start the initial population
for i = 1:Pop_Size
    
    children(i,gene1) = rand*Gene_Range;
    children(i,gene2) = rand*Gene_Range;
    children(i,gene3) = rand*Gene_Range;
    
    children(i,fitness) = abs(Answer1 - children(i,gene1)) + abs(Answer2 - children(i,gene2)) + abs(Answer3 - children(i,gene3));
    
end

for i = 1:Generation_Limit
  population = children;  
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
  % End condition for the generation
  if Mom_Fit < Target
      break
  end
  
  for j = 1:Pop_Size
  
      Child = Mate(Mom,Dad,Bit_Size,Genes_Total,Gene_Range,Array_Size,Mutation_Rate,Mutation_Size);
      children(j,:) = Child;
      children(j,fitness) = abs(Answer1 - children(j,gene1)) + abs(Answer2 - children(j,gene2)) + abs(Answer3 - children(j,gene3));
      
  end
  
end

Average = mean(population(:,1:3));