function str = cat_spaces(cc)
    str = '';
    for i = 1:length(cc)
        str = [str ' ' cc{i}];
    end
end