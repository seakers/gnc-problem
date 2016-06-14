function gnc_sens_plot(src,eventdata,archs,x,y)
    % Find the closest point arch to the mouse click
    mouse = get( gca, 'CurrentPoint' );
    xmouse = mouse(1,1);
    ymouse = mouse(1,2);
    [~,ind] = min( abs((x - xmouse)/(max(x)-min(x))).^2+abs((y - ymouse)/(max(y)-min(y))).^2 );
    arch = archs(ind);
    fprintf('Arch %s\n',to_string(arch));
end
function str = to_string(arch)
    str = ['Sensors = ' arch.sensors ' Computers = ' arch.computers ' I = ' num2str(arch.Inat')];

end