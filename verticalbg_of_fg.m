function attached_bg = verticalbg_of_fg(Mfg2D,12point)
% this function is used to judge,to which one of the five 3D regions of the 3D background is the foreground orthogonally attached 
% Mfg2D contains the 2D coordinate of the 4 points of the polygon, M1 = [x1 x2 x3 x4;y1 y2 y3 y4]

fxv = 12point(1,[1,2,3,4])';
fyv = 12point(2,[1,2,3,4])';
cxv = 12point(1,[7,8,9,10])';
cyv = 12point(2,[7,8,9,10])';
lxv = 12point(1,[1,7,5,11])';
lyv = 12point(2,[1,7,5,11])';
rxv = 12point(1,[2,6,8,12])';
ryv = 12point(2,[2,6,8,12])';

xq = Mfg2D(1,:)';
yq = Mfg2D(2,:)';

[inf,onf] = inpolygon(xq,yq,fxv,fyv);
floor_sum = numel(xq(inf)) + numel(xq(onf));
if floor_sum >=2
    attached_bg = 'floor';
    return;
else 
    [inc,onc] = inpolygon(xq,yq,cxv,cyv);
    ceil_sum = numel(xq(inc)) + numel(xq(onc));
    if ceil_sum >=2
        attached_bg = 'ceiling';
        return;
    else 
        [inl,onl] = inpolygon(xq,yq,lxv,lyv);
        left_sum = numel(xq(inl)) + numel(xq(onl));
        if left_sum >=2
               attached_bg = 'leftwall';
               return;
        else
            [inr,onr] = inpolygon(xq,yq,rxv,ryv);
            right_sum = numel(xq(inr)) + numel(xq(onr));
           if right_sum >=2
                attached_bg = 'rightwall';
                return;
           else
               attached_bg = 'error';
           end
        end
    end
end

end

