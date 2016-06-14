function Rs = ReliabSensor(NS,S1,S2,S3,REL_SENS)
% ReliabSensor.m
%
% Rs = ReliabSensor(NS,S1,S2,S3,REL_SENS)
%   %NS - integer, number of sensors
%   %Si - Integer {1,2,3} type of sensor
% This function returns the sensors' reliability vector Rs necessary to call
% the CalcReliability function

% Parameter: array of sensors' reliabilities depending on the type
% REL_SENS = double([0.9985 0.9990 0.9995]);
S1 = str2num(S1);
S2 = str2num(S2);
S3 = str2num(S3);

if NS == 1
    % One sensor
    Rs = [(REL_SENS(S1))];
elseif NS == 2
    % Two sensors
    Rs = [REL_SENS(S1) REL_SENS(S2)];
elseif NS == 3
    % Three sensors
    Rs = [REL_SENS(S1) REL_SENS(S2) REL_SENS(S3)];
else % error
    disp(['ReliabSensor: Error: NS > 3, NS = ', NS]);
    return;
end
Rs = Rs';
return



