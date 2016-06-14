function R = CalcReliability(Rs,Rc,I,rI)
prob = 0;
NS = length(Rs);

if NS == 1
    prob = ProbSensor(Rs,Rc,I,rI,1);
    
elseif NS == 2
    prob = ProbOR2Sensor(Rs,Rc,I,rI,1,2);
        
elseif NS == 3
    prob = ProbOR3Sensor(Rs,Rc,I,rI,1,2,3);
else
    disp('error');
    return
end
R = prob;
return


    
       