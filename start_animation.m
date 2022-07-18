function start_animation(ax,VanishingPoint_3D,TwelfPoints_3D)
    center = [(TwelfPoints_3D(1,1)+TwelfPoints_3D(1,2))/2,(TwelfPoints_3D(2,1)+TwelfPoints_3D(2,7))/2];
    x_bound = abs((TwelfPoints_3D(1,1)-TwelfPoints_3D(1,2))/2)*0.75;
    y_bound = abs((TwelfPoints_3D(2,7)-TwelfPoints_3D(2,1))/2)*0.75;
    z_lbound = min(TwelfPoints_3D(3,3),TwelfPoints_3D(3,5))/3;
    z_rbound = VanishingPoint_3D(3)*0.5;
    
    for z = z_lbound:5:z_rbound
    campos(ax,[center(1),center(2),z])
    drawnow
    pause(.1)
    end

    for y = 0:5:y_bound
        campos(ax,[center(1),center(2)-y,z_rbound])
        drawnow
        pause(.1)
    end
    
    for y = y_bound:-5:0
        campos(ax,[center(1),center(2)-y,z_rbound])
        drawnow
        pause(.1)
    end

    for x = 0:5:x_bound
        campos(ax,[center(1)-x,center(2),z_rbound])
        camtarget(ax,[center(1)-x,center(2),VanishingPoint_3D(3)])
        drawnow
        pause(.1)
    end

    for x = x_bound:-5:-x_bound
        campos(ax,[center(1)-x,center(2),z_rbound])
        camtarget(ax,[center(1)-x,center(2),VanishingPoint_3D(3)])
        drawnow
        pause(.1)
    end

    for x = -x_bound:5:0
        campos(ax,[center(1)-x,center(2),z_rbound])
        camtarget(ax,[center(1)-x,center(2),VanishingPoint_3D(3)])
        drawnow
        pause(.1)
    end

    for z = z_rbound:-5:z_lbound
        campos(ax,[center(1),center(2),z])
        drawnow
        pause(.1)
    end
end