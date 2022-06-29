function polygon_function = get_polygon_function(P1,P2,vertical_surface)
% 已知平面上两个点3D坐标，和与之垂直的平面方程，求该平面方程
%假设垂直方程输入的形式是 （syms） f = Ax + By +Cz +D ；
syms x y z D pf 
% the normal vector of the basic background
 n_vsurface = equationsToMatrix(vertical_surface,[x y z])
%应该得到[A B C] 行向量
% the normal vector of the polygon
 n_psurface = cross(n_vsurface',P2-P1)
% assume the function of the polygon in general form
pf = n_psurface(1)*x + n_psurface(2)*y + n_psurface(3)*z + D
%P1 is on the polygon surface
pf_P1 =subs(pf,[x,y,z],P1')
sol_D = vpasolve(pf_P1)
%get the polygon function
polygon_function = subs(pf,D,sol_D)
end


%{
调试
syms x y z
f = 3*x + 10*y + 6*z +100;
P1 = [1 20 -50.5]'
P2 = [8 1 -22.3]'
get_polygon_function(P1,P2,f)
%}
