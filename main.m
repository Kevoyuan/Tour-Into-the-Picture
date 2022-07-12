% main
clear;

Img = imread("sagrada_familia.png");

[l1,l2,l3,l4,l5,l6,l7,l8,l9,l10,OutterPoint] = spidery_mesh(Img);
hold on


uiwait


%  close the figure window to obtain 12 points matrix
%  size(TwelfPoints) = (2,12)

TwelfPoints = gen12Points(Updated_VanishingPoint,Updated_InnerRectangle,OutterPoint);


[image_pad, new_Pixel_Vertex] = get_image_pad(Img, TwelfPoints);
%% foreground
[fg3D fg_polygon_function] = fg2Dto3D(n,image_pad,TwelfPoints);
% n is the number of the foregroundobjects
% fg3D size(3,4*n)
% fg_polygon_function n*1 system