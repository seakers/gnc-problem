% Robj = 0.9999;
% rso = [0.984151 0.974881 0.960189 0.936904];
% ind = zeros(length(rso),1);
% 
% for i=1:length(rso)
%     gnc = GNC_init();
%     gnc.R_S0 = rso(i);
%     gncs = GNC_enumerate(gnc);
%     gncs = GNC_evaluate(gncs);
%     %GNC_plot(gncs,'R','m','lin');
%     ind(i) = GNC_find_opt(gncs,Robj);
%     fprintf('Arch %d\n',i);
%     gncs(ind(i)).sensors
%     gncs(ind(i)).computers    
% end

%Robj = 0.9999;

%% mi = 0 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ri = [1 0.99999999 0.9999999 0.999999 0.99999 0.9999 0.999];
mi = 0.*[1 1 1 1 1 1 1];
%ind = zeros(length(rso),1);
front1 = zeros(length(ri),50);
pctg1 = zeros(length(ri),1);
%ind = zeros(length(ri),1);
%U = zeros(length(ri),1);
for i=1:length(ri)
    gnc = GNC_init();
    gnc.R_I0 = ri(i);
    gnc.M_I0 = mi(i);
    gncs = GNC_enumerate(gnc);
    gncs = GNC_evaluate(gncs);
    %gncs(2518).R = CalcReliability_new(0.999.*ones(3,1),0.9996.*ones(3,1),ri(i).*ones(3));
    filename = ['set' num2str(i)];
    save(filename,'gncs');
    %[ind(i),U(i)] = GNC_find_maxA(gncs);
    %GNC_plot(gncs,'R','m','lin');
    %ind(i) = GNC_find_opt(gncs,Robj);
    [front1(i,:),pctg1(i)] = GNC_paretofront(gncs,50);
    fprintf('For Mi = %d, Ri =  %f, %d percent of the architectures in the Pareto front are cross-strapped\n',mi(i), ri(i),pctg1(i));
    %fprintf('For Mi = %d, Ri =  %f, the max # of 9 of Reliab we can get with only A elements is %f\n',mi(i), ri(i),U(i)); 
    %gncs(ind(i)).sensors
    %gncs(ind(i)).computers    
end

%% mi = 0.5 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ri = [1 0.99999999 0.9999999 0.999999 0.99999 0.9999 0.999];
mi = 0.5*[1 1 1 1 1 1 1];
%ind = zeros(length(rso),1);
front2 = zeros(length(ri),50);
pctg2 = zeros(length(ri),1);
%ind = zeros(length(ri),1);
%U = zeros(length(ri),1);
for i=1:length(ri)
    gnc = GNC_init();
    gnc.R_I0 = ri(i);
    gnc.M_I0 = mi(i);
    gncs = GNC_enumerate(gnc);
    gncs = GNC_evaluate(gncs);
    %gncs(2518).R = CalcReliability_new(0.999.*ones(3,1),0.9996.*ones(3,1),ri(i).*ones(3));
    filename = ['set' num2str(i+7)];
    save(filename,'gncs');
    %[ind(i),U(i)] = GNC_find_maxA(gncs);
    %GNC_plot(gncs,'R','m','lin');
    %ind(i) = GNC_find_opt(gncs,Robj);
    [front2(i,:),pctg2(i)] = GNC_paretofront(gncs,50);
    fprintf('For Mi = %d, Ri =  %f, %d percent of the architectures in the Pareto front are cross-strapped\n',mi(i), ri(i),pctg2(i));
    %fprintf('For Mi = %d, Ri =  %f, the max # of 9 of Reliab we can get with only A elements is %f\n',mi(i), ri(i),U(i)); 
    %gncs(ind(i)).sensors
    %gncs(ind(i)).computers    
end

%% mi = 0.1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ri = [1 0.99999999 0.9999999 0.999999 0.99999 0.9999 0.999];
mi = 0.1*[1 1 1 1 1 1 1];
%ind = zeros(length(rso),1);
front3 = zeros(length(ri),50);
pctg3 = zeros(length(ri),1);
%ind = zeros(length(ri),1);
%U = zeros(length(ri),1);
for i=1:length(ri)
    gnc = GNC_init();
    gnc.R_I0 = ri(i);
    gnc.M_I0 = mi(i);
    gncs = GNC_enumerate(gnc);
    gncs = GNC_evaluate(gncs);
    %gncs(2518).R = CalcReliability_new(0.999.*ones(3,1),0.9996.*ones(3,1),ri(i).*ones(3));
    filename = ['set' num2str(i+14)];
    save(filename,'gncs');
    %[ind(i),U(i)] = GNC_find_maxA(gncs);
    %GNC_plot(gncs,'R','m','lin');
    %ind(i) = GNC_find_opt(gncs,Robj);
    [front3(i,:),pctg3(i)] = GNC_paretofront(gncs,50);
    fprintf('For Mi = %d, Ri =  %f, %d percent of the architectures in the Pareto front are cross-strapped\n',mi(i), ri(i),pctg3(i));
    %fprintf('For Mi = %d, Ri =  %f, the max # of 9 of Reliab we can get with only A elements is %f\n',mi(i), ri(i),U(i)); 
    %gncs(ind(i)).sensors
    %gncs(ind(i)).computers    
end

