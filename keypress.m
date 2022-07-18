function keypress(ax,key)
    if strcmp(key,'leftarrow')
     camorbit(ax,5,0,'camera')   
    end
    if strcmp(key,'rightarrow')
     camorbit(ax,-5,0,'camera')   
    end
    if strcmp(key,'uparrow')
     camorbit(ax,0,5,'camera')   
    end
    if strcmp(key,'downarrow')
     camorbit(ax,0,-5,'camera')   
    end
end