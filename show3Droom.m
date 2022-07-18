function show3Droom(ax,cam_position,VanishingPoint_3D)
    v = [0,0,-1];
    view(ax,v);
    
    camproj(ax,'perspective');
    camva(ax,'manual');
    camva(ax,90);
    camup(ax,[0,-1,0]);
    
    campos(ax,cam_position);
    camtarget(ax,[cam_position(1),cam_position(1),VanishingPoint_3D(3)]);
    drawnow
    axis(ax,'equal')
    axis(ax,'vis3d','off')
end

