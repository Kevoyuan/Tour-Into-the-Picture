function [Mfg3D poly_f fg_image] = fg2Dto3D(n,origin_image,new_TwelfPoints_vp,Twelfpoints_3D,Mfg2D,patchsize,fillorder)
Mfg3D = zeros(3,4*n);
attached_bg = cell(1,n); 
syms poly_f 
% poly_f is the polygon function
i =1;
fg_image = cell(1,n);
while i < n+1 
    attached_bg{i} = verticalbg_of_fg(Mfg2D(:,4*i-3:4*i),new_TwelfPoints_vp,i);
    if strcmp(attached_bg{i},'error')
        [fg_reselect,~,~] = ImageSegment(origin_image,1,patchsize,fillorder);
        Mfg2D(:,4*i-3:4*i) = fg_reselect{1};
    else
        [Mfg3D(:,4*i-3:4*i)  poly_f(i)]= get_fg3D_parent(new_TwelfPoints_vp,Twelfpoints_3D,Mfg2D(:,4*i-3:4*i),attached_bg{i});
        outH = max(Mfg2D(2,4*i-3:4*i))-min(Mfg2D(2,4*i-3:4*i));
        outW = max(Mfg2D(1,4*i-3:4*i))-min(Mfg2D(1,4*i-3:4*i));
        fg_image{i} = Perspective_transform(origin_image, Mfg2D(:,4*i)', Mfg2D(:,4*i-1)', Mfg2D(:,4*i-3)', Mfg2D(:,4*i-2)', round(outH), round(outW));
        fg_image{i} = fliplr(fg_image{i});
        % imwrite(fg2Dimage,sprintf('fg%d.jpg',i));
        i = i +1;

end

end