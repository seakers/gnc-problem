function prob = ProbSensor(Rs,Rc,I,rI,indS)
prob = 0;
N = length(Rc);
int = I(indS);
if int == 1
    prob = ProbLink(Rs,Rc,rI,[indS 1]);
    
elseif int == 2
    prob = ProbLink(Rs,Rc,rI,[indS 2]);
        
elseif int == 3
    prob = probOR2Link(Rs,Rc,rI,[indS 1],[indS 2]);

elseif int == 4
    prob = ProbLink(Rs,Rc,rI,[indS 3]);

elseif int == 5
    prob = probOR2Link(Rs,Rc,rI,[indS 1],[indS 3]);
    
elseif int == 6
    prob = probOR2Link(Rs,Rc,rI,[indS 2],[indS 3]);
    
elseif int == 7
    prob = probOR3Link(Rs,Rc,rI,[indS 1],[indS 2],[indS 3]);
else
    disp('error');
    return
end

return


    
       