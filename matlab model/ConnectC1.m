function [GNCout] = ConnectC1(GNCin)
% GNC = ConnectS1(GNC)
% Generates all possible architectures with combinations of
% interconnections between computer 1 and actuators
global INTERCONNECTIONS


j = 1;
for i = 1:length(GNCin)
    na = GNCin(i).NA;
    if na == 1
        for int = 1:1
            GNCout(j)           = GNCin(i);
            GNCout(j).Inat2      = zeros(GNCout(j).NC,1);
            GNCout(j).Ibin2      = zeros(GNCout(j).NC,GNCout(j).NA);
            GNCout(j).Inat2(1,:) = INTERCONNECTIONS(int);
            tmp                 = dec2bin(GNCout(j).Inat2(1,:),1);
            GNCout(j).Ibin2(1,:) = tmp;
            %GNCout(j)           = setfield(GNCout(j),'Ibin',{1},char(tmp));
            j = j + 1;
        end

    elseif na == 2
       
        for int = 1:3
            GNCout(j)           = GNCin(i);
            GNCout(j).Inat2      = zeros(GNCout(j).NC,1);
            GNCout(j).Ibin2      = zeros(GNCout(j).NC,GNCout(j).NA);
            GNCout(j).Inat2(1,:) = INTERCONNECTIONS(int);
            GNCout(j).Ibin2(1,:) = dec2bin(GNCout(j).Inat2(1,:),2);
            % Check Completeness
            if GNCin(i).NC==1 % Last computer
                if GNCout(j).Inat2(1) == 3
                    j = j+1;
                else % I=1 or 2
                    j = j+0; % This architecture is not valid because not all the computers are connected.
                end
            else
                j = j + 1;
            end
            
        end
    elseif na == 3       
        for int = 1:7
            GNCout(j)    = GNCin(i);
            GNCout(j).Inat2      = zeros(GNCout(j).NC,1);
            GNCout(j).Ibin2      = zeros(GNCout(j).NC,GNCout(j).NA);
            GNCout(j).Inat2(1,:) = INTERCONNECTIONS(int);
            GNCout(j).Ibin2(1,:) = dec2bin(GNCout(j).Inat2(1,:),3);
             % Check Completeness
            if GNCin(i).NC==1 % Last sensor
                if GNCout(j).Inat2(1) == 7
                    j = j+1;
                else % I=1..6
                    j = j+0; % This architecture is not valid because not all the computers are connected.
                end
            else
                j = j + 1;
            end
            
        end
    else %error
    end
 
end
return;