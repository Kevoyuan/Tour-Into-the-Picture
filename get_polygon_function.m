function polygon_function = get_polygon_function(P1,P2,vertical_surface)
% P1 P2  ： points of intersection of two perpendicular planes
%vertical_surface: （syms） f = Ax + By +Cz +D ；
syms x y z D pf 
% the normal vector of the basic background
 n_vsurface = equationsToMatrix(vertical_surface,[x y z]);

% the normal vector of the polygon
 n_psurface = cross(n_vsurface',P2-P1);
 
% assume the function of the polygon in general form
pf = n_psurface(1)*x + n_psurface(2)*y + n_psurface(3)*z + D;

%P1 is on the polygon surface,solve D
pf_P1 =subs(pf,[x,y,z],P1');
sol_D = vpasolve(pf_P1);

%get the polygon function
polygon_function = subs(pf,D,sol_D);
end


