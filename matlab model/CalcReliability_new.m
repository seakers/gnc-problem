function R = CalcReliability_new(Rs,Rc,Ri)
% GNC = CalcReliability_new(Rs,Rc,Ri)
% Calculates the reliability of an arbitrary architecture by generating all
% the possible failure cases, computing their individual probabilities and
% a boolean indicating whether this particular case leads to system failure
% or if it is absorbed by the redundancy of the system. Reliability is then
% calculated as the sum of the products of the booleans by their
% probabilities.
% 
% Inputs: 
%       Rs [NSx1],Rc [NCx1] vectors giving the reliabilities of the
%       sensors and computers respectively.
%       Ri [NSxNC] matrix giving the reliability of each
%       interconnection. Ri(i,j) is the reliability of the connection between
%       sensor i and computer j, or 0 if there is no connection between these
%       elements. 
% 
% Outputs: 
%       R = Reliability of the particular architecture. 
%


% NS,NC
ns = length(Rs);
nc = length(Rc);

% Initializations
rel = 0;
k = 0;
% Loop

for failing_sensors = 0:2^ns - 1 % 0 = all sensors fail; 2^ns-1 = all sensors OK
    vec_fs = de2bi(failing_sensors,ns); % vec_fs is a vector with 0 and 1s. 0 = fail; 1 = OK.
    vec_fs = reshape(vec_fs,ns,1); % vec_fs must be a vector column.

    % Calculate probability of being in this case for sensors
    prob_s = 1;
    for i = 1:ns
        if vec_fs(i) == 1 %sensor i OK
            prob_s = prob_s*Rs(i);
        else
            prob_s = prob_s*(1-Rs(i));
        end
    end
    
    for failing_computers = 0:2^nc - 1 % 0 = all computers fail; 2^nc-1 = all computers OK
        vec_fc = de2bi(failing_computers,nc); % vec_fc is a vector with 0 and 1s. 0 = fail; 1 = OK. 
        vec_fc = reshape(vec_fc,nc,1); % vec_fc must be a vector column.
        
        % Calculate probability of being in this case for computers
        prob_c = 1;
        for i = 1:nc
            if vec_fc(i) == 1 %computer i OK
                prob_c = prob_c*Rc(i);
            else
                prob_c = prob_c*(1-Rc(i));
            end
        end
    
        for failing_connections = 0:2^(ns*nc) - 1 % 0 = all connections fail; 2^(ns*nc)-1 = all connections OK
           k = k + 1;
           %fprintf('CalcReliability: case %d\n',k);
           vec_fi = de2bi(failing_connections,ns*nc); % vec_fi is a vector with 0 and 1s. 0 = fail; 1 = OK.
           mat_fi = reshape(vec_fi,ns,nc);
           
           % Calculate probability of being in this case for computers
            prob_i = 1;
            for i = 1:ns
                for j = 1:nc
                    if mat_fi(i,j) == 1 %connection (i,j) OK
                        prob_i = prob_i*Ri(i,j);
                    else
                        prob_i = prob_i*(1-Ri(i,j));
                    end
                end             
            end
        
           % Calculate boolean b = 0 if the case leads to system failure, 1
           % if the system does not fail thanks to redundancy
           
           b = ((vec_fs'*mat_fi*vec_fc) > 0); % if >0 it means that there is a path that allows the information to pass so the system does not fail
           
           % Calculate the probability of being in this case. Since the
           % elements are all independent, the probability is simply the
           % products of the individual probabilities.
           
           prob = prob_s*prob_i*prob_c;
           
           % Calculate reliability 
           rel = rel + prob*b;
           
           %sprob = sprob + prob; %Calc total prob to check unity.
           
        end
    end
end

R = rel;

return;