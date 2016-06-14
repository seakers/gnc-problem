classdef Feature
   properties
      Name
      StrFunc
      CompFeatures
      Values
      SymFunc
   end
   methods
       function ff = Feature(name, str, vars, values)
           ff.Name = name;
%            ff.StrFunc = str;
           ff.CompFeatures = vars;
           eval(['syms ' cat_spaces(vars)]);
           eval(['cur = ' str ';'])
           ff.SymFunc = char(simplify(cur));
           ff.StrFunc  = str;
           if ~isempty(values)
               ff.Values = values;
           end
       end
       
      function b = applyFeat(f,design)
         zefunc = f.StrFunc; 
         for i = 1:length(f.CompFeatures)
             var = f.CompFeatures{i};
             zefunc = strrep(zefunc,var,['design.' var]);
             zefunc = strrep(zefunc,'design.design','design');
         end
%          if eval([ 'design.' f.StrFunc ]) == 1
         if eval(zefunc) == 1
             b = true;
         else
             b = false;
         end
      end

      function b = equivalent(f,f2)
          b = strcmp(f.SymFunc,f2.SymFunc);
      end
      
      function ff = reverse(f)
          ff = f;
          vars =f.CompFeatures;
          eval(['syms ' cat_spaces(vars)]);
          eval(['cur = ~(' f.StrFunc ');']);
          ff.StrFunc  = ['~(' f.StrFunc ')']; 
          ff.SymFunc = char(simplify(cur));
          ff.Values = ~f.Values;
      end
      
      function ff = mutate(f,designs)
          ff = f;
          vars =f.CompFeatures;
          
          r1 = vars{randi(length(vars))};
          r2 = vars{randi(length(vars))};
          ff.StrFunc  = strrep(f.StrFunc,r1,r2);
          eval(['syms ' cat_spaces(vars)]);
          eval(['cur = '  ff.StrFunc ';'])
          ff.SymFunc = char(simplify(cur));
          ff.Values = ff.computeValues(designs);
      end
      function vals = computeValues(f,designs)
          N = length(designs);
          vals = zeros(N,1);
          for i = 1:N
              vals(i) = f.applyFeat(designs(i));
          end
      end

        
      
   end
end