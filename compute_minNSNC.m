function gncs = compute_minNSNC(gncs)
    N = length(gncs);

    for i = 1:N
        gncs(i).minNSNC = min([gncs(i).NS gncs(i).NC]);
    end
end
