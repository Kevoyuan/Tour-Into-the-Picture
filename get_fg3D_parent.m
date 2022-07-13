function [fg3D  f]= get_fg3D_parent(vy,vx,P1,P3,P6 P2,f,fg2D,atteched_bg,imgsize,d,k,innerh,innerw)
% alle is the value in the expanded image
% vx vy vanishing point 2D value
% P1 point 1 2D value
% f focal length
% k the magnification factor >1
% d = (h*f/a) -f 
if strcmp(atteched_bg,'floor')
    fg3D(2,[1,2]) =0;
    fg3D(2,[3,4]) = k * fg2D(2,[3,4])-fg2D(2,[2,1]);% 等高放大
    %fg2D(2,[3,4])确认形式
    fg3D(3,[1,4]) =  d - (imgsize(1)-fg2D(2,1))*f/(fg2D(2,1)-vy);
    fg3D(3,[2,3]) = d - (imgsize(1)-fg2D(2,2))*f/(fg2D(2,2)-vy);% 相似三角形求景深
    fg3D(1,[1,2,3,4]) = k * (fg2D(1,[1,2,3,4])-P1(1))+P1_3D(1);% 与1点的x 距离成比例放大
    f= get_polygon_function(fg3D(:,1),fg3D(:,2),fv = 0 *x + 1*y +0*z + 0);
elseif strcmp(atteched_bg,'ceiling')
    fg3D(2,[3,4]) =innerh;
    fg3D(2,[1,2]) =innerh - k * fg2D(2,[1,2])-fg2D(2,[4,3]);% 等高放大
    %fg2D(2,[3,4])确认形式
    fg3D(3,[1,4]) = d -( fg2D(2,4)*f /(vy-fg2D(2,4)));
    fg3D(3,[2,3]) = d -( fg2D(2,3)*f /(vy-fg2D(2,3)));% 相似三角形求景深
    fg3D(1,[1,2,3,4]) = k * (fg2D(1,[1,2,3,4])-P1(1))+P1_3D(1);% 与1点的x 距离成比例放大
    f= get_polygon_function(fg3D(:,1),fg3D(:,2),fv = 0 *x + 1*y +0*z -innerh);
elseif strcmp(atteched_bg,'leftwall')
    fg3D(1,[2,3]) =innerw;
    fg3D(1,[1,4]) = innerw - k * fg2D(1,[2,3])-fg2D(2,[1,4]);
    yc2 = (P6(2) - P2(2))/(P6(1) - P2(1)) * fg2D(1,2) - ((P6(2) - P2(2))/(P6(1) - P2(1)))*P2(1) + P2(2);
    yc3 = (P6(2) - P2(2))/(P6(1) - P2(1)) * fg2D(1,3) - ((P6(2) - P2(2))/(P6(1) - P2(1)))*P2(1) + P2(2);
    fg3D(3,[1,2]) = compute_Z(yc2);
    fg3D(3,[3,4]) = compute_Z(yc3);
    fg3D(2,1) = -k * (fg2D(2,1)-yc2);
    fg3D(2,[2,3,4]) = fg3D(2,1) + k * (fg2D(2,[2,3,4])-fg2D(2,1));
    f= get_polygon_function(fg3D(:,1),fg3D(:,2),fv = 1 *x + 0*y +0*z -innerw);
elseif strcmp(atteched_bg,'rightwall')
    fg3D(1,[1,4]) =0;
    fg3D(1,[2,3]) =k * fg2D(1,[2,3])-fg2D(2,[1,4]);
    yc1 = (P1(2) - P3(2))/(P1(1) - P3(1)) * fg2D(1,1) - ((P1(2) - P3(2))/(P1(1) - P3(1)))*P3(1) + P3(2);
    yc4 = (P1(2) - P3(2))/(P1(1) - P3(1)) * fg2D(1,4) - ((P1(2) - P3(2))/(P1(1) - P3(1)))*P3(1) + P3(2);
    fg3D(3,[1,2]) = compute_Z(yc1);
    fg3D(3,[3,4]) = compute_Z(yc4);
    fg3D(2,1) = -k * (fg2D(2,1)-yc1)
    fg3D(2,[2,3,4]) = fg3D(2,1) + k * (fg2D(2,[2,3,4])-fg2D(2,1));
    f= get_polygon_function(fg3D(:,1),fg3D(:,2),fv = 1 *x + 0*y +0*z -0);
end



