function [Mfg3D f] = fg2Dto3D(n,gray_image,12point)
% gary_image : expanded image
% n :the number of the foregrounds object
Mfg2D = zeros(2,4*n);
Mfg3D = zeros(3,4*n);
attached_bg = cell(1,n);
syms f 
% f is the polygon function
f = zeros(n,1)
% the first loop n is the number of the foregroundobjects
for i = 1 :n
    % display("please choose the foregroundobject")
    imshow(gray_image)
    Mfg2D(:,4*i-3:4*i) = get_fg2D(gray_image);
    attached_bg{i} = verticalbg_of_fg(Mfg2D,12point);
    [Mfg3D(:,4*i-3:4*i) f(i)] = twoD2threeD(Mfg2D(:,4*i-3:4*i),attached_bg{i});% gai
    outH = max(Mfg3D(2,:))-min(Mfg3D(2,:));
    outW = max(Mfg3D(1,:))-min(Mfg3D(1,:));
    fg2Dimage = Perspective_transform(gray_image, Mfg2D(:,4*i)', Mfg2D(:,4*i-1)', Mfg2D(:,4*i-3)', Mfg2D(:,4*i-2)', outH, outW)
    imwrite(fg2Dimage,sprintf('fg%d.jpg',i));
    
    
    plot_fgpolygon(Mfg3D,f(i),sprintf('fg%d.jpg',i));
end
end

