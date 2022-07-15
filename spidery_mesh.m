function [l1, l2, l3, l4, l5, l6, l7, l8, l9, l10, OutterPoint, Updated_VanishingPoint, Updated_InnerRectangle] = spidery_mesh(Img)
% addpath('img')
% Image2 = imread("simple-room.png");

IGray2 = rgb_to_gray(Img);
h = figure('Name', 'Spidery Mesh', 'Position', [0, 0, 700, 400]);
imshow(Img);

hold on
%%
% get the size of the img
global m;
global n;

[m, n] = size(IGray2);

% Draw vanishing point
% initial VanishingPoint(middle of the Picture)

vb = .5 * (m);
va = .5 * (n);

% plot(va, vb,'r*')
pos_VanishingPoint = [va vb];
roi_VanishingPoint = drawpoint(gca, 'Position', pos_VanishingPoint, "Color", 'k', "LineWidth", 5);
% hold on
% Draw inner rectangle

% [x y w h]= x and y elements determine the location (top-left) and the w and h elements determine the size
pos_InnerRectangle = [0.6 * va, 0.6 * vb, 0.5 * va + 0.2 * vb, 0.65 * va];
roi_InnerRectangle = drawrectangle('Color', 'r', 'FaceAlpha', 0, ...
    'FaceSelectable', (false), 'LineWidth', 2);
roi_InnerRectangle.Position = pos_InnerRectangle;

% initial updated position
Updated_VanishingPoint = pos_VanishingPoint;
Updated_InnerRectangle = pos_InnerRectangle;
%%
% *Draw 4 radial lines*

l1 = addlistener(roi_VanishingPoint, 'MovingROI', @(src, evt) radialline_vp(src, evt, roi_VanishingPoint, roi_InnerRectangle, IGray2));
l2 = addlistener(roi_InnerRectangle, 'MovingROI', @(src, evt) radialline_ir(src, evt, roi_VanishingPoint, roi_InnerRectangle, IGray2));

% get the position of Vanishing Poit(VP) and Inner Rectangle(IR),

l3 = addlistener(roi_InnerRectangle, 'ROIMoved', @(src, evt) roiChange(src, evt, 'Updated_InnerRectangle'));
l4 = addlistener(roi_VanishingPoint, 'ROIMoved', @(src, evt) roiChange(src, evt, 'Updated_VanishingPoint'));

% initial P

OutterPoint = [0.5, 0.5; m + 0.5, 0.5; 0.5, m + 0.5; n + 0.5, m + 0.5];

% P9, P10, P3, P4
P9 = images.roi.Point(gca, "MarkerSize", 1);

% P9.Position = P(1, :);
P10 = images.roi.Point(gca, "MarkerSize", 1);
% P10.Position = P(2, :);
P3 = images.roi.Point(gca, "MarkerSize", 1);
% P3.Position = P(3, :);
P4 = images.roi.Point(gca, "MarkerSize", 1);
% P4.Position = P(4, :);

l5 = addlistener(roi_InnerRectangle, 'ROIMoved', @(r1, evt) BorderPointEvent(roi_InnerRectangle, evt, P9, P10, P3, P4));
l6 = addlistener(roi_VanishingPoint, 'ROIMoved', @(r1, evt) BorderPointEvent(roi_VanishingPoint, evt, P9, P10, P3, P4));

l7 = addlistener(P9, 'MovingROI', @(r1, evt) P9NewVP(P9, evt, P3, P10, P4, roi_InnerRectangle, roi_VanishingPoint, IGray2));
l8 = addlistener(P3, 'MovingROI', @(r1, evt) P3NewVP(P3, evt, P9, P10, P4, roi_InnerRectangle, roi_VanishingPoint, IGray2));
l9 = addlistener(P10, 'MovingROI', @(r1, evt) P10NewVP(P10, evt, P4, P9, P3, roi_InnerRectangle, roi_VanishingPoint, IGray2));
l10 = addlistener(P4, 'MovingROI', @(r1, evt) P4NewVP(P4, evt, P10, P9, P3, roi_InnerRectangle, roi_VanishingPoint, IGray2));

% TwelfPoints_VP = gen12Points(roi_VanishingPoint,roi_InnerRectangle);

end

%%
% *functions for radial line*

function OutterPoint = radialline_vp(~, evt, vp, rect, img)

global BorderPoint

BorderPoint = zeros(4, 2);

[~, EdgePoint] = rect2edge(rect);

allLine = findobj(gcf, 'Type', 'Line');
delete(allLine);

% remove all existing border points
allPoint = findall(gcf, 'Type', 'Point');
delete(allPoint);

% get current vanishing point position
C = evt.CurrentPosition;

RadialLine = zeros(1, 4);

OutterPoint = zeros(4, 2);

for x = 1:4
    ThroPoint = EdgePoint{x};
    aLine = TwoPointLine(C, ThroPoint);
    % get border point coordinates
    points = lineToBorderPoints(aLine, size(img));

    %     calcuate the distance from vanishing point (C) to border
    distance_C2Border = pdist([C(1), C(2); points(3), points(4)], 'euclidean');
    %     calcuate the distance from inner rectangle edge to border
    distance_Edge2Border = pdist([ThroPoint(1), ThroPoint(2); points(3), points(4)], 'euclidean');

    if distance_C2Border > distance_Edge2Border

        roi_pos = [points(3) points(4)];

    else

        roi_pos = [points(1) points(2)];

    end

    RadialLine(x) = line([roi_pos(1), C(1)], [roi_pos(2), C(2)], 'Color', 'r', 'LineWidth', 2);
    BorderPoint(x, :) = roi_pos;
    OutterPoint(x, :) = roi_pos;

    %     make sure that vanishing point is on the top layer
    uistack(RadialLine(x), 'down', 2);

    uistack(vp, 'up', 4);
    uistack(rect, 'up', 2);

end

assignin('base', 'OutterPoint', OutterPoint);
assignin('base', 'Updated_InnerRectangle', rect.Position);

end

function OutterPoint = radialline_ir(~, evt, vp, rect, img)

global BorderPoint

% get current inner rectangle position
rect_pos = evt.CurrentPosition;

rect_top_left = [rect_pos(1), rect_pos(2)];
rect_top_right = [rect_pos(1) + rect_pos(3), rect_pos(2)];
rect_bottom_left = [rect_pos(1), rect_pos(2) + rect_pos(4)];
rect_bottom_right = [rect_pos(1) + rect_pos(3), rect_pos(2) + rect_pos(4)];

EdgePoint = {rect_top_left, rect_top_right, rect_bottom_left, rect_bottom_right};

% remove all existing radial lines
allLine = findobj(gcf, 'Type', 'Line');
delete(allLine);

% get the vanishing point position
C = vp.Position;

RadialLine = zeros(1, 4);
% BorderPointPlot = zeros(1, 4);
OutterPoint = zeros(4, 2);

for x = 1:4
    ThroPoint = EdgePoint{x};
    aLine = TwoPointLine(C, ThroPoint);
    % get border point coordinates
    points = lineToBorderPoints(aLine, size(img));

    %     calcuate the distance from vanishing point (C) to border
    distance_C2Border = pdist([C(1), C(2); points(3), points(4)], 'euclidean');

    %     calcuate the distance from inner rectangle edge to border
    distance_Edge2Border = pdist([ThroPoint(1), ThroPoint(2); points(3), points(4)], 'euclidean');

    if distance_C2Border > distance_Edge2Border

        roi_pos = [points(3) points(4)];

    else

        roi_pos = [points(1) points(2)];

    end

    RadialLine(x) = line([roi_pos(1), C(1)], [roi_pos(2), C(2)], 'Color', 'r', 'LineWidth', 2);
    BorderPoint(x, :) = roi_pos;
    OutterPoint(x, :) = roi_pos;

    %     make sure that vanishing point is on the top layer
    uistack(RadialLine(x), 'down', 5);
    uistack(vp, 'up', 2);
    uistack(rect, 'up', 2);

end
assignin('base', 'OutterPoint', OutterPoint);
assignin('base', 'Updated_VanishingPoint', C);
end

function aLine = TwoPointLine(C, ThroPoint)
% coefficients = polyfit([x1 x2], [y1 y2], 1);
coefficients = polyfit([C(1) ThroPoint(1)], [C(2) ThroPoint(2)], 1);
a = coefficients(1);
b = coefficients(2);
% Define a line with the equation, a * x + y + b = 0.
aLine = [a, -1, b];

end

%

function roi = roiChange(~, evt, roi)
assignin('base', roi, evt.CurrentPosition);
end

function OutterPoint = BorderPointEvent(~, ~, roi9, roi10, roi3, roi4)

global BorderPoint

% global BorderPointPlot

P = BorderPoint;
roi9.Position = P(1, :);
roi10.Position = P(2, :);
roi3.Position = P(3, :);
roi4.Position = P(4, :);

OutterPoint = BorderPoint;
assignin('base', 'OutterPoint', OutterPoint);

% uistack(BorderPointPlot, 'down', 5);
uistack(roi9, 'up', 8);
uistack(roi10, 'up', 8);
uistack(roi3, 'up', 8);
uistack(roi4, 'up', 8);
end

function OutterPoint = P9NewVP(roi9, evt, roi3, roi10, roi4, rect, vp, img)

roiA_pos = evt.CurrentPosition;
roiB_pos = roi3.Position;

[rect_pos, EdgePoint] = rect2edge(rect);

%line1
x1 = [roiA_pos(1) rect_pos(1)];
y1 = [roiA_pos(2) rect_pos(2)];
%line2
x2 = [roiB_pos(1) rect_pos(1)];
y2 = [roiB_pos(2) rect_pos(2) + rect_pos(4)];

[roi, OutterPoint, vp_pos] = Outter_ROI(x1, x2, y1, y2, vp, img, EdgePoint);

% assign new positions to ROIs
roi3.Position = roi{3};
roi10.Position = roi{2};
roi4.Position = roi{4};

roi_layerup(vp, roi4, roi10, roi9, roi3,rect);
assignin('base', 'OutterPoint', OutterPoint);
assignin('base', 'Updated_VanishingPoint', vp_pos);

end

function OutterPoint = P3NewVP(roi3, evt, roi9, roi10, roi4, rect, vp, img)

roiA_pos = evt.CurrentPosition;
roiB_pos = roi9.Position;

[rect_pos, EdgePoint] = rect2edge(rect);

%line1
x1 = [roiA_pos(1) rect_pos(1)];
y1 = [roiA_pos(2) rect_pos(2) + rect_pos(4)];
%line2
x2 = [roiB_pos(1) rect_pos(1)];
y2 = [roiB_pos(2) rect_pos(2)];

[roi, OutterPoint, vp_pos] = Outter_ROI(x1, x2, y1, y2, vp, img, EdgePoint);

% assign new positions to ROIs
roi9.Position = roi{1};
roi10.Position = roi{2};
roi4.Position = roi{4};

roi_layerup(vp, roi4, roi10, roi9, roi3,rect);
assignin('base', 'OutterPoint', OutterPoint);
assignin('base', 'Updated_VanishingPoint', vp_pos);
end

function OutterPoint = P10NewVP(roi10, evt, roi4, roi9, roi3, rect, vp, img)

roiA_pos = evt.CurrentPosition;
roiB_pos = roi4.Position;

[rect_pos, EdgePoint] = rect2edge(rect);

%line1
x1 = [roiA_pos(1) rect_pos(1) + rect_pos(3)];
y1 = [roiA_pos(2) rect_pos(2)];
%line2
x2 = [roiB_pos(1) rect_pos(1) + rect_pos(3)];
y2 = [roiB_pos(2) rect_pos(2) + rect_pos(4)];

[roi, OutterPoint, vp_pos] = Outter_ROI(x1, x2, y1, y2, vp, img, EdgePoint);

% assign new positions to ROIs
roi4.Position = roi{4};
roi9.Position = roi{1};
roi3.Position = roi{3};

roi_layerup(vp, roi4, roi10, roi9, roi3,rect);
assignin('base', 'OutterPoint', OutterPoint);
assignin('base', 'Updated_VanishingPoint', vp_pos);
end

function OutterPoint = P4NewVP(roi4, evt, roi10, roi9, roi3, rect, vp, img)

roiA_pos = evt.CurrentPosition;
roiB_pos = roi10.Position;

[rect_pos, EdgePoint] = rect2edge(rect);

%line1
x1 = [roiA_pos(1) rect_pos(1) + rect_pos(3)];
y1 = [roiA_pos(2) rect_pos(2) + rect_pos(4)];
%line2
x2 = [roiB_pos(1) rect_pos(1) + rect_pos(3)];
y2 = [roiB_pos(2) rect_pos(2)];

[roi, OutterPoint, vp_pos] = Outter_ROI(x1, x2, y1, y2, vp, img, EdgePoint);

% assign new positions to ROIs
roi10.Position = roi{2};
roi9.Position = roi{1};
roi3.Position = roi{3};

roi_layerup(vp, roi4, roi10, roi9, roi3,rect);
assignin('base', 'OutterPoint', OutterPoint);
assignin('base', 'Updated_VanishingPoint', vp_pos);
end

function [roi, OutterPoint, vp_pos] = Outter_ROI(x1, x2, y1, y2, vp, img, EdgePoint)

p1 = polyfit(x1, y1, 1);
p2 = polyfit(x2, y2, 1);

%calculate intersection
x_intersect = fzero(@(x) polyval(p1 - p2, x), 3);
y_intersect = polyval(p1, x_intersect);

vp.Position = [x_intersect, y_intersect];
vp_pos = [x_intersect, y_intersect];

allLine = findobj(gcf, 'Type', 'Line');
delete(allLine);

roi = cell(1, 4);
RadialLine = zeros(1, 4);
OutterPoint = zeros(4, 2);

for x = 1:4
    ThroPoint = EdgePoint{x};
    aLine = TwoPointLine(vp_pos, ThroPoint);
    % get border point coordinates
    points = lineToBorderPoints(aLine, size(img));

    %     calcuate the distance from vanishing point (C) to border
    distance_C2Border = pdist([vp_pos(1), vp_pos(2); points(3), points(4)], 'euclidean');

    %     calcuate the distance from inner rectangle edge to border
    distance_Edge2Border = pdist([ThroPoint(1), ThroPoint(2); points(3), points(4)], 'euclidean');

    if distance_C2Border > distance_Edge2Border
        roi_pos = [points(3), points(4)];

    else
        roi_pos = [points(1), points(2)];

    end

    RadialLine(x) = line([roi_pos(1), vp.Position(1)], [roi_pos(2), vp.Position(2)], 'Color', 'r', 'LineWidth', 2);
    OutterPoint(x, :) = roi_pos;
    roi{x} = roi_pos;
end
end

function [rect_pos, EdgePoint] = rect2edge(rect)
rect_pos = rect.Position;
% get the inner rectangle position
rect_top_left = [rect_pos(1), rect_pos(2)];
rect_top_right = [rect_pos(1) + rect_pos(3), rect_pos(2)];
rect_bottom_left = [rect_pos(1), rect_pos(2) + rect_pos(4)];
rect_bottom_right = [rect_pos(1) + rect_pos(3), rect_pos(2) + rect_pos(4)];

EdgePoint = {rect_top_left, rect_top_right, rect_bottom_left, rect_bottom_right};
% EdgePoint = {rect_bottom_left, rect_top_right, rect_bottom_right,rect_top_left};

end

function roi_layerup(vp, roi4, roi10, roi9, roi3,rect)

uistack(vp, 'up', 9);
uistack(roi4, 'up', 7);
uistack(roi10, 'up', 7);
uistack(roi9, 'up', 7);
uistack(roi3, 'up', 7);
uistack(rect, 'up', 8);
end
