function [Mfg3D poly_f] = fg2Dto3D(n,gray_image,new_TwelfPoints_vp,Twelfpoints_3D,k,d)
% gary_image : expanded image
% n :the number of the foregrounds object
Mfg2D = zeros(2,4*n);
Mfg3D = zeros(3,4*n);
attached_bg = cell(1,n); 
imgsize = size(gray_image);
focal_length = 1
syms poly_f 
% f is the polygon function
% the first loop n is the number of the foregroundobjects
for i = 1 :n
    %{
    % GUI infomation
    fig = uifigure;
    message = {sprintf('please select the foregroundobject %d',i)};
    uialert(fig,message,'Info',...
    'Icon','info');
    % diplay the image and the user begin to choose the polygon
    %}
    figure
    imshow(gray_image)
    Mfg2D(:,4*i-3:4*i) = get_fg2D(gray_image)
    
    attached_bg{i} = verticalbg_of_fg(Mfg2D(:,4*i-3:4*i),new_TwelfPoints_vp);
    %{
    if strcmp(attached_bg{i},error)
        fig = uifigure;
        message = {sprintf('please reselect the foregroundobject %d ',i)};
        uialert(fig,message,'Warning',...
        'Icon','warning');
    else
    %}
        
        [Mfg3D(:,4*i-3:4*i)  poly_f(i)]= get_fg3D_parent(new_TwelfPoints_vp,focal_length,Mfg2D(:,4*i-3:4*i),attached_bg{i},imgsize,d,k,Twelfpoints_3D)
        outW = (max(Mfg3D(2,4*i-3:4*i))-min(Mfg3D(2,4*i-3:4*i)))/1000;
        outH = (max(Mfg3D(1,4*i-3:4*i))-min(Mfg3D(1,4*i-3:4*i)))/1000;
        fg2Dimage = Perspective_transform(gray_image, Mfg2D(:,4*i)', Mfg2D(:,4*i-1)', Mfg2D(:,4*i-3)', Mfg2D(:,4*i-2)', round(outH), round(outW));
        imwrite(fg2Dimage,sprintf('fg%d.jpg',i));
        
    % end
end

end
%{
    fig = uifigure;
    message = {sprintf('please choose the foregroundobject %d',i)};
    uialert(fig,message,'Info',...
    'Icon','info');
%}
