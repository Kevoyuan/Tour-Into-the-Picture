function [Mfg3D poly_f] = fg2Dto3D(n,origin_image,new_TwelfPoints_vp,Twelfpoints_3D,Mfg2D)
Mfg3D = zeros(3,4*n);
attached_bg = cell(1,n); 
syms poly_f 
% poly_f is the polygon function
for i = 1 :n
    attached_bg{i} = verticalbg_of_fg(Mfg2D(:,4*i-3:4*i),new_TwelfPoints_vp);
    [Mfg3D(:,4*i-3:4*i)  poly_f(i)]= get_fg3D_parent(new_TwelfPoints_vp,Twelfpoints_3D,Mfg2D(:,4*i-3:4*i),attached_bg{i});
    outW = max(Mfg2D(2,4*i-3:4*i))-min(Mfg2D(2,4*i-3:4*i));
    outH = max(Mfg2D(1,4*i-3:4*i))-min(Mfg2D(1,4*i-3:4*i));
    fg2Dimage = Perspective_transform(origin_image, Mfg2D(:,4*i)', Mfg2D(:,4*i-1)', Mfg2D(:,4*i-3)', Mfg2D(:,4*i-2)', round(outH), round(outW));
    fg2Dimage = fliplr(fg2Dimage);
    imwrite(fg2Dimage,sprintf('fg%d.jpg',i));

end

end
