% script GNCall5
% Script to generate the plot of influence of reliability scaling factor on
% the percentages of components on the PF

kk = [0.1:0.1:1.0];
for i = 1:length(kk)
    gnc = GNC_init();
    gnc.RelScaleFactor = kk(i);
    gncs = GNC_enumerate(gnc);
    gncs = GNC_evaluate(gncs);

    %GNC_plot(gncs,'R','m','lin');
    [front,CS,NS,NC,NH] = GNC_paretofront(gncs);
    filename = ['casekk',num2str(i)];
    save(filename);
    clear gnc gncs front CS NS NC NH filename;
end

numA = zeros(length(kk),1);
numB = zeros(length(kk),1);
numC = zeros(length(kk),1);
for i = 1:length(kk)
    filename = ['casekk',num2str(i)];
    load(filename);
    numA(i) = NS(1);
    numB(i) = NS(2);
    numC(i) = NS(3);
end