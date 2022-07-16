function [] = plot_polygon(polygon3Dpoint,polygon_function,fgimg)
% 输入多边形3D顶点
% polygon_function形式： f = A *x + B*y + C*z +D 
% 或者能不能只输入系数[ A B C D]构成的矩阵
 syms x y z 
 [Coe d] = equationsToMatrix(polygon_function,[x y z]);
 Coe = double(Coe);% 得到x y z 前面的系数 1*3 矩阵
 D = double(-d);% 得到D 数值
 Coe = [Coe D];
 if Coe(3) ~=0
    a = linspace(min(polygon3Dpoint(1,:)),max(polygon3Dpoint(1,:)),100);
    b = linspace(min(polygon3Dpoint(2,:)),max(polygon3Dpoint(2,:)),100);
    [X,Y] = meshgrid(a,b);
    Z = -Coe(1)/Coe(3).*X - Coe(2)/Coe(3).*Y -Coe(4)/Coe(3);
    
 else
    if Coe(1)~=0
         a = linspace(min(polygon3Dpoint(2,:)),max(polygon3Dpoint(2,:)),100);
         b = linspace(min(polygon3Dpoint(3,:)),max(polygon3Dpoint(3,:)),100);
         [Y,Z] = meshgrid(a,b);
         X = -Coe(2)/Coe(1).*Y + 0.*Z -Coe(4)/Coe(1);
    else 
         a = linspace(min(polygon3Dpoint(1,:)),max(polygon3Dpoint(1,:)),100);
         b = linspace(min(polygon3Dpoint(3,:)),max(polygon3Dpoint(3,:)),100);
         [X,Z] = meshgrid(a,b);
         Y = 0.*X + 0.*Z -Coe(4)/Coe(2);
     end
 end
 textures = imread(fgimg);
 [I,map] = rgb2ind(textures,16);
 warp(X,Y,Z,I,map)
 hold on
    
end

%{
   调试

%}

