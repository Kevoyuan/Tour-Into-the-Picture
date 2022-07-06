function [] = plot_bgpolygon(polygon3Dpoint,textures)
% 该方程可以绘制3D背景，仅限于背景，因为利用了背景方程的特殊形式，背景方程都是形如 x = D，y=D，z=D
% 输入：该平面上4个点的3D 坐标构成的矩阵，形式：[x1 x2 x3 x4;y1 y2 y3 y4;z1 z2 z3 z4];纹理，一般图片保存形式

% 找到这4个3D点的相同的数，就是这个平面的参数值
intersect1 = intersect(polygon3Dpoint(:,1),polygon3Dpoint(:,2));
intersect2 = intersect(polygon3Dpoint(:,3),polygon3Dpoint(:,4));
same_pos= intersect(intersect1,intersect2);
% 找到这个数是在哪一行，对应 x y z 
logic = polygon3Dpoint == same_pos
logic_sum = sum(logic,2)
same_axis = find(logic_sum == 4)
%分类讨论，三种情况
% 情况一：4个点x 轴都相等，平面方程 形如 x = sam_pos
if same_axis ==1 
    % 100表示等分，数越大，网格越细
    a = linspace(min(polygon3Dpoint(2,:)),max(polygon3Dpoint(2,:)),100)
    b = linspace(min(polygon3Dpoint(3,:)),max(polygon3Dpoint(3,:)),100)
    [Y,Z] = meshgrid(a,b);
    X = 0.*Y + 0.*Z+same_pos;
    % 把纹理图片转换成索引图像，满足warp函数的输入
    [I,map] = rgb2ind(textures,32);
    % 将纹理附在平面上，不需要尺寸匹配
    warp(X,Y,Z,I,map)
    hold on
elseif same_axis==2
    a = linspace(min(polygon3Dpoint(1,:)),max(polygon3Dpoint(1,:)),100)
    b = linspace(min(polygon3Dpoint(3,:)),max(polygon3Dpoint(3,:)),100)
    [X,Z] = meshgrid(a,b);
    Y = 0.*X + 0.*Z + same_pos;
    [I,map] = rgb2ind(textures,32);
    warp(X,Y,Z,I,map)
    hold on
elseif  same_axis ==3
    a = linspace(min(polygon3Dpoint(1,:)),max(polygon3Dpoint(1,:)),100);
    b = linspace(min(polygon3Dpoint(2,:)),max(polygon3Dpoint(2,:)),100);
    [X,Y] = meshgrid(a,b);
    Z= 0.*X + 0.*Y + same_pos;
    [I,map] = rgb2ind(textures,32);
    warp(X,Y,Z,I,map)
    hold on
end
    
end

%{
   调试
   a = [0 5 0 5;0 0 0 0;0 0 8 8];
   syms x y z 
   f = 0*x + 1*y + 0*z +0;
   img = imread()
   plot_polygon(a,img)
%}
%{
    问题： 不知道warp是怎么附图像的，可能会出现，图形方向不对问题，如果不对，可不可以提前旋转好图片？
%}
