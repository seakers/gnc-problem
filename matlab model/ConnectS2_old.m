function [GNCout] = ConnectS2_old(GNCin)
% GNC = ConnectS1(GNC)
% Generates all possible architectures with combinations of
% interconnections between sensor 1 and computers
global INTERCONNECTIONS


j = 1;
for i = 1:length(GNCin)
    nc = GNCin(i).NC;
    vec_interconnect    = interconn(GNCin(i).computers,nc); 
    if GNCin(i).NS > 1
        if GNCin(i).NC == 1
            for int = 1:1
                GNCout(j)    = GNCin(i);
                GNCout(j).Inat(2,:) = INTERCONNECTIONS(int);
                GNCout(j).Ibin(2,:) = dec2bin(GNCout(j).Inat(2,:),1);
                j = j + 1;
            end

        elseif nc == 2
            for int = 1:length(vec_interconnect)
                GNCout(j)    = GNCin(i);
                GNCout(j).Inat(2,:) = vec_interconnect(int);
                GNCout(j).Ibin(2,:) = char(dec2bin(GNCout(j).Inat(2,:),2));
                % Check Completeness
                if GNCin(i).NS==2 % Last sensor
                    I12 = GNCout(j).Ibin(1,1);
                    I11 = GNCout(j).Ibin(1,2);
                                        
                    I22 = GNCout(j).Ibin(2,1);
                    I21 = GNCout(j).Ibin(2,2);
                        
                    
                    if (I12+I22 - 2*48 > 0) && (I11+I21 - 2*48 > 0) && ~duplicate(GNCout(j))
                        j = j+1;
                    else % I=1 or 2
                        j = j+0; % This architecture is not valid because not all the computers are connected.
                    end
                else
                    j = j + 1;
                end

            end
        elseif nc == 3
            for int = 1:length(vec_interconnect)
                GNCout(j)    = GNCin(i);
                GNCout(j).Inat(2,:) = vec_interconnect(int);
                GNCout(j).Ibin(2,:) = char(dec2bin(GNCout(j).Inat(2,:),3));
                 % Check Completeness
                if GNCin(i).NS==2 % Last sensor
                    I13 = GNCout(j).Ibin(1,1);
                    I12 = GNCout(j).Ibin(1,2);
                    I11 = GNCout(j).Ibin(1,3);
                    
                    I23 = GNCout(j).Ibin(2,1);
                    I22 = GNCout(j).Ibin(2,2);
                    I21 = GNCout(j).Ibin(2,3);                        
                    
                    if (I13+I23 - 2*48 > 0) &&(I12+I22 - 2*48 > 0) && (I11+I21 - 2*48 > 0) && ~duplicate(GNCout(j))
                        j = j+1;
                    else
                        j = j+0; % This architecture is not valid because not all the computers are connected.
                    end
                else
                    j = j + 1;
                end

            end
        else %error
        end
    else % if NS==1 then out=in. 
        GNCout(j)    = GNCin(i);
        j = j+1;
    end
    
end
return;