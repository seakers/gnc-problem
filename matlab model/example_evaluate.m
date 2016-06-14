%example_evaluate.m
file_path = 'C:\Users\Dani\Documents\PhD\research\tasks\projects\GNC system architecture\OPN model\';
name = 'GNC_2types2.csv';
filename = [file_path name];


[architectures] = EvaluateGNC(filename);


% Create Output File
Narc = length(architectures);
m = zeros(Narc,1);
R = double(zeros(Narc,1));
NS = zeros(Narc,1);
NC = zeros(Narc,1);
S1 = zeros(Narc,1);
S2 = zeros(Narc,1);
S3 = zeros(Narc,1);
C1 = zeros(Narc,1);
C2 = zeros(Narc,1);
C3 = zeros(Narc,1);
I1 = zeros(Narc,1);
I2 = zeros(Narc,1);
I3 = zeros(Narc,1);
Nlinks = zeros(Narc,1);
for j = 1 : Narc
    m(j)  = architectures(j).m;
    R(j)  = architectures(j).R;
    NS(j) = architectures(j).NS;
    NC(j) = architectures(j).NC;
    S1(j) = architectures(j).S1;
    S2(j) = architectures(j).S2;
    S3(j) = architectures(j).S3;
    C1(j) = architectures(j).C1;
    C2(j) = architectures(j).C2;
    C3(j) = architectures(j).C3;
    I1(j) = architectures(j).I1;
    I2(j) = architectures(j).I2;
    I3(j) = architectures(j).I3;
    Nlinks(j) = architectures(j).Nlinks;   
end

outfile = [file_path 'out_' name];
fid = fopen(outfile,'w');
fprintf(fid,'%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s\n','R','m','NS','NC','S1','S2','S3','C1','C2','C3','I1','I2','I3','Nlinks');
for j = 1 : Narc
    fprintf(fid,'%f,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d\n',R(j),m(j),NS(j),NC(j),S1(j),S2(j),S3(j),C1(j),C2(j),C3(j),I1(j),I2(j),I3(j),Nlinks(j));
end
fclose(fid);

% find best architecture

% plot
plot (R,m,'+');
axis([0.999975 1.000005 0 35]);
title ('Reliability vs Mass for all possible architectures');
xlabel('Reliability');
ylabel('Mass');


