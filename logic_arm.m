function vals = logic_arm(vals,dataset,G,designs)
% r = global_jess_engine;
% jess batch test.txt
% [N,NF] = size(dataset);
% % assert one feature per element in dataset
% names = dataset.Properties.VariableNames';
% for f = 1:NF
%         var = names{f};
%         r.assertString(['(feature name' var ')']);
% end
initial_feats = vals;
NF = height(vals);
it = 0;
MAX_IT = 20;
NE = round(NF/2);% number of parent features selected
N2 = NE;% number of children features created
features = vals(:,'Feature').Feature;
operators = {'&','|'};
concs = {'AND','OR'};

finish = false;
while (~finish)
    
    % select NE promising features
    sel = vals(vals.driving == true,:);
    h = height(sel);
    if h < NE % if not enough promising, add random (should be better than random)
        rnd = vals(randi(NF,[1 NE-h]),:);
        sel(h+1:NE,:) = rnd;
    elseif height(sel) > NE % if too many, just get the first few
        sel(NE+1:end,:) = [];
    end
    
    % grow selected features (crossover and mutation)
    for i = 1:N2
        % select two random features and create new feature 
        good = false;
        while ~good
            p1 = sel(randi(NE),:);
%             if rand > 0.95
%                 p1.Feature = p1.Feature.reverse;
%             end
            
            if rand < 0.5 % choose a basic variable
                p2= initial_feats(randi(height(initial_feats)),:);
            else % choose an existing feature
                p2 = sel(randi(NE),:);
            end
%             if rand > 0.95
%                 p2.Feature = p2.Feature.reverse;
%             end
            ind = randi(length(operators));
            op = operators{ind};
            conc = concs{ind};
%             new_feat_name = [p1.Feature.Name conc  p2.Feature.Name];
            new_feat_name = ['f_' num2str(string2hash([p1.Feature.Name conc  p2.Feature.Name]))];
            new_feat_str = ['(' p1.Feature.StrFunc ') ' op ' (' p2.Feature.StrFunc ')'];
            new_feat_vars = [p1.Feature.CompFeatures p2.Feature.CompFeatures]; 
            new_feat_values = eval ( ['p1.Feature.Values ' op ' p2.Feature.Values']);   
            new_feat = Feature(new_feat_name,new_feat_str,new_feat_vars,new_feat_values);
            if rand>0.9
                new_feat.mutate(designs);
            end
%             new_feat.Name = char(new_feat.SymFunc);
            %  check if repeated
            repeat = false;
            features = vals.Feature;
            for j = 1:length(features)
                if features(j).equivalent(new_feat)
                    repeat = true;
                    break;
                end
            end
%             good = (p1 ~= p2);
            good = ~repeat;
        end
        
        
        % add this feature to the table
        dataset(:,new_feat_name) = cell2table(num2cell(new_feat_values),'VariableNames',{new_feat_name});
        toadd.name = new_feat_name;
        toadd.formula = new_feat.SymFunc;
        [toadd.supp,toadd.confF_G,toadd.confG_F,toadd.liftF_G,toadd.driving,toadd.interestingness,toadd.IG] = compute_arm_metrics1(dataset,new_feat,G);
        toadd.Feature = new_feat;
        vals = [vals; struct2table(toadd)]; 
        
    end
       
    % discard poor features 
    interestingness = table2array(vals(:,'interestingness'));
    driving = table2array(vals(:,'driving'));
%     vals(:,'interestingness') = array2table(interestingness);
    [vals,~] = sortrows(vals,{'interestingness'},{'descend'}); 
    vals(end-N2+1:end,:) = []
    % iterate
    fprintf('It %d : %d driving features found, min,avg,max interestingness = %.3f %.3f %.3f\n',it,sum(driving),min(interestingness),mean(interestingness),max(interestingness));
    ndriving = sum(table2array(vals(:,'driving')));
    if it >= MAX_IT || ndriving > 5
        finish = true;
    end
    it = it + 1;
end