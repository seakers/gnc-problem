%exampleReliab
Rs = [sym('s1');sym('s2');sym('s3')];
Rc = [sym('c1');sym('c2');sym('c3')];
I = [7;7;7];
rI = [sym('i11') sym('i12') sym('i13');sym('i21') sym('i22') sym('i23');sym('i31') sym('i32') sym('i33')];

R = CalcReliability(Rs,Rc,I,rI)