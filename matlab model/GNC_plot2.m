function [out_x, out_y, index] = GNC_plot2(gnc_designs, field_x, field_y, varargin)

% SAT_PLOT2
%   [xdata, ydata, index] = gnc_plot2(gnc_designs, 'xfield', 'yfield', ['cfield'], ['rel'], [val])
%
%   Generalized plotting function for arrays of CRISIS-gnc structures.
%   Plots the values of 'yfield' versus 'xfield' for all of the gncellite 
%   designs in the gnc_designs array.  
%
%   Returns a column vector of all values found in xfield (xdata), a column
%   vector of all values found in yfield (ydata), and an index array that 
%   has rows of (i,j,k,l,m) addresses corresponding to a given (xdata, 
%   ydata) pair.  
%
%   For example, the plotted pair (xdata(p), ydata(p)) corresponds to the
%   structure gnc_designs(index(p,1), index(p,2), index(p,3), ...)
%
%   The optional arguments 'cfield', 'rel', and val are used to highlight
%   certain data points that gncisfy a constraint.  The field subject to
%   the constraint is 'cfield' while 'rel' is a relational operator.  This
%   function uses the following codes for relational operators:
%
%       'rel' tag:      MATLAB operator:
%       ---------       ---------------
%         'lt'                 <              
%         'gt'                 >
%         'le'                 <=
%         'ge'                 >=
%         'eq'                 ==
%         'ne'                 ~=
%
%   Finally val is the numerical value against which 'cfield' is compared.
%   For example, to highlight all archietctures where the optical aperture
%   is larger than 1.3 m, use the following syntax:
%
%       [...] = gnc_plot(..., 'Aperture', 'gt', 1.3);
%
%
%   Jared Krueger <jkrue@mit.edu>
%   Daniel Selva <dselva@mit.edu>
%   Matthew Smith <m_smith@mit.edu>
%
%   13 Oct 2008


% -------------------------------------------------------------------------
% Optional case where there is a constraint
% -------------------------------------------------------------------------
n_params = 1;
if nargin == 6

    % assign variables
    field_c = varargin{1};
    rel     = varargin{2};
    val     = varargin{3};
    
    % error checking, make sure input relation flag is recognized
    if ~strcmp(rel, 'lt') &&    ...
       ~strcmp(rel, 'gt') &&    ...
       ~strcmp(rel, 'le') && ...
       ~strcmp(rel, 'ge') && ...
       ~strcmp(rel, 'eq') && ...
       ~strcmp(rel, 'ne');
        fprintf('RELATIONAL: error - Input flag "%s" is not recognized.\n', relation);
        fprintf('                    Must be one of {lt, gt, le, ge, eq, ne}.\n');
        out_x = [];
        out_y = [];
        index = [];
        return;
    end
end


% -------------------------------------------------------------------------
% Extract the data of interest from the structure
% -------------------------------------------------------------------------


    [len1] = length(gnc_designs);
    n_designs = len1;                       % number of designs along this dimension
    out_x    = zeros(n_designs, 1);         % pre-allocate the output arrays
    out_y    = zeros(n_designs, 1);          
    index   = zeros(n_designs, 1); 
    
    % build output arrays by getting field values
    z = 1;
    for i = 1:len1
        
        % get data out of the struct
        out_x(z) = getfield(gnc_designs, {i}, field_x);     % get value of field_x
        out_y(z) = getfield(gnc_designs, {i}, field_y);     % get value of field_y
        index(z,:) = i;                                     % get address in the gnc array
        
        % assign different colors depending on the constraint
        if nargin == 6
            val_c = getfield(gnc_designs, {i}, field_c);
            if relational(val_c, rel, val)
                col(z) = 'b';                   % blue if constraint is gncisfied
            else
                col(z) = 'r';                   % red if constraint is not gncisfied
            end
        else
            col(z) = 'b';                       % blue if no constraint at all
        end
        
        z = z+1;
    end




% -------------------------------------------------------------------------
% Plot the data in a GUI
% -------------------------------------------------------------------------

% create the GUI figure (fh is the figure handle)
fig_name = [field_y ' vs. ' field_x];
fh = figure('Name', fig_name);

% add an axis (ah is the axis handle)
ah = axes('Parent', fh, 'NextPlot', 'add');

% add data to the axes (dh is a vector of handles to the data points)
for ii = 1:z-1
    fprintf('Plotting lines ii = %d\n',ii);
    dh(ii) = line(out_x(ii), out_y(ii),    ...
                'Marker', 'x',          ...
                'LineWidth', 2,         ...
                'LineStyle', 'none',    ...
                'Color', col(ii),        ...
                'ButtonDownFcn', {@mouseclick_callback, ah, gnc_designs, n_params, out_x, out_y, index});
end

% add labels and title
xlabel(field_x);
ylabel(field_y);
title(fig_name);

return

    % ---------------------------------------------------------------------
    function [] = mouseclick_callback(point_handle, eventdata, axis_handle, gncs, npar, xvec, yvec, index)
    % Nested function that controls the behavior after the mouse click.  It
    % highlights the data point that the user clicks on, and displays
    % relevant parts of the gnc structure at that point.
    % 
    % point_handle - handle of the data point being plotted
    % eventdata    - struct containing info about the event (empty)
    % axis_handle  - handle of the axis currently being used
    % gncs         - structure of gncellite designs
    % npar         - number of parameters being varied
    % xvec         - vector of x-axis data points
    % yvec         - vector of y-axis data points
    % index        - vector of addresses

    % get mouse pointer location in axes coordinates
    mouse = get(axis_handle, 'CurrentPoint');
    xmouse = mouse(1,1);
    ymouse = mouse(1,2);
        
    % get data points and index
    xpoint = get(point_handle, 'XData');
    ypoint = get(point_handle, 'YData');
    z     = find((xvec==xpoint).*(yvec==ypoint));
    
    % clear plot
    set(axis_handle, 'NextPlot', 'replacechildren');
    line(out_x(1), out_y(1), 'Marker', 'x', 'LineWidth', 2, 'LineStyle', 'none', 'Color', col(1));
    set(axis_handle, 'NextPlot', 'add');
    
    % refresh the data, using the standard markers
    for ii = 1:z-1
        dh(ii) = line(out_x(ii), out_y(ii),    ...
                      'Marker', 'x',          ...
                      'LineWidth', 2,         ...
                      'LineStyle', 'none',    ...
                      'Color', col(ii),        ...
                      'ButtonDownFcn', {@mouseclick_callback, ah, gnc_designs, n_params, out_x, out_y, index});
    end
    
    % add a green circle around the selected data point
    line(xpoint, ypoint, 'Color', 'g', 'Marker', 'o', 'LineStyle', 'none');
    
    % display message in command window with data
    ind = index(z,:);

    gnc     = gncs(ind(1));
    field1  = gnc.Fields{1};
    val1    = getfield(gncs, {ind(1)}, field1);
    fprintf('Point at (%f, %f)\n', xpoint, ypoint);
    fprintf('Architecture (%d)\n', ind(1));
    fprintf('%25s: %-f\n\n', field1, val1);
    
    return
    
   

% end gnc_plot.m