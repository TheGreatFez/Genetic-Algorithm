% Final answer we are looking for
Fitness_Checks = [500;
                  250;
                  750;
                  100];
Target = 0;

Generation_Limit = 1000;
Pop_Size = 100;
Bit_Size = 32;
% Chance that a bit will mutate and overall size of mutation
Mutation_Rate = 2/100;
Mutation_Size = 1/100;
% Population indexes
Max_Bit = 2^Bit_Size-1;
Genes_Total = 4;
% Gene minimal values and range of values
Gene_Range = zeros(Genes_Total,2);
Gene_Range = [0,1000;
              0,1000;
              0,1000;
              0,1000];
% Setting up the children array
fitness = Genes_Total + 1;
Array_Size = fitness;
population = zeros(Pop_Size,Array_Size);
children = zeros(Pop_Size,Array_Size);
% Start the initial population
for i = 1:Pop_Size
    for j = 1:Genes_Total
        children(i,j) = Gene_Range(j,1) + round(rand*Gene_Range(j,2));
    end
    children(i,fitness) = Fitness(children(i,1:Genes_Total),Genes_Total,Fitness_Checks);
end

Generations = 0;

for i = 1:Generation_Limit
  Generations = Generations + 1;
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
              Best = population(check,:);
          end
          
          if (Dad_Fit == population(check,fitness))
              
              Dad = population(check,:);
          end
          
          
      end
      
  end
  % End condition for the generation
  if Mom_Fit <= Target
      break
  end
  
  for j = 1:Pop_Size
  
      Child = Mate(Mom,Dad,Bit_Size,Genes_Total,Gene_Range,Array_Size,Mutation_Rate,Mutation_Size);
      children(j,:) = Child;
      children(j,fitness) = Fitness(children(j,1:Genes_Total),Genes_Total,Fitness_Checks);
      
  end
  
end

Average = mean(population(:,1:3));