function [Mfg3D f] = fg2Dto3D(n,gray_image,new_TwelfPoints_vp)
% gary_image : expanded image
% n :the number of the foregrounds object
Mfg2D = zeros(2,4*n);
Mfg3D = zeros(3,4*n);
attached_bg = cell(1,n);
imgsize = size(Img_pad)
vy = new_TwelfPoints_vp(2,13);
vx = new_TwelfPoints_vp(1,13);
P1 = new_TwelfPoints_vp(:,1);
P3 = new_TwelfPoints_vp(:,3);
P2 = new_TwelfPoints_vp(:,2);
P6 = new_TwelfPoints_vp(:,6);
syms f 
% f is the polygon function
f = zeros(n,1)
% the first loop n is the number of the foregroundobjects
for i = 1 :n
    % GUI infomation
    fig = uifigure;
    message = {sprintf('please select the foregroundobject %d',i)};
    uialert(fig,message,'Info',...
    'Icon','info');
    % diplay the image and the user begin to choose the polygon  
    imshow(gray_image)
    Mfg2D(:,4*i-3:4*i) = get_fg2D(gray_image);
    attached_bg{i} = verticalbg_of_fg(Mfg2D(:,4*i-3:4*i),12point);
    if strcmp(attached_bg{i},error)
        fig = uifigure;
        message = {sprintf('please reselect the foregroundobject %d ',i)};
        uialert(fig,message,'Warning',...
        'Icon','warning');
    else
        
        [Mfg3D(:,4*i-3:4*i)  f(i)]= get_fg3D_parent(vy,vx,P1,P3,P6 P2,f,Mfg2D(:,4*i-3:4*i),attached_bg{i},imgsize,d,k,innerh,innerw)
        % 缺 d k 
        outH = max(Mfg3D(2,4*i-3:4*i))-min(Mfg3D(2,4*i-3:4*i));
        outW = max(Mfg3D(1,4*i-3:4*i))-min(Mfg3D(1,4*i-3:4*i));
        fg2Dimage = Perspective_transform(gray_image, Mfg2D(:,4*i)', Mfg2D(:,4*i-1)', Mfg2D(:,4*i-3)', Mfg2D(:,4*i-2)', outH, outW);
        imwrite(fg2Dimage,sprintf('fg%d.jpg',i));
        plot_polygon(Mfg3D,f(i),sprintf('fg%d.jpg',i));
    end
end

end
%{
    fig = uifigure;
    message = {sprintf('please choose the foregroundobject %d',i)};
    uialert(fig,message,'Info',...
    'Icon','info');
%}
