function dataset = compute_advanced_features2(gncs)
    N = length(gncs);
    minNSNC = zeros(N,1);
    fcs = zeros(N,1);
    homo = zeros(N,1);
    NS = zeros(N,1);
    NC = zeros(N,1);
    NI = zeros(N,1);
    NSA = zeros(N,1);
    NSB = zeros(N,1);
    NSC = zeros(N,1);
    NCA = zeros(N,1);
    NCB = zeros(N,1);
    NCC = zeros(N,1);
    vec_R = zeros(N,1);
    N9 = zeros(N,1);
    vec_m = zeros(N,1);
    C = zeros(N,1);
    
    s1a = zeros(N,1);s1b = zeros(N,1);s1c = zeros(N,1);S1 = zeros(N,1);
    s2a = zeros(N,1);s2b = zeros(N,1);s2c = zeros(N,1);S2 = zeros(N,1);
    s3a = zeros(N,1);s3b = zeros(N,1);s3c = zeros(N,1);S3 = zeros(N,1);
    c1a = zeros(N,1);c1b = zeros(N,1);c1c = zeros(N,1);C1 = zeros(N,1);
    c2a = zeros(N,1);c2b = zeros(N,1);c2c = zeros(N,1);C2 = zeros(N,1);
    c3a = zeros(N,1);c3b = zeros(N,1);c3c = zeros(N,1);C3 = zeros(N,1);
    
    for i = 1:N
        % raw data
        s1 = gncs(i).sensors(1);s1a(i) = s1 == '1';s1b(i) = s1 == '2';s1c(i) = s1 == '3';S1(i) = s1;
        s2 = gncs(i).sensors(2);s2a(i) = s2 == '1';s2b(i) = s2 == '2';s2c(i) = s2 == '3';S2(i) = s2;
        s3 = gncs(i).sensors(3);s3a(i) = s3 == '1';s3b(i) = s3 == '2';s3c(i) = s3 == '3';S3(i) = s3;
        c1 = gncs(i).computers(1);c1a(i) = c1 == '1';c1b(i) = c1 == '2';c1c(i) = c1 == '3';C1(i) = c1;
        c2 = gncs(i).computers(2);c2a(i) = c2 == '1';c2b(i) = c2 == '2';c2c(i) = c2 == '3';C2(i) = c2;
        c3 = gncs(i).computers(3);c3a(i) = c3 == '1';c3b(i) = c3 == '2';c3c(i) = c3 == '3';C3(i) = c3;
        ns = gncs(i).NS;
        nc = gncs(i).NC;
        tmp = find(gncs(i).sensors=='1');if isempty(tmp),NSA(i)=0; else NSA(i) = length(tmp);end
        tmp = find(gncs(i).sensors=='2');if isempty(tmp),NSB(i)=0; else NSB(i) = length(tmp);end
        tmp = find(gncs(i).sensors=='3');if isempty(tmp),NSC(i)=0; else NSC(i) = length(tmp);end
        tmp = find(gncs(i).computers=='1');if isempty(tmp),NCA(i)=0; else NCA(i) = length(tmp);end
        tmp = find(gncs(i).computers=='2');if isempty(tmp),NCB(i)=0; else NCB(i) = length(tmp);end
        tmp = find(gncs(i).computers=='3');if isempty(tmp),NCC(i)=0; else NCC(i) = length(tmp);end
        NS(i) = ns;
        NC(i) = nc;
        vec_m(i) = gncs(i).m;
        vec_R(i) = gncs(i).R;
        N9(i) = gncs(i).N9;
        
        % min NS NC
        minNSNC(i) = min([gncs(i).NS gncs(i).NC]);
        if gncs(i).Ibin  == 49*ones(ns,nc)
            fcs(i) = 1;
        end
        NI(i) = sum(sum(gncs(i).Ibin-48));
        
        % Count percentage of homogeneous architectures
        bool_homog = 1;

        if ns == 1
        elseif ns == 2
            if s1 ~= s2
                bool_homog = 0;
            end
        else
            if ~(s1 == s2 && s2 == s3)
                bool_homog = 0;
            end
        end

        if nc == 1
        elseif nc == 2
            if c1 ~= c2
                bool_homog = 0;
            end
        else
            if ~(c1 == c2 && c2 == c3)
                bool_homog = 0;
            end
        end

        if bool_homog == 1
            homo(i) = 1;
        end
        if N9(i)<4
            C(i)= 1;
        elseif N9(i) < 7.66
            C(i) = 2;
        else
            C(i) = 3;
        end
                
    end
    
    vec_1 = ones(N,1);
    vec_U = vec_1-vec_R;
    front = paretofront([vec_U vec_m]);
    
    CC1 = N9<4;
    CC2 = N9>4 & N9<7.66;
    CC3 = N9>7.66;
    

    NS1 = NS == 1;
    NS2 = NS == 2;
    NS3 = NS == 3;
    NC1 = NC == 1;
    NC2 = NC == 2;
    NC3 = NC == 3;
    
    minNSNC1 = minNSNC == 1;
    minNSNC2 = minNSNC == 2;
    minNSNC3 = minNSNC == 3;
    dataset = table(front,s1a,s1b,s1c,s2a,s2b,s2c,s3a,s3b,s3c,c1a,c1b,c1c,c2a,c2b,c2c,c3a,c3b,c3c,NS1,NS2,NS3,NC1,NC2,NC3,minNSNC1,minNSNC2,minNSNC3,fcs,homo,CC1,CC2,CC3);
%     dataset = table(CC3, s1a,s1b,s1c,s2a,s2b,s2c,s3a,s3b,s3c,c1a,c1b,c1c,c2a,c2b,c2c,c3a,c3b,c3c);
   
end
