function [duplic] = duplicate(GNCin)
% Returns a boolean duplic = 1 if the architecture is invalid because
% duplicate
duplic  = 0;
ns      = GNCin.NS;
nc      = GNCin.NC;
sen     = GNCin.sensors;
com     = GNCin.computers;
ibin    = GNCin.Ibin;
inat    = GNCin.Inat;

indS = size(ibin,1);
if indS == 2
    if sen(2) == sen(1)
        if(inat(2) > inat(1))
            duplic = 1;
            return;
        end
    end
elseif indS == 3
    if sen(2) == sen(1)
        if(inat(2) > inat(1))
            duplic = 1;
            return;
        end
    end
    if sen(3) == sen(2)
        if(inat(3) > inat(2))
            duplic = 1;
            return;
        end
    end
    
end
        
return