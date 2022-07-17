function keypress(ax,key)
    if strcmp(key,'leftarrow')
     camorbit(ax,10,0,'camera')   
    end
    if strcmp(key,'rightarrow')
     camorbit(ax,-10,0,'camera')   
    end
    if strcmp(key,'uparrow')
     camorbit(ax,0,10,'camera')   
    end
    if strcmp(key,'downarrow')
     camorbit(ax,0,-10,'camera')   
    end
end