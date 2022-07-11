function P_image_mat = get_image_mat(image)
% 用户画多边形，自动生�?点�??标
% P_image_mat 是图片上四边形顶点构�?的矩阵
I = imread(image);
figure
imshow(I)
p = drawpolygon('LineWidth',7,'Color','cyan')
X = p.Position;
%{
X = X';
P_iamge_mat = zeros(size(X));
% 排�?，使矩阵按照四边形P1 P2 P3 P4 的顺�?排列
[B I] = sort(X(1,:));
if X(2,I(1)) > X(2,I(2))
    P_iamge_mat(:,1) = X(:,I(1));
    P_iamge_mat(:,4) = X(:,I(2));
else 
    P_iamge_mat(:,1) = X(:,I(2));
    P_iamge_mat(:,4) = X(:,I(1));
end

if X(2,I(3)) > X(2,I(4))
    P_iamge_mat(:,2) = X(:,I(3));
    P_iamge_mat(:,3) = X(:,I(4));
else 
    P_iamge_mat(:,2) = X(:,I(4));
    P_iamge_mat(:,3) = X(:,I(3));
end
%}
end