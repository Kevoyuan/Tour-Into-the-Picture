a = magic(8);
imagesc(a);
b = drawpolygon;

%draw polygon in the figure;

 %this listener I have added to listen whenever we move ROI

l = addlistener(b,'MovingROI',@(src,evt)clickCallback(src,evt,b,a));

function clickCallback(src,evt,b,a)

c = createMask(b);
cc = c.*a;
d = sum(cc,[1,2]);
disp(d); %displaying the values of d

end