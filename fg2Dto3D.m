function [Mfg3D poly_f Mfg2D] = fg2Dto3D(n,origin_image,new_TwelfPoints_vp,Twelfpoints_3D,Mfg2D)
Mfg3D = zeros(3,4*n);
attached_bg = cell(1,n); 
focal_length = 1
syms poly_f 
% poly_f is the polygon function
for i = 1 :n
    attached_bg{i} = verticalbg_of_fg(Mfg2D(:,4*i-3:4*i),new_TwelfPoints_vp);
    [Mfg3D(:,4*i-3:4*i)  poly_f(i)]= get_fg3D_parent(new_TwelfPoints_vp,Twelfpoints_3D,Mfg2D(:,4*i-3:4*i),attached_bg{i});
    outW = max(Mfg2D(2,4*i-3:4*i))-min(Mfg2D(2,4*i-3:4*i));
    outH = max(Mfg2D(1,4*i-3:4*i))-min(Mfg2D(1,4*i-3:4*i));
    fg2Dimage = Perspective_transform(origin_image, Mfg2D(:,4*i)', Mfg2D(:,4*i-1)', Mfg2D(:,4*i-3)', Mfg2D(:,4*i-2)', round(outH), round(outW));
    imwrite(fg2Dimage,sprintf('fg%d.jpg',i));

end

end
 %{
    % GUI infomation
    fig = uifigure;
    message = {sprintf('please select the foregroundobject %d',i)};
    uialert(fig,message,'Info',...
    'Icon','info');
    % diplay the image and the user begin to choose the polygon
    %}

    %{
    if strcmp(attached_bg{i},error)
        fig = uifigure;
        message = {sprintf('please reselect the foregroundobject %d ',i)};
        uialert(fig,message,'Warning',...
        'Icon','warning');
    else
    %}
