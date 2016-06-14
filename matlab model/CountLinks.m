function nlinks = CountLinks(NS,I1,I2,I3)

% Count links
nlinks = 0;

if (I1 == 1 || I1 == 2 || I1 == 4)
    nlinks = nlinks + 1;
elseif (I1 == 3 || I1 == 5 || I1 == 6)
    nlinks = nlinks + 2;
elseif (I1 == 7)
    nlinks = nlinks + 3;   
end

if NS > 1
    if (I2 == 1 || I2 == 2 || I2 == 4)
        nlinks = nlinks + 1;
    elseif (I2 == 3 || I2 == 5 || I2 == 6)
        nlinks = nlinks + 2;
    elseif (I2 == 7)
        nlinks = nlinks + 3;   
    end
end

if NS > 2
    if (I3 == 1 || I3 == 2 || I3 == 4)
        nlinks = nlinks + 1;
    elseif (I3 == 3 || I3 == 5 || I3 == 6)
        nlinks = nlinks + 2;
    elseif (I3 == 7)
        nlinks = nlinks + 3;   
    end
end

return