
function TwelfPoints = gen12Points(vp,rect,OutterPoint)
global m
global n

% % draw vanishing point


vanishingpoint = vp;


% calculate the 11 points

Points =cell(12,1);

[~, EdgePoint] = rect2edge(rect);
Point7 = EdgePoint{1};
Points{7} = Point7;
Point8 = EdgePoint{2};
Points{8} = Point8;
Point1 = EdgePoint{3};
Points{1} = Point1;
Point2 = EdgePoint{4};
Points{2} = Point2;



% ceiling

Point9 = OutterPoint(1,:);
Points{9} = Point9;

if Point9(2) == 0.5 && Point9(1)< 0.5* n
    edge_line_P9 = 1;
% elseif Point9(1) == 0.5 && Point9(1)> 0.5* n
%     edge_line_P9 = 3;
elseif Point9(1) == 0.5 && Point9(2)< 0.5* m
    edge_line_P9 = 2;
% elseif Point9(2) == 0.5 && Point9(2)> 0.5* m
%     edge_line_P9 = 4;
end




% plot(Point9(1),Point9(2),'*','Color','r');
% hold on;
% plot([vanishingpoint(1),Point9(1)],[vanishingpoint(2),Point9(2)],'r');
% hold on;


Point10 = OutterPoint(2,:);
Points{10} = Point10;

if Point10(2) == 0.5 && Point10(1)> 0.5* n
    edge_line_P10 = 3;
% elseif Point9(1) == 0.5 && Point9(1)> 0.5* n
%     edge_line_P9 = 3;
elseif Point10(1) == n+0.5 && Point10(2)< 0.5* m
    edge_line_P10 = 2;
% elseif Point9(2) == 0.5 && Point9(2)> 0.5* m
%     edge_line_P9 = 4;
end

% plot(Point10(1),Point10(2),'*','Color','r');
% hold on;
% plot([vanishingpoint(1),Point10(1)],[vanishingpoint(2),Point10(2)],'r');

% floor

Point3 = OutterPoint(3,:);
Points{3} = Point3;

if Point3(2) == m+0.5 && Point3(1)< 0.5* n
    edge_line_P3 = 1;
% elseif Point9(1) == 0.5 && Point9(1)> 0.5* n
%     edge_line_P9 = 3;
elseif Point3(1) == 0.5 && Point3(2)> 0.5* m
    edge_line_P3 = 4;
% elseif Point9(2) == 0.5 && Point9(2)> 0.5* m
%     edge_line_P9 = 4;
end

% plot(Point3(1),Point3(2),'*','Color','r');
% hold on;
% plot([vanishingpoint(1),Point3(1)],[vanishingpoint(2),Point3(2)],'r');


Point4 = OutterPoint(4,:);
Points{4} = Point4;

if Point4(1) == n+0.5 && Point4(2)> 0.5* m
    edge_line_P4 = 4;
% elseif Point9(1) == 0.5 && Point9(1)> 0.5* n
%     edge_line_P9 = 3;
elseif Point4(2) == m+0.5 && Point4(1)> 0.5* n
    edge_line_P4 = 3;
% elseif Point9(2) == 0.5 && Point9(2)> 0.5* m
%     edge_line_P9 = 4;
end

% plot(Point4(1),Point4(2),'*','Color','r');
% hold on;
% plot([vanishingpoint(1),Point4(1)],[vanishingpoint(2),Point4(2)],'r');
%% 

% left wall

Point11 = intersection(vanishingpoint, Point7,edge_line_P9);
Points{11} = Point11;
% plot(Point11(1),Point11(2),'*','Color','r');
% hold on;

Point5 = intersection(vanishingpoint, Point3,edge_line_P3);
Points{5} = Point5;
% plot(Point5(1),Point5(2),'*','Color','r');
% hold on;

% right wall
Point12 = intersection(vanishingpoint, Point10,edge_line_P10);
Points{12} = Point12;
% plot(Point12(1),Point12(2),'*','Color','r');
% hold on;

Point6 = intersection(vanishingpoint, Point4,edge_line_P4);
Points{6} = Point6;
% plot(Point6(1),Point6(2),'*','Color','r');
% hold on;


TwelfPoints = (cell2mat(Points))';
end



function intersect = intersection(vp, rect_edge,edge_line)
global m
global n

switch edge_line
    case 1
%         [x1 y1 x2 y2]
        line2 = [0.5 1 0.5 2];

    case 2
        line2 = [1 0.5 2 0.5];
    case 3
        line2 = [n+0.5 1 n+0.5 2];
    case 4
        line2 = [1 m+0.5 2 m+0.5];

end


    % line1
    x1 = [vp(1) rect_edge(1)];
    y1 = [vp(2)  rect_edge(2)];

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





