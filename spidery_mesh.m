clc;
clear;
close


Image2 = imread('shopping-mall.png');
IGray2 = rgb_to_gray(Image2);
figure;
imshow(Image2);

hold on

% get the size of the img
[m,n]=size(IGray2);


% Draw vanishing point
% initial VanishingPoint(middle of the Picture)

vb= .5 * (m);
va =.5 * (n);

% plot(va, vb,'r*')
pos_VanishingPoint = [va vb];
roi_VanishingPoint = images.roi.Point(gca,'Position',pos_VanishingPoint,"Color",'k',"LineWidth",5);
hold on
% Draw inner rectangle


% [x y w h]= x and y elements determine the location (top-left) and the w and h elements determine the size
pos_InnerRectangle = [va-250,vb-250,500,500];
roi_InnerRectangle = drawrectangle('Color','k','FaceAlpha', 0, ...
    'FaceSelectable',(false),'LineWidth',1);
roi_InnerRectangle.Position = pos_InnerRectangle

% Draw 4 radial lines
% 1. 4 edges of inner rectangle
% 
% r_top_left = [pos_InnerRectangle(1), pos_InnerRectangle(2)];
% r_top_right = [pos_InnerRectangle(1) + pos_InnerRectangle(3), pos_InnerRectangle(2)];
% r_bottom_left = [pos_InnerRectangle(1), pos_InnerRectangle(2)+pos_InnerRectangle(4)];
% r_botton_right = [pos_InnerRectangle(1)+pos_InnerRectangle(3), pos_InnerRectangle(2)+pos_InnerRectangle(4)];


% roi_line1 = drawline('Position',[r_top_left;pos_VanishingPoint],'Color','r');
% roi_line2 = drawline('Position',[r_top_right;pos_VanishingPoint],'Color','r');
% roi_line3 = drawline('Position',[r_bottom_left;pos_VanishingPoint],'Color','r');
% roi_line4 = drawline('Position',[r_botton_right;pos_VanishingPoint],'Color','r');
% Get Positions of vanishing point & inner rectangle
% 1. position of vanishing point

% addlistener(roi_VanishingPoint,'MovingROI',@(src, evt) roiChange(src,evt,'Updated_VanishingPoint'));
%% 
% 2. position of inner rectangle

% addlistener(roi_InnerRectangle,'MovingROI',@(src, evt) roiChange(src,evt,'Updated_InnerRectangle'));
%% 
% updated vertices of inner rectangle

% Updated_InnerRectangle = 'Updated_InnerRectangle.mat';
% save(Updated_InnerRectangle)
% load Updated_InnerRectangle.mat
% 
% 
% updated_top_left = [Updated_InnerRectangle(1), Updated_InnerRectangle(2)]
% updated_top_right = [Updated_InnerRectangle(1) + Updated_InnerRectangle(3), Updated_InnerRectangle(2)]
% updated_bottom_left = [Updated_InnerRectangle(1), Updated_InnerRectangle(2)+Updated_InnerRectangle(4)]
% updated_botton_right = [Updated_InnerRectangle(1)+Updated_InnerRectangle(3), Updated_InnerRectangle(2)+Updated_InnerRectangle(4)]
% 
% 
% roi_InnerRectangle.Position

updated_top_left = [roi_InnerRectangle.Position(1), roi_InnerRectangle.Position(2)]
updated_top_right = [roi_InnerRectangle.Position(1) + roi_InnerRectangle.Position(3), roi_InnerRectangle.Position(2)]
updated_bottom_left = [roi_InnerRectangle.Position(1), roi_InnerRectangle.Position(2)+roi_InnerRectangle.Position(4)]
updated_botton_right = [roi_InnerRectangle.Position(1)+roi_InnerRectangle.Position(3), roi_InnerRectangle.Position(2)+roi_InnerRectangle.Position(4)]
%% 
% updated position of vanishing point

% Updated_VanishingPoint = 'Updated_VanishingPoint.mat';
% save(Updated_VanishingPoint)
% 
% V = roi_VanishingPoint.Position;

% h = drawline('Position',[500 500;500 1500],'Color','r');

% 
% radialline_left(V,updated_top_left,Image2);
% radialline_left(V,updated_bottom_left,Image2);
% 
% radialline_right(V,updated_top_right,Image2);
% radialline_right(V,updated_botton_right,Image2);

l1 = addlistener(roi_VanishingPoint,'MovingROI',@(src, evt) radialline(src,evt,roi_InnerRectangle,Image2));




%% 
% live updatable radial line

function radialline(src, evt,rect,img)

% l1=addlistener(rect,'MovingROI',@(src, evt) radialline(src,evt,roi_InnerRectangle,Image2));

rect_top_left = [rect.Position(1), rect.Position(2)];
rect_top_right = [rect.Position(1) + rect.Position(3), rect.Position(2)];
rect_bottom_left = [rect.Position(1), rect.Position(2)+rect.Position(4)];
rect_botton_right = [rect.Position(1)+rect.Position(3), rect.Position(2)+rect.Position(4)];

EdgePoint = {rect_top_left,rect_top_right,rect_bottom_left,rect_botton_right};

l2 = findall(gcf,'Type', 'Line'); 

delete(l2); 
% get current vanishing point position
C = evt.CurrentPosition;

lines = zeros(1,4);
for x = 1:4
    ThroPoint = EdgePoint{x};
    aLine = TwoPointLine(C, ThroPoint);
    % get border point coordinates
    points = lineToBorderPoints(aLine,size(img));
    
    lines(x) = line(points(:,[1,3])',points(:,[2,4])','Color', 'r', 'LineWidth', 2);
    uistack(lines(x),'down',2);    
%     uistack(roi_VanishingPoint,"top")
end



end


function aLine = TwoPointLine(C, ThroPoint)
% coefficients = polyfit([x1 x2], [y1 y2], 1);
coefficients = polyfit([C(1) ThroPoint(1)], [C(2) ThroPoint(2)], 1);
a = coefficients (1);
b = coefficients (2);
% Define a line with the equation, a * x + y + b = 0.
aLine = [a,-1,b];

end

function rect_pos(src, evt)
R=evt.CurrentPosition;


end