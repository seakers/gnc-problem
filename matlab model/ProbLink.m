function prob = ProbLink(Rs,Rc,Ri,link)
% link = [sen com]
prob = double(0.0);
s = Rs(link(1));
ii = Ri(link(1),link(2));
c = Rc(link(2));

prob = s*ii*c;
return


    
       