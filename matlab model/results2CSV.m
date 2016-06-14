function results2CSV(GNC8)
fid = fopen('C:\Users\Dani\Documents\PhD\research\tasks\projects\GNC system architecture\matlab model\results.csv','w+');
    fprintf(fid,'%s ,','C1');
    fprintf(fid,'%s ,','C2');
    fprintf(fid,'%s ,','C3');
    fprintf(fid,'%s ,','I1');
    fprintf(fid,'%s ,','I2');
    fprintf(fid,'%s ,','I3');
    fprintf(fid,'%s ,','NC');
    fprintf(fid,'%s ,','NS');
    fprintf(fid,'%s ,','S1');
    fprintf(fid,'%s ,','S2');
    fprintf(fid,'%s \n','S3');

    %fprintf(fid,'%s ;','m');
    %fprintf(fid,'%s ;','R');
    %fprintf(fid,'%s ;\n','Nlinks');
for i=1:length(GNC8)
    vec_C1(i) =  GNC8(i).computers(:,1);
    vec_C2(i) =  GNC8(i).computers(:,2);
    vec_C3(i) =  GNC8(i).computers(:,3);
    vec_NS(i) = GNC8(i).NS;
    vec_I1(i) = GNC8(i).Inat(1);
%    vec_m(i)  = GNC8(i).m;
%    vec_R(i)  = GNC8(i).R;
    vec_Nlinks(i)  = GNC8(i).nlinks;
    if vec_NS(i) > 1
        vec_I2(i) = GNC8(i).Inat(2);
    else
        vec_I2(i) = 0;
    end
    if vec_NS(i) > 2
        vec_I3(i) = GNC8(i).Inat(3);
    else
        vec_I3(i) = 0;
    end
    vec_NC(i) = GNC8(i).NC;

    vec_S1(i) =  GNC8(i).sensors(:,1);
    vec_S2(i) =  GNC8(i).sensors(:,2);
    vec_S3(i) =  GNC8(i).sensors(:,3);

    fprintf(fid,'%s ,',char(vec_C1(i)));
    fprintf(fid,'%s ,',char(vec_C2(i)));
    fprintf(fid,'%s ,',char(vec_C3(i)));
    fprintf(fid,'%d ,',vec_I1(i));
    fprintf(fid,'%d ,',vec_I2(i));
    fprintf(fid,'%d ,',vec_I3(i));
    fprintf(fid,'%d ,',vec_NC(i));
    fprintf(fid,'%d ,',vec_NS(i));
    fprintf(fid,'%s ,',char(vec_S1(i)));
    fprintf(fid,'%s ,',char(vec_S2(i)));
    fprintf(fid,'%s \n',char(vec_S3(i)));

    %fprintf(fid,'%d ;',vec_m(i));
    %fprintf(fid,'%14.12f ;',vec_R(i));
    %fprintf(fid,'%d ;\n',vec_Nlinks(i));
    
%    vecNS(i)     = GNC8(i).NS;
%    results(i,2) = GNC8(i).NC;
%    results(i,3) = GNC8(i).sensors;
%    results(i,4) = GNC8(i).computers;
%    results(i,5) = GNC8(i).Inat;
%    results(i,6) = char(GNC8(i).Ibin);
%
end
fclose(fid);
return
