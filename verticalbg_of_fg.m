function [attached_bg] = verticalbg_of_fg(Mfg2D,Twelfpoint,i)
% this function is used to judge,to which one of the five 3D regions of the 3D background is the foreground orthogonally attached 
% Mfg2D contains the 2D coordinate of the 4 points of the polygon, M1 = [x1 x2 x3 x4;y1 y2 y3 y4]
% i:the nummer of the foreground (first,second,third and so on)

% define the 5 regions of the background
fxv = Twelfpoint(2,[1,3,4,2]);
fyv = Twelfpoint(1,[1,3,4,2]);
cxv = Twelfpoint(2,[7,8,10,9]);
cyv = Twelfpoint(1,[7,8,10,9]);
lxv = Twelfpoint(2,[1,5,11,7]);
lyv = Twelfpoint(1,[1,5,11,7]);
rxv = Twelfpoint(2,[2,6,12,8]);
ryv = Twelfpoint(1,[2,6,12,8]);

xq = Mfg2D(2,:);
yq = Mfg2D(1,:);

% at least two points belong to 'xxx' region,then the object is attached to 'xxx'.
% xxx :floor or ceiling or leftwall or rightwall

[inf,onf] = inpolygon(xq,yq,fxv,fyv);
floor_sum = numel(xq(inf));
if floor_sum >=2
    attached_bg = 'floor';
    return;
else 
    [inc,onc] = inpolygon(xq,yq,cxv,cyv);
    ceil_sum = numel(xq(inc));
    if ceil_sum >=2
        attached_bg = 'ceiling';
        return;
    else 
        [inl,onl] = inpolygon(xq,yq,lxv,lyv);
        left_sum = numel(xq(inl));
        if left_sum >=2
               attached_bg = 'leftwall';
               return;
        else
            [inr,onr] = inpolygon(xq,yq,rxv,ryv);
            right_sum = numel(xq(inr));
           if right_sum >=2
                attached_bg = 'rightwall';
                return;
           else
               % if none of the above condition is satisfied ,we send warning signal.
               attached_bg = 'error';
               f = warndlg(sprintf('Please reselect the foregroundobject %d',i),'Warning');

           end
        end
    end
end



end

