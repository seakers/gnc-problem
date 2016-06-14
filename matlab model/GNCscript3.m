ind = 0;
for i = 2470:2518
    ns = gncs(i).NS;
    nc = gncs(i).NC;
    nlinks = gncs(i).Nlinks;

    if ns == 3 && nc == 3 && nlinks == 3
        ind = i;
        break;
    end
end
if ind == 0
    fprintf('not found\n');
end

