function [out1, out2] = GNC_plot(GNC, field1, field2, mode)

% GNC_PLOT
% Returns Reliability and mass vectors and plots them in a pareto front
% -------------------------------------------------------------------------
% Extract the data of interest from the structure
% -------------------------------------------------------------------------

%n_params = ndims(GNC);
n_designs = length(GNC);                
out1    = zeros(n_designs, 1);          % pre-allocate the output arrays
out2    = zeros(n_designs, 1);          
index   = zeros(n_designs, 1); 
z = 1;                                  % index for output vectors
for i = 1:n_designs                          % build output arrays by getting field values
    out1(z) = getfield(GNC, {i}, field1);
    out2(z) = getfield(GNC, {i}, field2);
    index(z,1) = i;
    z = z+1;
end

if strcmp(field1,'R')
    txt1 = 'Reliability(10 yr)';
elseif strcmp(field1,'N9')
    txt1 = '# of 9''s in R';
end

if strcmp(field2,'m')
    txt2 = 'Mass (adimensional)';
else
    
end
% -------------------------------------------------------------------------
% Plot the data in a GUI
% -------------------------------------------------------------------------

% create the GUI figure (fh is the figure handle)
fig_name = [txt2 ' vs. ' txt1];
fh = figure('Name', fig_name);

% add an axis (ah is the axis handle)
%ah = axes('Parent', fh, 'NextPlot', 'replacechildren');
%ah = axes('Parent', fh);
% add sample data to the axes (dh is the handle to the data points)
% x = 0 : 0.1 : 10;
% y = x.^2;
%dh = semilogx(ah, out1, out2, 'x', 'LineWidth', 2);
if strcmp(mode,'log')
    ah = axes('Parent', fh);
    dh = semilogx(out1, out2, 'x', 'LineWidth', 2);
elseif strcmp(mode,'lin')
    ah = axes('Parent', fh, 'NextPlot', 'replacechildren');
    dh = plot(out1, out2, 'x', 'LineWidth', 2);
else
    disp('[GNC_plot] Error : "mode" can only be "log" or "lin".\n');
end

% add labels and title
xlabel(txt1,'Fontsize',12);
ylabel(txt2,'Fontsize',12);
title(fig_name,'Fontsize',15);

% execute mouseclick_callback when the mouse is clicked on a data point
set(dh, 'ButtonDownFcn', {@mouseclick_callback, ah, GNC, index, mode});

    % ---------------------------------------------------------------------
    function [] = mouseclick_callback(point_handle, eventdata, axis_handle, GNCs, index, mode)
    % Nested function that controls the behavior after the mouse click.  It
    % highlights the data point that the user clicks on, and displays
    % relevant parts of the sat structure at that point.
    % 
    % point_handle - handle of the data points being plotted
    % eventdata    - struct containing info about the event (empty)
    % axis_handle  - handle of the axis currently being used
    
    % get mouse pointer location in axes coordinates
    mouse = get(axis_handle, 'CurrentPoint');
    xmouse = mouse(1,1);
    ymouse = mouse(1,2);
        
    % get data points
    xdata = get(point_handle, 'XData');
    ydata = get(point_handle, 'YData');
        
    % find xdata closest to xmouse (could have done ydata/ymouse too)
    format long E;
    [val, i] = min(abs(xdata - xmouse).^2+abs(ydata - ymouse).^2);
    xpoint   = xdata(i);
    ypoint   = ydata(i);
    
    % refresh the data, using the standard markers
    %dh = semilogx(ah, xdata, ydata, 'x', 'LineWidth', 2);
    if strcmp(mode,'log')
        dh = semilogx(ah, xdata, ydata, 'x', 'LineWidth', 2);
    elseif strcmp(mode,'lin')
        dh = plot(ah, xdata, ydata, 'x', 'LineWidth', 2);
    else
        disp('[GNC_plot] Error : "mode" can only be "log" or "lin".\n');
    end

    set(dh, 'ButtonDownFcn', {@mouseclick_callback, ah, GNC, index, mode});
    
    % add a red circle around the selected data point
    line(xpoint, ypoint, 'Color', 'r', 'Marker', 'o', 'LineStyle', 'none');
    
    % display message in command window with data
    ind = index(i,1);
    arc     = GNCs(ind(1));
%     field1  = arc.Fields{1};
    ns    = getfield(GNCs, {ind(1)}, 'NS');
    nc    = getfield(GNCs, {ind(1)}, 'NC');
    sens  = getfield(GNCs, {ind(1)}, 'sensors');
    comp  = getfield(GNCs, {ind(1)}, 'computers');
    inter = getfield(GNCs, {ind(1)}, 'Inat');
    m = getfield(GNCs, {ind(1)}, 'm');
    R = getfield(GNCs, {ind(1)}, 'R');
    msa = getfield(GNCs, {ind(1)}, 'M_SA');
    msb = getfield(GNCs, {ind(1)}, 'M_SB');
    msc = getfield(GNCs, {ind(1)}, 'M_SC');
    mca = getfield(GNCs, {ind(1)}, 'M_CA');
    mcb = getfield(GNCs, {ind(1)}, 'M_CB');
    mcc = getfield(GNCs, {ind(1)}, 'M_CC');
    rsa = getfield(GNCs, {ind(1)}, 'R_SA');
    rsb = getfield(GNCs, {ind(1)}, 'R_SB');
    rsc = getfield(GNCs, {ind(1)}, 'R_SC');
    rca = getfield(GNCs, {ind(1)}, 'R_CA');
    rcb = getfield(GNCs, {ind(1)}, 'R_CB');
    rcc = getfield(GNCs, {ind(1)}, 'R_CC');
    mi0 = getfield(GNCs, {ind(1)}, 'M_I0');
    ri0 = getfield(GNCs, {ind(1)}, 'R_I0');
    n9 = getfield(GNCs, {ind(1)}, 'N9');
    fprintf('Point at (%f, %f)\n', xpoint, ypoint);
    fprintf('Architecture (%d)\n', ind(1));
    fprintf('(NS,NC) = (%d, %d)\n', ns, nc);
    fprintf('sensors = %s\n', sens);
    fprintf('computers = %s\n', comp);
    if ns == 1
        fprintf('[I1] = [%d]\n', inter(1));
    elseif ns == 2
        fprintf('[I1 I2] = [%d %d]\n', inter(1), inter(2));
    else
        fprintf('[I1 I2 I3] = [%d %d %d]\n', inter(1), inter(2), inter(3));
    end
    fprintf('Mass = %f\n', m);
    fprintf('Reliability= %f, # of 9''s = %d\n', R, n9);
    fprintf('Mass of each type of sensor [m_sa m_sb m_sc] = [%f %f %f]\n', msa, msb ,msc);
    fprintf('Reliability of each type of sensor [r_sa r_sb r_sc] = [%f %f %f]\n', rsa, rsb ,rsc);
    fprintf('Mass of each type of computer [m_ca m_cb m_cc] = [%f %f %f]\n', mca, mcb ,mcc);
    fprintf('Reliability of each type of computer [r_ca r_cb r_cc] = [%f %f %f]\n', rca, rcb ,rcc);
    fprintf('Interconnections [m_i r_i] = [%f %f]\n\n', mi0, ri0);
    end
    % ---------------------------------------------------------------------

end

% end gnc_plot.m