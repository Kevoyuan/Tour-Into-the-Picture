function TwelfPoints_VP = gen12Points(vp, rect, OutterPoint, img)
[m, n] = size(img);
% global OutterPoint

% % draw vanishing point

vanishingpoint = vp;

% calculate the 12 points

Points = cell(12, 1);

% rect_position = rect.Position;

[~, EdgePoint] = rect2edge(rect);
Point7 = EdgePoint{1};
Points{7} = Point7;
Point8 = EdgePoint{2};
Points{8} = Point8;
Point1 = EdgePoint{3};
Points{1} = Point1;
Point2 = EdgePoint{4};
Points{2} = Point2;
Points{13} = vanishingpoint;

%% P9 & P11
if OutterPoint(1, 2) == 0.5 && OutterPoint(1, 1) < 0.5 * n
    edge_line_P11 = 1;
    Point9 = OutterPoint(1, :);
    Point11 = intersection(vanishingpoint, Point7, edge_line_P11);

    % elseif Point9(1) == 0.5 && Point9(1)> 0.5* n
    %     edge_line_P9 = 3;

elseif OutterPoint(1, 1) == 0.5 && OutterPoint(1, 2) < 0.5 * m
    edge_line_P9 = 2;
    Point11 = OutterPoint(1, :);
    Point9 = intersection(vanishingpoint, Point7, edge_line_P9);

    % elseif Point9(2) == 0.5 && Point9(2)> 0.5* m
    %     edge_line_P9 = 4;

end
Points{9} = Point9;
Points{11} = Point11;

%% P10 & P12
if OutterPoint(2, 2) == 0.5 && OutterPoint(2, 1) > 0.5 * n

    edge_line_P12 = 3;
    Point10 = OutterPoint(2, :);
    Point12 = intersection(vanishingpoint, OutterPoint(2, :), edge_line_P12);

    % elseif Point9(1) == 0.5 && Point9(1)> 0.5* n
    %     edge_line_P9 = 3;

elseif OutterPoint(2, 1) == n + 0.5 && OutterPoint(2, 2) < 0.5 * m
    edge_line_P10 = 2;
    Point12 = OutterPoint(2, :);
    Point10 = intersection(vanishingpoint, OutterPoint(2, :), edge_line_P10);

    % elseif Point9(2) == 0.5 && Point9(2)> 0.5* m
    %     edge_line_P9 = 4;
end
Points{10} = Point10;
Points{12} = Point12;

%% P3 & P5

if OutterPoint(3, 2) == m + 0.5 && OutterPoint(3, 1) < 0.5 * n
    edge_line_P5 = 1;
    Point3 = OutterPoint(3, :);
    Point5 = intersection(vanishingpoint, OutterPoint(3, :), edge_line_P5);

    % elseif Point9(1) == 0.5 && Point9(1)> 0.5* n
    %     edge_line_P9 = 3;
elseif OutterPoint(3, 1) == 0.5 && OutterPoint(3, 2) > 0.5 * m
    edge_line_P3 = 4;
    Point5 = OutterPoint(3, :);
    Point3 = intersection(vanishingpoint, OutterPoint(3, :), edge_line_P3);

    % elseif Point9(2) == 0.5 && Point9(2)> 0.5* m
    %     edge_line_P9 = 4;
end

Points{3} = Point3;
Points{5} = Point5;

%% P4 & P6

if OutterPoint(4, 2) == m + 0.5 && OutterPoint(4, 1) > 0.5 * n
    edge_line_P6 = 3;
    Point4 = OutterPoint(4, :);
    Point6 = intersection(vanishingpoint, OutterPoint(4, :), edge_line_P6);

    % elseif Point9(1) == 0.5 && Point9(1)> 0.5* n
    %     edge_line_P9 = 3;
elseif OutterPoint(4, 1) == n + 0.5 && OutterPoint(4, 2) > 0.5 * m
    edge_line_P4 = 4;
    Point6 = OutterPoint(4, :);
    Point4 = intersection(vanishingpoint, OutterPoint(4, :), edge_line_P4);

    % elseif Point9(2) == 0.5 && Point9(2)> 0.5* m
    %     edge_line_P9 = 4;
end

Points{4} = Point4;
Points{6} = Point6;
%%

TwelfPoints_VP = (cell2mat(Points))';
end

function intersect = intersection(vp, rect_edge, edge_line,img)
[m,n]=size(img);

switch edge_line
    case 1
        %         [x1 y1 x2 y2]
        line2 = [0.5 1 0.5 10];

    case 2
        line2 = [1 0.5 10 0.5];
    case 3
        line2 = [n + 0.5 1 n + 0.5 10];
    case 4
        line2 = [1 m + 0.5 10 m + 0.5];

end

% line1
x1 = [vp(1) rect_edge(1)];
y1 = [vp(2) rect_edge(2)];

% line2
x2 = [line2(1) line2(3)];
y2 = [line2(2) line2(4)];

p1 = polyfit(x1, y1, 1);
p2 = polyfit(x2, y2, 1);

%calculate intersection
x_intersect = fzero(@(x) polyval(p1 - p2, x), 3);
y_intersect = polyval(p1, x_intersect);

intersect = [x_intersect, y_intersect];
end

function [rect_pos, EdgePoint] = rect2edge(rect)
rect_pos = rect;
% get the inner rectangle position
rect_top_left = [rect_pos(1), rect_pos(2)];
rect_top_right = [rect_pos(1) + rect_pos(3), rect_pos(2)];
rect_bottom_left = [rect_pos(1), rect_pos(2) + rect_pos(4)];
rect_bottom_right = [rect_pos(1) + rect_pos(3), rect_pos(2) + rect_pos(4)];

EdgePoint = {rect_top_left, rect_top_right, rect_bottom_left, rect_bottom_right};
% EdgePoint = {rect_bottom_left, rect_top_right, rect_bottom_right,rect_top_left};

end
