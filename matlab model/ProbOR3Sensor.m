function prob = ProbOR3Sensor(Rs,Rc,I,rI,s1,s2,s3)
prob = 0;

p1 = ProbSensor(Rs,Rc,I,rI,s1);
p2 = ProbSensor(Rs,Rc,I,rI,s2);
p3 = ProbSensor(Rs,Rc,I,rI,s3);


Rc2 = Rc;

if contc1(I(s1)) && contc1(I(s2)) % Links Share computer 1
    Rc2(1) = 1;
end
if contc2(I(s1)) && contc2(I(s2))% Links Share computer 2
    Rc2(2) = 1;
end
if contc3(I(s1)) && contc3(I(s2)) % Links Share computer 3
    Rc2(3) = 1;
end 
p1c = ProbSensor(Rs,Rc2,I,rI,s1);

Rc3 = Rc;
if contc1(I(s1)) && contc1(I(s3)) || contc1(I(s2)) && contc1(I(s3))% Links Share computer 1
    Rc3(1) = 1;
end
if contc2(I(s1)) && contc2(I(s3)) || contc2(I(s2)) && contc2(I(s3)) % Links Share computer 2
    Rc3(2) = 1;
end
if contc3(I(s1)) && contc3(I(s3)) || contc3(I(s2)) && contc3(I(s3)) % Links Share computer 3
    Rc3(3) = 1;
end 
p2c = ProbOR2Sensor(Rs,Rc3,I,rI,s1,s2);

prob = p1+p2+p3-p1c*p2-p2c*p3;


return