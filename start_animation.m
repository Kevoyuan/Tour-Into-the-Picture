function start_animation(ax,VanishingPoint_3D,TwelfPoints_3D)
    %% animation
    % In this function, basic movements of the camera is defined, which are zoom
    % in/zoom out/look up/look down/turn left/turn right. A tour animation
    % using these 6 types of camera movements is generated for demonstration.

    % the initial point of the camera should not coincide with the vanishing
    % point. It should be set to align with the center of the rear wall,
    % otherwise the whole picture is going to have some offset.
    center = [(TwelfPoints_3D(1,1)+TwelfPoints_3D(1,2))/2,(TwelfPoints_3D(2,1)+TwelfPoints_3D(2,7))/2];
    x_bound = abs((TwelfPoints_3D(1,1)-TwelfPoints_3D(1,2))/2)*0.75;
    y_bound = abs((TwelfPoints_3D(2,7)-TwelfPoints_3D(2,1))/2)*0.75;
    z_lbound = min(TwelfPoints_3D(3,3),TwelfPoints_3D(3,5))/3;
    z_rbound = VanishingPoint_3D(3)*0.5;
 
 % zoom in
    for z = z_lbound:5:z_rbound
    campos(ax,[center(1),center(2),z])
    drawnow
    pause(.1)
    end
% look up
    for y = 0:5:y_bound
        campos(ax,[center(1),center(2)-y,z_rbound])
        drawnow
        pause(.1)
    end
% look down    
    for y = y_bound:-5:0
        campos(ax,[center(1),center(2)-y,z_rbound])
        drawnow
        pause(.1)
    end
% turn right
    for x = 0:5:x_bound
        campos(ax,[center(1)-x,center(2),z_rbound])
        camtarget(ax,[center(1)-x,center(2),VanishingPoint_3D(3)])
        drawnow
        pause(.1)
    end
% turn left
    for x = x_bound:-5:-x_bound
        campos(ax,[center(1)-x,center(2),z_rbound])
        camtarget(ax,[center(1)-x,center(2),VanishingPoint_3D(3)])
        drawnow
        pause(.1)
    end
% turn right to initial poin
    for x = -x_bound:5:0
        campos(ax,[center(1)-x,center(2),z_rbound])
        camtarget(ax,[center(1)-x,center(2),VanishingPoint_3D(3)])
        drawnow
        pause(.1)
    end
%zoom out
    for z = z_rbound:-5:z_lbound
        campos(ax,[center(1),center(2),z])
        drawnow
        pause(.1)
    end
end