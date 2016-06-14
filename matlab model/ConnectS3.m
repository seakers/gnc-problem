function [GNCout] = ConnectS3(GNCin)
% GNC = ConnectS3(GNC)
% Generates all possible architectures with combinations of
% interconnections between sensor 3 and computers
global INTERCONNECTIONS

stop = 0;
j = 1;
for i = 1:length(GNCin)
    nc = GNCin(i).NC;
    vec_interconnect    = interconn(GNCin(i).computers,nc); 
    if GNCin(i).NS > 2
        if nc == 1
            for int = 1:1
                GNCout(j)    = GNCin(i);
                GNCout(j).Inat(3,:) = INTERCONNECTIONS(int);
                GNCout(j).Ibin(3,:) = dec2bin(GNCout(j).Inat(3,:),1);
                j = j + 1;
            end

        elseif nc == 2
            for int = 1:length(vec_interconnect)
                GNCout(j)    = GNCin(i);
                GNCout(j).Inat(3,:) = vec_interconnect(int);
                GNCout(j).Ibin(3,:) = dec2bin(GNCout(j).Inat(3,:),2);
                % Check Completeness
                if GNCin(i).NS==3 % Last sensor
                    I12 = GNCout(j).Ibin(1,1);
                    I11 = GNCout(j).Ibin(1,2);

                    
                    I22 = GNCout(j).Ibin(2,1);
                    I21 = GNCout(j).Ibin(2,2);
                       

                    I32 = GNCout(j).Ibin(3,1);
                    I31 = GNCout(j).Ibin(3,2);
                    
                    if (I12+I22+I32 - 3*48 > 0) && (I11+I21+I31 - 3*48 > 0) && ~duplicate(GNCout(j))
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
                GNCout(j).Inat(3,:) = vec_interconnect(int);
                GNCout(j).Ibin(3,:) = char(dec2bin(GNCout(j).Inat(3,:),3));
                 % Check Completeness
                if GNCin(i).NS==3 % Last sensor, always true for ConnectS3
                    
                    I13 = GNCout(j).Ibin(1,1);
                    I12 = GNCout(j).Ibin(1,2);
                    I11 = GNCout(j).Ibin(1,3);
                    
                    I23 = GNCout(j).Ibin(2,1);
                    I22 = GNCout(j).Ibin(2,2);
                    I21 = GNCout(j).Ibin(2,3);                        

                    I33 = GNCout(j).Ibin(3,1);
                    I32 = GNCout(j).Ibin(3,2);
                    I31 = GNCout(j).Ibin(3,3);
                    
                    
                    if (I13+I23+I33 - 3*48 > 0) &&(I12+I22+I32 - 3*48 > 0) && (I11+I21+I31 - 3*48 > 0) && ~duplicate(GNCout(j))
                        j = j+1;
                    else
%                         if CountLinks(GNCin(i).NS,GNCout(j).Inat(1),GNCout(j).Inat(2),GNCout(j).Inat(3)) == 3
%                             stop = stop + 1;
%                         end
                        
                        j = j+0; % This architecture is not valid because not all the computers are connected.
                    end
                else
                    j = j + 1;
                end

            end
        else %error
        end
    else % if NS==2
        GNCout(j)    = GNCin(i);
        j = j+1;
    end
end
% fprintf('stops = %d',stop);
return;