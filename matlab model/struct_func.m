function XT = struct_func(varargin)
n = length(varargin);
YT = 1;
for i = 1:n
    YT = YT*(1-varargin{i});
end
XT = 1 - YT;
return
    