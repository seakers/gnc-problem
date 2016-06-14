%% get_gnc_designs.m
designs = gncs;
for i = 1:length(gncs)
    designs(i).S1 = gncs(i).sensors(1);
    designs(i).S2 = gncs(i).sensors(2); 
    designs(i).S3 = gncs(i).sensors(3);
    
    designs(i).C1 = gncs(i).computers(1);
    designs(i).C2 = gncs(i).computers(2); 
    designs(i).C3 = gncs(i).computers(3);
end
