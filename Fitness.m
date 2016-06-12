function [ fitness ] = Fitness( DeltaVLeft, ecc_check )
%User defined fitness calculation to determine the performance of each set
%of genes

fitness = 0;
OrbitAchieved = 0;

if DeltaVLeft >= 0
    OrbitAchieved = 1;
end

Weight_ecc = 100;
Weight_DeltaV = 1;
    
fitness = OrbitAchieved*((Weight_ecc*(1-ecc_check))^2 + (Weight_DeltaV*DeltaVLeft)^2)/1000;