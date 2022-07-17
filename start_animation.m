function start_animation(ax,VanishingPoint_3D)
    for z = 100:5:200
        campos(ax,[-100,0,z])
        drawnow
        pause(.1)
    end

    for y = 0:5:150
        campos(ax,[-100,-y,200])
        drawnow
        pause(.1)
    end
    for y = 150:-5:0
        campos(ax,[-100,-y,200])
        drawnow
        pause(.1)
    end

    for x = 0:5:100
        campos(ax,[-100-x,0,200])
        camtarget(ax,[-100-x,0,VanishingPoint_3D(3)])
        drawnow
        pause(.1)
    end

    for x = 100:-5:-100
        campos(ax,[-100-x,0,200])
        camtarget(ax,[-100-x,0,VanishingPoint_3D(3)])
        drawnow
        pause(.1)
    end

    for x = -100:5:0
        campos(ax,[-100-x,0,200])
        camtarget(ax,[-100-x,0,VanishingPoint_3D(3)])
        drawnow
        pause(.1)
    end

    for z = 200:-5:100
        campos(ax,[-100,0,z])
        drawnow
        pause(.1)
    end
end