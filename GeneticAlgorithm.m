
%% Initialization
clc;
clear;
PlanetSelect;
% Final answer we are looking for
Generation_Limit = 100;
Pop_Size = 50;
Bit_Size = 32;
Children_Size = 10;
% Chance that a bit will mutate and overall size of mutation
Mutation_Rate = 10/100;
Mutation_Size = 10/100;
% Population indexes
Max_Bit = 2^Bit_Size-1;
Genes_Total = 5;
% Gene minimal values and range of values
Gene_Range = zeros(Genes_Total,2);
Gene_Range = [Min_Throttle,Max_Throttle-Min_Throttle;
              100,2400;
              0,30;              
              30,350;
              0,.75];
% Setting up the children array
fitness = Genes_Total + 1;
Array_Size = fitness;
population = zeros(Pop_Size,Array_Size);
children = zeros(Children_Size,Array_Size);
Std_Dev = zeros(Generation_Limit+1,1);
Best_Fit_Data = zeros(Generation_Limit+1,1);
Mom_Fit_Data = zeros(Generation_Limit+1,1);

%% First Generation
fprintf('Initialization\n');

for i = 1:Pop_Size
    fitness_check = 0;
    while fitness_check == 0
        for j = 1:Genes_Total
            population(i,j) = Gene_Range(j,1) + rand*Gene_Range(j,2);
        end
        gen = i;
        DeltaVLeft = 0;
        ecc_check = 0;
        sim_runner = population(i,:);
        RunSim;
        fitness_check = Fitness(DeltaVLeft, ecc_check, Ra_check, TargetOrbit);
    end
    fprintf('  Candidate %i Finished\n',i);
    population(i,fitness) = fitness_check;
end
Std_Dev(1) = std(population(:,fitness));
fprintf('  Standard Deviation = %f\n',Std_Dev(1));
Generations = 0;
Worst_Fit = min(population(:,fitness));
Best_Fit = max(population(:,fitness));

Best_Fit_Data(1) = Best_Fit;

%%
for i = 1:Generation_Limit
    Mutation_Rate = max((10-10*(Generations/Generation_Limit)),1)/100;
    Mutation_Size = max((10-10*(Generations/Generation_Limit)),1)/100;
    Generations = Generations + 1;

    fprintf('Generation %i\n',i);
    %population = children;
    % New Method
    Parent1_index = 0;
    Parent2_index = 0;
    
    while Parent1_index == Parent2_index
        
        Parent1_index = randi([1,Pop_Size]);
        Parent2_index = randi([1,Pop_Size]);
        
    end
        
    Parent1 = population(Parent1_index,:);
    Parent2 = population(Parent2_index,:);
    
    % End New Method


    for j = 1:Children_Size
      fitness_check = 0;
      while fitness_check == 0  
        Child = Mate(Parent1,Parent2,Bit_Size,Genes_Total,Gene_Range,Array_Size,Mutation_Rate,Mutation_Size);
        children(j,:) = Child;
        gen = j;
        DeltaVLeft = 0;
        ecc_check = 0;
        sim_runner = Child;
        RunSim;
        fitness_check = Fitness(DeltaVLeft, ecc_check, Ra_check, TargetOrbit);
      end
      fprintf('  Child %i Finished\n',j);
      children(j,fitness) = fitness_check;
      
      % New Method
      
      if fitness_check > Worst_Fit
          index = find(Worst_Fit == population(:,fitness),1,'first');
          population(index,:) = children(j,:);
          Worst_Fit = min(population(:,fitness));
          
          fprintf(['  Replaced ' num2str(index) ' Candidate with ' num2str(j) ...
              'Child\n']);
      end
      
      % End New Method    

    end
    Std_Dev(i+1) = std(population(:,fitness));
    Best_Fit = max(population(:,fitness));
    Best_Fit_Data(i+1) = Best_Fit;
    fprintf('  Standard Deviation = %f\n',Std_Dev(i+1));
end
%%
close all
plotting_x =[1:1:(Generation_Limit+1)]';
Average = mean(population(:,1:3));
figure(1)

plot(plotting_x,Best_Fit_Data)

axis([0 Generation_Limit+1 Best_Fit_Data(1) max(Best_Fit_Data)])

figure(2)
plot(plotting_x,Std_Dev)