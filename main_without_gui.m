% main
clear;
clc;
close all;
%% inputs for test
addpath('img')

Img = imread("oil-painting.png");

% Img = imread("img\sagrada_familia.png");

[sz1,sz2]=size(Img);

% img size reduction, faster image processing
if any(sz1>3000 | sz2>3000)

    reduce_scal = 3200/max(sz1,sz2);

    Img = imresize(Img, reduce_scal,"Antialiasing",false);

end

n = 2;
%% Image Segmentation
% In this section, the foreground object is selected by the user using ROI.
% The background picture is patched using inpaintExampler function. Outputs
% are 2D coordinates of the foreground objects, foreground masks, and
% background image.

% backgound is a rgb image
% foreground is a cell including n foreground objects 2D image
% fg2D is a cell containing all the 2D coordinates of the corner points of
% n foreground objects

patchsize = 9;
fillorder = "gradient";
[fg2D,foreground,background] = ImageSegment(Img,n,patchsize,fillorder);
% convert fg2D cell into size(2,4*n)matrix.
fg2D = cell2mat(fg2D);
fg2D = reshape(fg2D,2,[]);

% if foreground representation is not needed, you can comment the following
% codes
% for i = 1:n
%     figure;
%     imshow(foreground{i});
% end

%% Spidery mesh
% This function is to create an interative tool to enable draggable inner
% rectangle, vanning point and radial lines. The position of end point of
% radial line will be updated while the inner rectangle or vanishing point
% changed. The position of vanishing point will also be updated when radial
% line is changing.


[OutterPoint,Updated_VanishingPoint,Updated_InnerRectangle] = spidery_mesh(background);
hold on


uiwait
%% Calculate 12 2D-Vertexes
% calculate 12 2D vertexes in the image
%  close the figure window to obtain 12 points matrix
%  size(TwelfPoints) = (2,12)

TwelfPoints_vp = gen12Points(Updated_VanishingPoint,Updated_InnerRectangle,OutterPoint);


%% add black outline
% To enable all the vertices visualized in the image, add black border for
% original image
% fill the missing parts that out of the view plane with black triangle

[Img_pad,origin_image_pad,new_TwelfPoints_vp,new_fg2D] = get_image_pad(background,Img,TwelfPoints_vp,fg2D);


%% plot 12 Vertices

% Img_pad = imread("input_image_pad.png");
% imshow(Img_pad)
% hold on

% plot_2D_background(new_TwelfPoints_vp,Updated_InnerRectangle)
% hold off

% uiwait
%% sperate 5 regions
% generate mask for each region and then get individual image of each wall

[leftwall, rearwall, rightwall, ceiling, floor] = image_matting(Img_pad, new_TwelfPoints_vp);

%% perspective transform: get rectangles of 5 walls
% In the view of trapeziform shape of each region, tilt correction should
% be executed to obtain rectangle for each wall
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
% In this section, the 3D coordinates of the twelf points and the vanishing
% point is generated using reverse perspective projection. The depth
% value of the points is magnified by a constant ration k.

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

%% foregroundobject 3D parameters calculation
% this function is used to get the 3D parameters of the foreground objects
% fg3D size(3,4*n)
% fg_polygon_function 1*n system,represents the foregroundobjects 3D planes
% fg_image 1*n cell,save the rgb matrix of each foregroundobject textures

[fg3D, fg_polygon_function,fg_image] = fg2Dto3D(n,origin_image_pad,new_TwelfPoints_vp,TwelfPoints_3D_xdirection_change,new_fg2D,patchsize,fillorder);


%% construct 3D room
% Take 3D coordinates of 12 vertices and foreground object as input, the surface of
% each wall and foreground object polygon can be plotted in 3D model of room

if sum(sum(sum(leftwall)))==0 || sum(sum(sum(rightwall)))==0
    construct_3D_room(TwelfPoints_3D,fg3D,n,fg_polygon_function,fg_image,rearwall_rec,floor_rec);
else
    construct_3D_room(TwelfPoints_3D,fg3D,n,fg_polygon_function,fg_image,leftwall_rec,rearwall_rec,rightwall_rec,ceiling_rec,floor_rec);
end


%% animation
% In this section, basic movements of the camera is defined, which are zoom
% in/zoom out/look up/look down/turn left/turn right. A tour animation
% using these 6 types of camera movements is generated for demonstration.

% initial settings
axis equal
axis vis3d off
v = [0,0,-1];
view(v);

% the initial point of the camera should not coincide with the vanishing
% point. It should be set to align with the center of the rear wall,
% otherwise the whole picture is going to have some offset.
center = [(TwelfPoints_3D(1,1)+TwelfPoints_3D(1,2))/2,(TwelfPoints_3D(2,1)+TwelfPoints_3D(2,7))/2];
x_bound = abs((TwelfPoints_3D(1,1)-TwelfPoints_3D(1,2))/2)*0.75;
y_bound = abs((TwelfPoints_3D(2,7)-TwelfPoints_3D(2,1))/2)*0.75;
z_lbound = min(TwelfPoints_3D(3,3),TwelfPoints_3D(3,5))/3;
z_rbound = VanishingPoint_3D(3)*0.5;
camproj('perspective');
camva('manual');
camva(90);
camup([0,-1,0]);

campos([center(1),center(2),z_lbound]);
camtarget([center(1),center(2),VanishingPoint_3D(3)]);
drawnow
% zoom in
for z = z_lbound:5:z_rbound
    campos([center(1),center(2),z])
    drawnow
    pause(.1)
    campos
end
% look up
for y = 0:5:y_bound
    campos([center(1),center(2)-y,z_rbound])
    drawnow
    pause(.1)
    campos
end
% look down
for y = y_bound:-5:0
    campos([center(1),center(2)-y,z_rbound])
    drawnow
    pause(.1)
    campos
end
% turn right
for x = 0:5:x_bound
    campos([center(1)-x,center(2),z_rbound])
    camtarget([center(1)-x,center(2),VanishingPoint_3D(3)])
    drawnow
    pause(.1)
    campos
end
% turn left
for x = x_bound:-5:-x_bound
    campos([center(1)-x,center(2),z_rbound])
    camtarget([center(1)-x,center(2),VanishingPoint_3D(3)])
    drawnow
    pause(.1)
    campos
end
% turn right to initial point
for x = -x_bound:5:0
    campos([center(1)-x,center(2),z_rbound])
    camtarget([center(1)-x,center(2),VanishingPoint_3D(3)])
    drawnow
    pause(.1)
    campos
end
%zoom out
for z = z_rbound:-5:z_lbound
    campos([center(1),center(2),z])
    drawnow
    pause(.1)
    campos
end

uiwait
