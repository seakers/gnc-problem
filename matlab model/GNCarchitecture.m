% GNC systems architecture generation and evaluation
global NSMAX NCMAX SENSORS COMPUTERS INTERCONNECTIONS M_SENS M_COMP R_SA R_SB R_SC R_CA R_CB R_CC R_I

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CONSTANTS
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
NSMAX = 3;
NCMAX = 3;

%M_SA = 3;
M_S0 = 6;
%M_SC = 9;
%M_CA = 3;
M_C0 = 5;
%M_CC = 10;

%R_SA = double(0.9985);
R_S0 = double(0.9990);
%R_SC = double(0.9995);
%R_CA = double(0.9990);
R_C0 = double(0.9996);
%R_CC = double(0.9998);

R_I = 1;

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% INITIALIZE STRUCTURE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

GNC.NS                          = [];
GNC.NC                          = [];
GNC.sensors                     = [];
GNC.computers                   = [];
GNC.Ibin                        = [];
GNC.Inat                        = [];
GNC.m                           = 0;
GNC.R                           = double(0.0);
GNC.nlinks                      = 0;
GNC.SensorMassScalingFactor     = 1;
GNC.SensorMassSpacingFactor     = 0.5;
GNC.SensorReliabScalingFactor   = 1;
GNC.CompMassScalingFactor       = 1;
GNC.CompMassSpacingFactor       = 0.5;
GNC.CompReliabScalingFactor     = 1;

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calculate mass and reliability of each type of sensor
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
k1 = GNC.SensorMassScalingFactor;
r1 = GNC.SensorMassSpacingFactor;
alfa1 = GNC.SensorReliabScalingFactor;

M_SA = k1*(1-r1)*M_S0;
M_SB = k1*M_S0;
M_SC = k1*(1+r1)*M_S0;

kr1 = k1/alfa1;
R_SA = 1 - (1-R_S0)/(10^(kr1*(1-r1)-1));
R_SB = 1 - (1-R_S0)/(10^(kr1-1));
R_SC = 1 - (1-R_S0)/(10^(kr1*(1+r1)-1));

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calculate mass and reliability of each type of computer
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
k2 = GNC.CompMassScalingFactor;
r2 = GNC.CompMassSpacingFactor;
alfa2 = GNC.CompReliabScalingFactor;

M_CA = k2*(1-r2)*M_C0;
M_CB = k2*M_C0;
M_CC = k2*(1+r2)*M_C0;

kr2 = k2/alfa2;
R_CA = 1 - (1-R_C0)/(10^(kr2*(1-r2)-1));
R_CB = 1 - (1-R_C0)/(10^(kr2-1));
R_CC = 1 - (1-R_C0)/(10^(kr2*(1+r2)-1));

SENSORS =   ['100';'200';'300';'110';'120';'130';'220';'230';'330';'111';'112';'113';'122';'123';'133';'222';'223';'233';'333'];
M_SENS =    [M_SA;M_SB;M_SC;2*M_SA;M_SA+M_SB;M_SA+M_SC;2*M_SB;M_SB+M_SC;2*M_SC;3*M_SA;2*M_SA+M_SB;2*M_SA+M_SC;M_SA+2*M_SB;M_SA+M_SB+M_SC;M_SA+2*M_SC;3*M_SB;2*M_SB+M_SC;M_SB+2*M_SC;3*M_SC];
COMPUTERS = ['100';'200';'300';'110';'120';'130';'220';'230';'330';'111';'112';'113';'122';'123';'133';'222';'223';'233';'333'];
M_COMP =    [M_CA;M_CB;M_CC;2*M_CA;M_CA+M_CB;M_CA+M_CC;2*M_CB;M_CB+M_CC;2*M_CC;3*M_CA;2*M_CA+M_CB;2*M_CA+M_CC;M_CA+2*M_CB;M_CA+M_CB+M_CC;M_CA+2*M_CC;3*M_CB;2*M_CB+M_CC;M_CB+2*M_CC;3*M_CC];
INTERCONNECTIONS = [1:7]';

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ENUMERATE ARCHITECTURES
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Choose Nsensors
GNCout = ChooseNS(GNC);
GNC2 = GNCout;
% Choose Ncomputers
GNCout = ChooseNC(GNC2);
GNC3 = GNCout;
% Choose type of sensors
GNCout = ChooseSensors(GNC3);
GNC4 = GNCout;
% Choose type of computers
GNCout = ChooseComputers(GNC4);
GNC5 = GNCout;
% Interconnect sensors and computers
GNCout = ConnectS1(GNC5);
GNC6 = GNCout;
GNCout = ConnectS2(GNC6);
GNC7 = GNCout;
GNCout = ConnectS3(GNC7);
GNC8 = GNCout;

% Save enumeration results in a file

results2CSV(GNC8);

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% EVALUATE ARCHITECTURES
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%file_path = 'C:\Users\Dani\Documents\PhD\research\tasks\projects\GNC system architecture\OPN model\';
file_path = 'C:\Users\Dani\Documents\PhD\research\tasks\projects\GNC system architecture\matlab model\';
%name = 'GNC_2types2.csv';
name = 'results.csv';
filename = [file_path name];


[architectures] = EvaluateGNC(filename);

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CREATE OUTPUT FILE WITH RESULTS
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PLOT PARETO FRONT
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

plot (R,m,'+');
axis([0.9975 1.000005 0 35]);
title ('Reliability vs Mass for all possible architectures');
xlabel('Reliability');
ylabel('Mass');
%front = paretofront([R m]);
