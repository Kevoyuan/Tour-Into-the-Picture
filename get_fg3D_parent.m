function [fg3D  poly_f]= get_fg3D_parent(new_TwelfPoints_vp,focal_length,fg2D,atteched_bg,imgsize,d,k,Twelfpoints_3D)
% alle is the value in the expanded image
% vx vy vanishing point 2D value
% P1 point 1 2D value
% f focal length
% k the magnification factor >1
% d = (h*f/a) -f 
syms x y z poly_f fv
vanish_y = new_TwelfPoints_vp(2,13);
% vx = new_TwelfPoints_vp(1,13);
P1 = new_TwelfPoints_vp(:,1);
P3 = new_TwelfPoints_vp(:,3);
P2 = new_TwelfPoints_vp(:,2);
P6 = new_TwelfPoints_vp(:,6);
P1_3D = Twelfpoints_3D(:,1);
P8_3D = Twelfpoints_3D(:,8);
if strcmp(atteched_bg,'floor')
    fg3D(2,[1,2]) =P1_3D(2);
    fg3D(2,[3,4]) = k * fg2D(2,[3,4])-fg2D(2,[2,1])+P1_3D(2);% 等高放大
    %fg2D(2,[3,4])确认形式
    fg3D(3,[1,4]) =  d - ((imgsize(1)-fg2D(2,1))*focal_length/(fg2D(2,1)-vanish_y))+P1_3D(3);
    fg3D(3,[2,3]) = d - ((imgsize(1)-fg2D(2,2))*focal_length/(fg2D(2,2)-vanish_y))+P1_3D(3);% 相似三角形求景深
    fg3D(1,[1,2,3,4]) = k * (fg2D(1,[1,2,3,4])-P1(1))+P1_3D(1);% 与1点的x 距离成比例放大
    fv = 0*x + 1*y +0*z -P1_3D(2)
    poly_f= get_polygon_function(fg3D(:,1),fg3D(:,2),fv);
elseif strcmp(atteched_bg,'ceiling')
    fg3D(2,[3,4]) =P8_3D(2);
    fg3D(2,[1,2]) =P8_3D(2) - k * fg2D(2,[1,2])-fg2D(2,[4,3]);% 等高放大
    %fg2D(2,[3,4])确认形式
    fg3D(3,[1,4]) = d -( fg2D(2,4)*focal_length /(vanish_y-fg2D(2,4)))+P1_3D(3);
    fg3D(3,[2,3]) = d -( fg2D(2,3)*focal_length /(vanish_y-fg2D(2,3)))+P1_3D(3);% 相似三角形求景深
    fg3D(1,[1,2,3,4]) = k * (fg2D(1,[1,2,3,4])-P1(1))+P1_3D(1);% 与1点的x 距离成比例放大
    fv = 0 *x + 1*y +0*z -P8_3D(2);
    poly_f = get_polygon_function(fg3D(:,3),fg3D(:,4),fv);
elseif strcmp(atteched_bg,'leftwall')
    fg3D(1,[2,3]) =P8_3D(1);
    fg3D(1,[1,4]) = P8_3D(1) - k * fg2D(1,[2,3])-fg2D(1,[1,4]);
    yc2 = (P6(2) - P2(2))/(P6(1) - P2(1)) * fg2D(1,2) - ((P6(2) - P2(2))/(P6(1) - P2(1)))*P2(1) + P2(2);
    yc3 = (P6(2) - P2(2))/(P6(1) - P2(1)) * fg2D(1,3) - ((P6(2) - P2(2))/(P6(1) - P2(1)))*P2(1) + P2(2);
    fg3D(3,[1,2]) =  d - (imgsize(1)-yc2)*focal_length/(yc2-vanish_y)+P1_3D(3);
    fg3D(3,[3,4]) = d - (imgsize(1)-yc3)*focal_length/(yc3-vanish_y)+P1_3D(3);
    fg3D(2,1) = -k * (fg2D(2,1)-yc2)+P1_3D(3);
    fg3D(2,[2,3,4]) = fg3D(2,1) + k * (fg2D(2,[2,3,4])-fg2D(2,1));
    fv = 1 *x + 0*y +0*z -P8_3D(1);
    poly_f= get_polygon_function(fg3D(:,2),fg3D(:,3),fv );
elseif strcmp(atteched_bg,'rightwall')
    fg3D(1,[1,4]) =P1_3D(1);
    fg3D(1,[2,3]) =k * fg2D(1,[2,3])-fg2D(2,[1,4])+P1_3D(1);
    yc1 = (P1(2) - P3(2))/(P1(1) - P3(1)) * fg2D(1,1) - ((P1(2) - P3(2))/(P1(1) - P3(1)))*P3(1) + P3(2);
    yc4 = (P1(2) - P3(2))/(P1(1) - P3(1)) * fg2D(1,4) - ((P1(2) - P3(2))/(P1(1) - P3(1)))*P3(1) + P3(2);
    fg3D(3,[1,2]) = d - (imgsize(1)-yc1)*focal_length/(yc1-vanish_y)+P1_3D(3);
    fg3D(3,[3,4]) = d - (imgsize(1)-yc4)*focal_length/(yc4-vanish_y)+P1_3D(3);
    fg3D(2,1) = -k * (fg2D(2,1)-yc1)+P1_3D(2);
    fg3D(2,[2,3,4]) = fg3D(2,1) + k * (fg2D(2,[2,3,4])-fg2D(2,1));
    fv = 1 *x + 0*y +0*z -P1_3D(1);
    poly_f= get_polygon_function(fg3D(:,1),fg3D(:,4),fv );
end