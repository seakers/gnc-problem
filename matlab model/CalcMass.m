function [m,nlinks] = CalcMass(NS,NC,S1,S2,S3,C1,C2,C3,I1,I2,I3,MASS_SEN, MASS_COM, MASS_INT, DCP)
% CalcMass.m
%
% Computes the total mass of the system as the sum of the masses of the
% components

% MASS_SEN = [3 6 9];
% MASS_COM = [3 5 10];
% MASS_INT = 0;
S1 = str2num(S1);
S2 = str2num(S2);
S3 = str2num(S3);
C1 = str2num(C1);
C2 = str2num(C2);
C3 = str2num(C3);
m = 0;
boolean_DCP = 0;
% Mass of the sensors
if NS == 1
    % One sensor
    m = m + MASS_SEN(S1);
elseif NS == 2
    % Two sensors
    m = m + MASS_SEN(S1) + MASS_SEN(S2);
    if S1 ~= S2
        boolean_DCP = 1;
    end
elseif NS == 3
    % Three sensors
    m = m + MASS_SEN(S1) + MASS_SEN(S2) + MASS_SEN(S3);
    if ~(S1 == S2 && S2 == S3)
        boolean_DCP = 1;
    end
else % error
    disp(['ReliabInterc: Error: NS > 3, NS = ', NS]);
    return;
end

% Mass of the computers
if NC == 1
% One computer
    m = m + MASS_COM(C1);
elseif NC == 2
    % Two computers
    m = m + MASS_COM(C1) + MASS_COM(C2);
    if C1 ~= C2
        boolean_DCP = 1;
    end
elseif NC == 3
    % Three computers
    m = m + MASS_COM(C1) + MASS_COM(C2) + MASS_COM(C3);
    if ~(C1 == C2 && C2 == C3)
        boolean_DCP = 1;
    end
else % error
    disp(['ReliabInterc: Error: NC > 3, NC = ', NC]);
    return;
end

% Mass of the interconnections
nlinks = CountLinks(NS,I1,I2,I3);
m = m + nlinks*MASS_INT;

% Dissimilar Component Penalty

if boolean_DCP == 1
    m = m + DCP;
end

return