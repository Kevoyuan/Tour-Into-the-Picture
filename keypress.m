function camera_position = keypress(ax,key)
    if strcmp(key,'leftarrow')
     camorbit(ax,2,0,'camera')
     camera_position = campos;
    end
    if strcmp(key,'rightarrow')
     camorbit(ax,-2,0,'camera')
     camera_position = campos;
    end
    if strcmp(key,'uparrow')
     camorbit(ax,0,2,'camera')
     camera_position = campos;
    end
    if strcmp(key,'downarrow')
     camorbit(ax,0,-2,'camera')
     camera_position = campos;
    end
end