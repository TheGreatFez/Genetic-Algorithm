
%% Initialization
clc;
clear;
PlanetSelect;
% Population Parameters
Generation_Limit = 250;
Pop_Size = 50;
Bit_Size = 32;
Children_Size = 10;
% Chance that a bit will mutate and overall size of mutation
Mutation_Rate = 10/100;
Mutation_Size = 10/100;
Max_Bit = 2^Bit_Size-1;

Std_Dev = zeros(Generation_Limit+1,1);
Best_Fit_Data = zeros(Generation_Limit+1,1);
Mom_Fit_Data = zeros(Generation_Limit+1,1);
%% New Organization

% Gene Definitions
% Starting Throttle
Genes(1).base = Min_Throttle;
Genes(1).range = Max_Throttle - Min_Throttle;
% Pitch  Over Altitude (m)
Genes(2).base = 10;
Genes(2).range = 10000;
% Pitch Over Angle (degrees)
Genes(3).base = 0;
Genes(3).range = 90;
% Pitch Second Stage Ignition Delay (m)
Genes(4).base = 0.1;
Genes(4).range = 350;
% Pitch Switching from Surface Prograde to Orbit Prograde
Genes(5).base = 0;
Genes(5).range = 0.99;

population.fitness = zeros(Pop_Size,1);
population.genes = zeros(Pop_Size,length(Genes));
%% First Generation
fprintf('Initialization\n');

for i = 1:Pop_Size
    fitness_check = 0;    
    for j = 1:length(Genes)
        population.genes(i,j) = Genes(j).base + rand*Genes(j).range;
    end
    
    gen = i;
    DeltaVLeft = 0;
    ecc_check = 0;
    sim_runner = population.genes(i,:);
    RunSim;
    fitness_check = Fitness(DeltaVLeft, ecc_check, Ra_check, TargetOrbit);
    
    fprintf('  Candidate %i Finished\n',i);
    population.fitness(i) = fitness_check;
end
Std_Dev(1) = std(population.fitness(:));
fprintf('  Standard Deviation = %f\n',Std_Dev(1));
Generations = 0;
Worst_Fit = min(population.fitness(:));
Best_Fit = max(population.fitness(:));

Best_Fit_Data(1) = Best_Fit;

%%
for i = 1:Generation_Limit
    %Mutation_Rate = max((10-10*(Generations/Generation_Limit)),1)/100;
    %Mutation_Size = max((10-10*(Generations/Generation_Limit)),1)/100;
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
        
    Parent1 = population.genes(Parent1_index,:);
    Parent2 = population.genes(Parent2_index,:);
    
    % End New Method


    for j = 1:Children_Size
        
        fitness_check = 0;
        Child.genes = zeros(length(Genes),1);
        Child.fitness = 0;

        Child = Mate(Parent1,Parent2,Bit_Size, Genes, Mutation_Rate, Mutation_Size );
        
        DeltaVLeft = 0;
        ecc_check = 0;
        sim_runner = Child.genes;
        RunSim;
        fitness_check = Fitness(DeltaVLeft, ecc_check, Ra_check, TargetOrbit);

        fprintf('  Child %i Finished\n',j);
        Child.fitness = fitness_check;
      
      % New Method
      
        if fitness_check > Worst_Fit
            index = find(Worst_Fit == population.fitness,1,'first');
            population.genes(index,:) = Child.genes;
            population.fitness(index) = Child.fitness;
            Worst_Fit = min(population.fitness);

            fprintf(['  Replaced ' num2str(index) ' Candidate with ' num2str(j) ...
              'Child\n']);
        end
      
      % End New Method    

    end
    Std_Dev(i+1) = std(population.fitness);
    Best_Fit = max(population.fitness);
    index_best = find(max(population.fitness) == population.fitness,1,'first');
    Best.genes = population.genes(index_best);
    
    Best_Fit_Data(i+1) = Best_Fit;
    fprintf('  Standard Deviation = %f\n',Std_Dev(i+1));
end
%%
close all
plotting_x =[1:1:(Generation_Limit+1)]';
%Average = mean(population(:,1:3));
figure(1)

plot(plotting_x,Best_Fit_Data)

axis([0 Generation_Limit+1 Best_Fit_Data(1) max(Best_Fit_Data)])

figure(2)
plot(plotting_x,Std_Dev)