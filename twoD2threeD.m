function P3_hom = twoD2threeD(u_v,v_v,u,v)
% [u_v,v_v] is the pixel coordination of the vanishing point
% where u_v represents x coordinate, v_v is represents the y coordinate

sx = 1;
sy = 1;
stheta = 0;
ox = u_v;
oy = v_v;

% Sensor parameter matrix
Ks = [sx,stheta,ox;0,sy,oy;0,0,1];

% Perspective projection matrix
f = 1;
Kf = [f,0,0;0,f,0;0,0,1];

% intrinsic matrix
K = Ks*Kf;

P3_hom =K\[u,v,1]';
end