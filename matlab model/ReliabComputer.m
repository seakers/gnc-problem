function Rc = ReliabComputer(NC,C1,C2,C3,REL_COMP)
% ReliabComputer.m
%
% Rc = ReliabComputer(NC,C1,C2,C3,REL_COMP)
%   %NC - integer, number of computers
%   %Ci - Integer {1,2,3} type of computer
% This function returns the computers' reliability vector Rs necessary to call
% the CalcReliability function

% Parameter: array of computers' reliabilities depending on the type
% REL_COMP = double([0.9990 0.9996 0.9998]);
C1 = str2num(C1);
C2 = str2num(C2);
C3 = str2num(C3);

if NC == 1
    % One sensor
    Rc = [REL_COMP(C1)];
elseif NC == 2
    % Two sensors
    Rc = [REL_COMP(C1) REL_COMP(C2)];
elseif NC == 3
    % Three sensors
    Rc = [REL_COMP(C1) REL_COMP(C2) REL_COMP(C3)];
else % error
    disp(['ReliabComputer: Error: NS > 3, NC = ', NC]);
    return;
end
Rc = Rc';
return



