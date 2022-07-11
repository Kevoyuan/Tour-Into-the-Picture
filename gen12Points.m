
xrange = xlim;
yrange = ylim;

% draw vanishing point
% ROI_1 = drawpoint();
% vanishingpoint = ROI_1.Position;
%
% % draw inner rectangular
% ROI_2 = drawrectangle();
rect_pos = Updated_InnerRectangle;
vp = Updated_VanishingPoint;
% calculate the 11 points
% rear wall
Point7 =  [rect_pos(1),rect_pos(2)];
Point8 =  [rect_pos(1) + rect_pos(3),rect_pos(2)];
Point1 =  [rect_pos(1),rect_pos(2) + rect_pos(4)];
Point2 =  [rect_pos(1) + rect_pos(3),rect_pos(2) + rect_pos(4)];


% ceiling
[k_v7,b_v7] = lineequation(vp,Point7);
Point9 = P9.Position;


[k_v8,b_v8] = lineequation(vp,Point8);
Point10 = [-b_v8/k_v8,yrange(1)];



% floor

Point3 = P3.Position;


[k_v2,b_v2] = lineequation(vanishingpoint,Point2);
Point4 = P4.Position;


% left wall
Point11 = [xrange(1),b_v7];
plot(Point11(1),Point11(2),'*','Color','r');
hold on;

Point5 = [xrange(1),b_v1];
plot(Point5(1),Point5(2),'*','Color','r');
hold on;

% right wall
Point12 = [xrange(2),k_v8*xrange(2)+b_v8];
plot(Point12(1),Point12(2),'*','Color','r');
hold on;

Point4= [xrange(2),k_v2*xrange(2)+b_v2];
plot(Point4(1),Point4(2),'*','Color','r');
hold on;

function [k,b] = lineequation(Point1,Point2)
if Point2(1) == Point1(1)
    k = 0;
else
    k = (Point2(2) - Point1(2))/(Point2(1) - Point1(1));
end
b = Point2(2) - Point2(1) * k;
end