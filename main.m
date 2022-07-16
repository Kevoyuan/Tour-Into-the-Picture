% main
clear;
clc;
close all;
%% inputs for test
addpath('img')
Img = imread("simple-room.png");

[sz1,sz2]=size(Img);

% img size reduction
if any(sz1>3200 | sz2>3200)

    reduce_scal = 3200/max(sz1,sz2);

    Img = imresize(Img, reduce_scal,"Antialiasing",false);

end

n = 1;
%% Image Segmentation
% backgound is a rgb image
% foreground is a cell including n foreground objects 2D image
% fg2D is a cell containing all the 2D coordinates of the corner points of
% n foreground objects
patchsize = 9;
fillorder = "gradient";
[fg2D_ir,foreground,background] = ImageSegment(Img,n,patchsize,fillorder);
fg2D = find_rectangular(fg2D_ir,n);
%fg2D = cell2mat(fg2D);
%fg2D = reshape(fg2D,2,[]);
% if foreground representation is not needed, you can comment the following
% codes
% for i = 1:n
%     figure;
%     imshow(foreground{i});
% end

%% Spidery mesh

[OutterPoint,Updated_VanishingPoint,Updated_InnerRectangle] = spidery_mesh(background);
hold on


uiwait
%% generate 12 points
%  close the figure window to obtain 12 points matrix
%  size(TwelfPoints) = (2,12)

TwelfPoints_vp = gen12Points(Updated_VanishingPoint,Updated_InnerRectangle,OutterPoint);


%% add black outline

[Img_pad,origin_image_pad,new_TwelfPoints_vp,new_fg2D] = get_image_pad(background,Img,TwelfPoints_vp,fg2D);
%[image_pad,new_TwelfPoints_vp,new_fg2D] = get_image_pad(background, TwelfPoints_vp,fg2D);
%[origin_image_pad,~,~] = get_image_pad(Img, TwelfPoints_vp,fg2D);

%% plot 12 points

% Img_pad = imread("input_image_pad.png");
% imshow(Img_pad)
% hold on

% plot_2D_background(new_TwelfPoints_vp,Updated_InnerRectangle)
% hold off

% uiwait
%% sperate 5 regions

[leftwall, rearwall, rightwall, ceiling, floor] = image_matting(Img_pad, new_TwelfPoints_vp);

%% perspective transform: get rectangles of 5 walls
P = new_TwelfPoints_vp;
outH = size(Img_pad,1);
outW = size(Img_pad,2);

%figure('Name', 'after perspective transformation', 'Position', [0, 0, 700, 400]);
%subplot(3, 3, 4);
if sum(sum(sum(leftwall)))==0
    
else
    leftwall_rec = Perspective_transform(leftwall, P(:,11)', P(:,7)', P(:,5)', P(:,1)', outH, outW);
end

%subplot(3, 3, 5);
rearwall_rec = Perspective_transform(rearwall, P(:,7)', P(:,8)', P(:,1)', P(:,2)', outH, outW);

%subplot(3, 3, 6);
if sum(sum(sum(rightwall)))==0
    
else
    rightwall_rec = Perspective_transform(rightwall, P(:,8)', P(:,12)', P(:,2)', P(:,6)', outH, outW);
end

%subplot(3, 3, 2);
if sum(sum(sum(ceiling)))==0
    
else
    ceiling_rec = Perspective_transform(ceiling, P(:,9)', P(:,10)', P(:,7)', P(:,8)', outH, outW);
end

%subplot(3, 3, 8);
floor_rec = Perspective_transform(floor, P(:,1)', P(:,2)', P(:,3)', P(:,4)', outH, outW);
%g = gcf;
%g.WindowState = "truesize";
%hold off

% uiwait

%% 3D box construction
% real implementation
k = 0.55 * sz1;

% the rear wall is red
% the ceiling is blue
% the floor is green
% the left wall is black
% the right wall is yellow

[TwelfPoints_3D,VanishingPoint_3D] = boxconstruction(new_TwelfPoints_vp,k);


% for testing, please run twelfPoints.m for simple extraction of 2D
% coordinatnions of the 12 Points
%twelfPoints = [P1',P2',P3',P4',P5',P6',P7',P8',P9',P10',P11',P12'];
%[twelfPoints_3D,vanishingpoint3d] = boxconstruction(vanishingpoint,twelfPoints);

TwelfPoints_3D_xdirection_change = [TwelfPoints_3D(:,2),TwelfPoints_3D(:,1),TwelfPoints_3D(:,4),TwelfPoints_3D(:,3),TwelfPoints_3D(:,6),...
    TwelfPoints_3D(:,5),TwelfPoints_3D(:,8),TwelfPoints_3D(:,7),TwelfPoints_3D(:,10),TwelfPoints_3D(:,9),TwelfPoints_3D(:,12),TwelfPoints_3D(:,11)];
%% foreground 3D coordinate and polygon function

% fg3D size(3,4*n)
% fg_polygon_function n*1 system
[fg3D, fg_polygon_function] = fg2Dto3D(n,origin_image_pad,new_TwelfPoints_vp,TwelfPoints_3D_xdirection_change,new_fg2D);


%% construct 3D room

if sum(sum(sum(leftwall)))==0 || sum(sum(sum(rightwall)))==0
    construct_3D_room(TwelfPoints_3D,fg3D,n,fg_polygon_function,rearwall_rec,floor_rec);
else
    construct_3D_room(TwelfPoints_3D,fg3D,n,fg_polygon_function,leftwall_rec,rearwall_rec,rightwall_rec,ceiling_rec,floor_rec);
end
 
% hold on ;
% for i =1 :n
%     plot_polygon(fg3D(:,4*i-3:4*i),fg_polygon_function(i),sprintf('fg%d.jpg',i));
%     hold on
% end

%% animation
camproj("perspective");
v = [0,0,-1];
view(v);
axis equal
%axis([-200,200,-200,200]);
% set(gca,'XAxisLocation','bottom');
% set(gca,'YAxisLocation','right');
xlim([-400,400]);
ylim([-400,400]);
camtarget(VanishingPoint_3D);
camup([0,-1,0]);

%zoom in
for z = 0:5:500
    campos([0,0,-z])
    drawnow
    pause(.05)
    campos
end
%look up
for y = 0:5:150
    campos([0,-y,-500])
    drawnow
    pause(.1)
    campos
end
%look down
for y = 0:5:150
    campos([0,y-150,-500])
    drawnow
    pause(.1)
    campos
end
%look right
for x = 0:5:150
    campos([-x,0,-500])
    drawnow
    pause(.1)
    campos
end
%look left
for x = 0:5:150
    campos([x-150,0,-500])
    drawnow
    pause(.1)
    campos
end
% zoom out
for z = 0:5:500
    campos([0,0,z-500])
    drawnow
    pause(.05)
    campos
end

uiwait
