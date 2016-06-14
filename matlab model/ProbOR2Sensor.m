function prob = ProbOR2Sensor(Rs,Rc,I,rI,s1,s2)
prob = 0;

p1 = ProbSensor(Rs,Rc,I,rI,s1);
p2 = ProbSensor(Rs,Rc,I,rI,s2);


Rc2 = Rc;

if contc1(I(s1)) && contc1(I(s2)) % Links Share computer 1
    Rc2(1) = 1;
end
if contc2(I(s1)) && contc2(I(s2))% Links Share computer 2
    Rc2(2) = 1;
end
if contc2(I(s1)) && contc2(I(s2)) % Links Share computer 3
    Rc2(3) = 1;
end 


p1c = ProbSensor(Rs,Rc2,I,rI,s1);
prob = p1+p2-p1c*p2;


return