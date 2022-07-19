function [] = plot_polygon(polygon3Dpoint,polygon_function,textures)
% polygon3Dpoint: 4 points 3D value of foreground object
% polygon_function： f = A *x + B*y + C*z +D 
% textures : rgb matrix
 syms x y z 
 [Coe d] = equationsToMatrix(polygon_function,[x y z]);
 Coe = double(Coe);% get matrix[A B C]
 D = double(-d);% get D
 Coe = [Coe D];
 
 % C !=0，mesh X Y,and according to the plane function，get Z value
 if Coe(3) ~=0
    a = linspace(min(polygon3Dpoint(1,:)),max(polygon3Dpoint(1,:)),100);
    b = linspace(min(polygon3Dpoint(2,:)),max(polygon3Dpoint(2,:)),100);
    [X,Y] = meshgrid(a,b);
    Z = -Coe(1)/Coe(3).*X - Coe(2)/Coe(3).*Y -Coe(4)/Coe(3);
    
 else
     % C =0，A ！=0，mesh Z Y,and according to the plane function，get X value
    if Coe(1)~=0
         a = linspace(min(polygon3Dpoint(2,:)),max(polygon3Dpoint(2,:)),100);
         b = linspace(min(polygon3Dpoint(3,:)),max(polygon3Dpoint(3,:)),100);
         [Y,Z] = meshgrid(a,b);
         X = -Coe(2)/Coe(1).*Y + 0.*Z -Coe(4)/Coe(1);
    else 
        % C =0，A =0，B！=0，mesh Z X,and according to the plane function，get Y value
         a = linspace(min(polygon3Dpoint(1,:)),max(polygon3Dpoint(1,:)),100);
         b = linspace(min(polygon3Dpoint(3,:)),max(polygon3Dpoint(3,:)),100);
         [X,Z] = meshgrid(a,b);
         Y = 0.*X + 0.*Z -Coe(4)/Coe(2);
     end
 end

 warp(X,Y,Z,textures)

 hold on
    
end



