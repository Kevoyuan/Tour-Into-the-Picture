% main
clear;
clc;
close;
%% inputs for test
addpath('img')
Img = imread("simple-room.png");

% [m,n] = size(Img);
% vb = .5 * (m);
% va = .5 * (n);
% Updated_VanishingPoint = [va vb];
% Updated_InnerRectangle = [0.6 * va, 0.6 * vb, 0.5 * va + 0.2 * vb, 0.65 * va];

% n =1;
%% Spidery mesh

[l1, l2, l3, l4, l5, l6, l7, l8, l9, l10, OutterPoint] = spidery_mesh(Img);
hold on

uiwait
%% generate 12 points
%  close the figure window to obtain 12 points matrix
%  size(TwelfPoints) = (2,12)

TwelfPoints_vp = gen12Points(Updated_VanishingPoint, Updated_InnerRectangle, OutterPoint, Img);

%% add black outline

[image_pad, new_TwelfPoints_vp] = get_image_pad(Img, TwelfPoints_vp);

%% plot 12 points

Img_pad = imread("input_image_pad.png");
imshow(Img_pad)
hold on

plot_2D_background(new_TwelfPoints_vp, Updated_InnerRectangle)
hold off

%% 3D box construction
% real implementation
k = 0.55 * size(Img, 1);

% the rear wall is red
% the ceiling is blue
% the floor is green
% the left wall is black
% the right wall is yellow

[TwelfPoints_3D, VanishingPoint_3D] = boxconstruction(new_TwelfPoints_vp, k);

% for testing, please run twelfPoints.m for simple extraction of 2D
% coordinatnions of the 12 Points
%twelfPoints = [P1',P2',P3',P4',P5',P6',P7',P8',P9',P10',P11',P12'];
%[twelfPoints_3D,vanishingpoint3d] = boxconstruction(vanishingpoint,twelfPoints);

%% foreground
% [fg3D fg_polygon_function] = fg2Dto3D(n,image_pad,TwelfPoints);
% n is the number of the foregroundobjects
% fg3D size(3,4*n)
% fg_polygon_function n*1 system
