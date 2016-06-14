function prob = probOR2Link(Rs,Rc,Ri,link1,link2)
%link1 = [s1,c1]

s1 = link1(1);
c1 = link1(2);
s2 = link2(1);
c2 = link2(2);

p1 = ProbLink(Rs,Rc,Ri,link1);
p2 = ProbLink(Rs,Rc,Ri,link2);

Rs2 = Rs;
Rc2 = Rc;
if s1 == s2 % Links Share sensor
    if s1 == 1 % Links Share sensor1
        Rs2(1) = 1;
    end
    if s1 == 2 % Links Share sensor2
        Rs2(2) = 1;
    end
    if s1 == 3% Links Share sensor3
        Rs2(3) = 1;
    end
end

if c1 == c2 % Links Share computer
    if c1 == 1% Links Share computer 1
        Rc2(1) = 1;
    end
    if c1 == 2% Links Share computer 2
        Rc2(2) = 1;
    end
    if c1 == 3 % Links Share computer 3
        Rc2(3) = 1;
    end 
end

p1c = ProbLink(Rs2,Rc2,Ri,link1);
prob = p1+p2-p1c*p2;

return