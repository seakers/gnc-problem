function [I,rI] = ReliabInterc(NS,NC,I1,I2,I3,REL_INT)
% ReliabInterc.m
%
% [I,rI] = ReliabInterc(NS,NC,I1,I2,I3);
%   %NS,NC - integer, number of sensors, computers
%   %Ii - Integer {1,2,3,4,5,6,7} type of interconnection
% This function returns the interconnections' reliability matrix rI necessary to call
% the CalcReliability function (plus the connections vector I).

% Parameter: interconnections' reliability (assumed constant and identical
% for all interconnections
% REL_INT = double(1.0000000);
I = zeros(NS);
rI = double(0.00*ones(NS,NC));

if NS == 1
    % One sensor
    I = I1;
    if NC == 1
    % One computer
        rI = double(REL_INT*I);
    elseif NC == 2
        % Two computers
        rI = double(REL_INT*[contc1(I1) contc2(I1)]);        
    elseif NC == 3
        % Three computers
        rI = double(REL_INT*[contc1(I1) contc2(I1) contc3(I1)]);
    else % error
        disp(['ReliabInterc: Error: NC > 3, NC = ', NC]);
        return;
    end
elseif NS == 2
    % Two sensors
    I = [I1;I2];
    if NC == 1
    % One computer
        rI = double(REL_INT*[contc1(I1);contc1(I2)]);
    elseif NC == 2
        % Two computers
        rI = double(REL_INT*[contc1(I1) contc2(I1);contc1(I2) contc2(I2)]);        
    elseif NC == 3
        % Three computers
        rI = double(REL_INT*[contc1(I1) contc2(I1) contc3(I1);contc1(I2) contc2(I2) contc3(I2)]);
    else % error
        disp(['ReliabInterc: Error: NC > 3, NC = ', NC]);
        return;
    end
elseif NS == 3
    % Three sensors
    I = [I1;I2;I3];
    if NC == 1
    % One computer
        rI = double(REL_INT*[contc1(I1);contc1(I2);contc1(I3)]);
    elseif NC == 2
        % Two computers
        rI = double(REL_INT*[contc1(I1) contc2(I1);contc1(I2) contc2(I2);contc1(I3) contc2(I3)]);        
    elseif NC == 3
        % Three computers
        rI = double(REL_INT*[contc1(I1) contc2(I1) contc3(I1);contc1(I2) contc2(I2) contc3(I2);contc1(I3) contc2(I3) contc3(I3)]);
    else % error
        disp(['ReliabInterc: Error: NC > 3, NC = ', NC]);
        return;
    end
else % error
    disp(['ReliabInterc: Error: NS > 3, NC = ', NC]);
    return;
end
    
return
% end of ReliabInterc.m


