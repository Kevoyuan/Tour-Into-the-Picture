function show3Droom(ax,cam_position,VanishingPoint_3D,TwelfPoints_3D)
    v = [0,0,-1];
    view(ax,v);
    camproj(ax,'perspective');
    camva(ax,'manual');
    camva(ax,90);
    camup(ax,[0,-1,0]);
    campos(ax,cam_position);
    camtarget(ax,[-100,0,VanishingPoint_3D(3)]);
    drawnow
    axis(ax,'equal')
    axis(ax,'vis3d','off')
    xlim(ax,[1.5*TwelfPoints_3D(1,1),1.5*TwelfPoints_3D(1,2)]);
    ylim(ax,[1.5*TwelfPoints_3D(2,7),1.5*TwelfPoints_3D(2,1)]);
end

