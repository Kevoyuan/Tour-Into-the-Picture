function show3Droom(ax,cam_position,VanishingPoint_3D)
    % initial settings
    v = [0,0,-1];
    view(ax,v);
    
    camproj(ax,'perspective');
    camva(ax,'manual');
    camva(ax,90);
    camup(ax,[0,-1,0]);
    
    %show 3D room according to camera position 
    campos(ax,cam_position);
    camtarget(ax,[cam_position(1),cam_position(1),VanishingPoint_3D(3)]);
    drawnow
    axis(ax,'equal')
    axis(ax,'vis3d','off')
end

