function [GNCout] = ConnectS1(GNCin)
% GNC = ConnectS1(GNC)
% Generates all possible architectures with combinations of
% interconnections between sensor 1 and computers
global INTERCONNECTIONS


j = 1;
for i = 1:length(GNCin)
    nc = GNCin(i).NC;
    if nc == 1
        for int = 1:1
            GNCout(j)           = GNCin(i);
            GNCout(j).Inat      = zeros(GNCout(j).NS,1);
            GNCout(j).Ibin      = zeros(GNCout(j).NS,GNCout(j).NC);
            GNCout(j).Inat(1,:) = INTERCONNECTIONS(int);
            tmp                 = dec2bin(GNCout(j).Inat(1,:),1);
            GNCout(j).Ibin(1,:) = tmp;
            %GNCout(j)           = setfield(GNCout(j),'Ibin',{1},char(tmp));
            j = j + 1;
        end

    elseif nc == 2
       
        for int = 1:3
            GNCout(j)           = GNCin(i);
            GNCout(j).Inat      = zeros(GNCout(j).NS,1);
            GNCout(j).Ibin      = zeros(GNCout(j).NS,GNCout(j).NC);
            GNCout(j).Inat(1,:) = INTERCONNECTIONS(int);
            GNCout(j).Ibin(1,:) = dec2bin(GNCout(j).Inat(1,:),2);
            % Check Completeness
            if GNCin(i).NS==1 % Last sensor
                if GNCout(j).Inat(1) == 3
                    j = j+1;
                else % I=1 or 2
                    j = j+0; % This architecture is not valid because not all the computers are connected.
                end
            else
                j = j + 1;
            end
            
        end
    elseif nc == 3       
        for int = 1:7
            GNCout(j)    = GNCin(i);
            GNCout(j).Inat      = zeros(GNCout(j).NS,1);
            GNCout(j).Ibin      = zeros(GNCout(j).NS,GNCout(j).NC);
            GNCout(j).Inat(1,:) = INTERCONNECTIONS(int);
            GNCout(j).Ibin(1,:) = dec2bin(GNCout(j).Inat(1,:),3);
             % Check Completeness
            if GNCin(i).NS==1 % Last sensor
                if GNCout(j).Inat(1) == 7
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