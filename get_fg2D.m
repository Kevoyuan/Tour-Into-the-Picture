function Mfg = get_fg2D(gray_image)
gray_image = double(gray_image);
p = drawpolygon('LineWidth',7,'Color','cyan')
X = p.Position;
X = X';
Mfg = zeros(size(X));
[B I] = sort(X(1,:));
if X(2,I(1)) > X(2,I(2))
    Mfg(:,1) = X(:,I(1));
    Mfg(:,4) = X(:,I(2));
else 
    Mfg(:,1) = X(:,I(2));
    Mfg(:,4) = X(:,I(1));
end

if X(2,I(3)) > X(2,I(4))
    Mfg(:,2) = X(:,I(3));
    Mfg(:,3) = X(:,I(4));
else 
    Mfg(:,2) = X(:,I(4));
    Mfg(:,3) = X(:,I(3));
end

end

