function [l1,l2,vanishing_point,inner_rectangle] = spidery_mesh(Image2)
    IGray2 = rgb_to_gray(Image2);
    h = figure('Name','Spidery Mesh','Position',[0,0,700,400]);
    imshow(Image2);
    % get the size of the img
    [m,n]= size(IGray2);
    %% Draw vanishing point
    % initial VanishingPoint(middle of the Picture)
    vb = .5 * (m);
    va = .5 * (n);
    pos_VanishingPoint = [va vb];
    hold on
    roi_VanishingPoint = drawpoint(gca,'Position',pos_VanishingPoint,"Color",'k',"LineWidth",5);
	%% Draw inner rectangle
    % [x y w h]= x and y elements determine the location (top-left) and the w and h elements determine the size
    hold on
    pos_InnerRectangle = [0.6*va,0.6*vb,0.5*va+0.25*vb,0.8*va];
    roi_InnerRectangle = drawrectangle('Color','k','FaceAlpha', 0, ...
        'FaceSelectable',(false),'LineWidth',1);
    roi_InnerRectangle.Position = pos_InnerRectangle;
    %% Draw 4 radial lines
    % step1: 4 edges of inner rectangle
    l1 = addlistener(roi_VanishingPoint,'MovingROI',@(src, evt) radialline_vp(src,evt,roi_VanishingPoint,roi_InnerRectangle,Image2));
    l2 = addlistener(roi_InnerRectangle,'MovingROI',@(src, evt) radialline_ir(src,evt,roi_VanishingPoint,roi_InnerRectangle,Image2));
    %% Get Positions of vanishing point & inner rectangle
    inner_rectangle = addlistener(roi_InnerRectangle,'ROIMoved',@(src, evt) roiChange(src,evt,'Updated_InnerRectangle'));
    vanishing_point = addlistener(roi_VanishingPoint,'ROIMoved',@(src, evt) roiChange(src,evt,'Updated_VanishingPoint'));
    %close(h)
end
    
function BorderPoint = radialline_vp(src, evt,vp,rect,img)
BorderPoint =zeros(1,4);

rect_pos = rect.Position;
% get the inner rectangle position
rect_top_left = [rect_pos(1), rect_pos(2)];
rect_top_right = [rect_pos(1) + rect_pos(3), rect_pos(2)];
rect_bottom_left = [rect_pos(1), rect_pos(2)+rect_pos(4)];
rect_botton_right = [rect_pos(1)+rect_pos(3), rect_pos(2)+rect_pos(4)];

% save as cell
EdgePoint = {rect_top_left,rect_top_right,rect_bottom_left,rect_botton_right};

% remove all existing radial lines
allLine = findobj(gcf,'Type', 'Line');
delete(allLine);

% remove all existing border points
allPoint = findall(gcf,'Type','Point');
delete(allPoint);

% get current vanishing point position
C = evt.CurrentPosition;

RadialLine = zeros(1,4);
BorderPointPlot = zeros(1,4);


for x = 1:4
    ThroPoint = EdgePoint{x};
    aLine = TwoPointLine(C, ThroPoint);
    % get border point coordinates
    points = lineToBorderPoints(aLine,size(img));

    %     calcuate the distance from vanishing point (C) to border
    distance_C2Border = pdist([C(1),C(2);points(3),points(4)],'euclidean');
    %     calcuate the distance from inner rectangle edge to border
    distance_Edge2Border = pdist([ThroPoint(1),ThroPoint(2);points(3),points(4)],'euclidean');

    if distance_C2Border > distance_Edge2Border
        %         lines(x) = drawline('Position',[C(1) C(2);points(3) points(4)],'Color','r');
        %     else
        %         lines(x) = drawline('Position',[C(1) C(2);points(1) points(2)],'Color','r');
        RadialLine(x) = line([C(1),points(3)],[C(2),points(4)],'Color', 'r', 'LineWidth', 2);
        BorderPointPlot(x) = plot(points(3), points(4),'-s','MarkerSize',10, ...
            'MarkerEdgeColor','red','MarkerFaceColor','r');
%         BorderPoint(x) = drawpoint("Position",[points(3) points(4)],"Visible","off");
    else
        RadialLine(x) = line([C(1),points(1)],[C(2),points(2)],'Color', 'r', 'LineWidth', 2);
        BorderPointPlot(x) = plot(points(1), points(2),'-s','MarkerSize',10, ...
            'MarkerEdgeColor','red','MarkerFaceColor','r');
%         BorderPoint(x) = drawpoint("Position",[points(1) points(2)],"Visible","off");
    end

    % make sure that vanishing point is on the top layer
    uistack(RadialLine(x),'down',2);
%     uistack(BorderPointPlot(x),'down',2);
    uistack(vp,'up',2);
    uistack(rect,'up',2);

end

end

function roi_BorderPoint = radialline_ir(src, evt,vp,rect,img)
roi_BorderPoint = zeros(1,4);

% get current inner rectangle position
rect_pos = evt.CurrentPosition;

rect_top_left = [rect_pos(1), rect_pos(2)];
rect_top_right = [rect_pos(1) + rect_pos(3), rect_pos(2)];
rect_bottom_left = [rect_pos(1), rect_pos(2)+rect_pos(4)];
rect_botton_right = [rect_pos(1)+rect_pos(3), rect_pos(2)+rect_pos(4)];

EdgePoint = {rect_top_left,rect_top_right,rect_bottom_left,rect_botton_right};

% remove all existing radial lines
allLine = findobj(gcf,'Type', 'Line');
delete(allLine);

% get the vanishing point position
C = vp.Position;
RadialLine = zeros(1,4);
BorderPointPlot = zeros(1,4);

for x = 1:4
    ThroPoint = EdgePoint{x};
    aLine = TwoPointLine(C, ThroPoint);
    % get border point coordinates
    points = lineToBorderPoints(aLine,size(img));

    %     calcuate the distance from vanishing point (C) to border
    distance_C2Border = pdist([C(1),C(2);points(3),points(4)],'euclidean');
    %     calcuate the distance from inner rectangle edge to border
    distance_Edge2Border = pdist([ThroPoint(1),ThroPoint(2);points(3),points(4)],'euclidean');
%     delete(roi_BorderPoint);
    if distance_C2Border > distance_Edge2Border
        %         lines(x) = drawline('Position',[C(1) C(2);points(3) points(4)],'Color','r');
        %     else
        %         lines(x) = drawline('Position',[C(1) C(2);points(1) points(2)],'Color','r');
        RadialLine(x) = line([C(1),points(3)],[C(2),points(4)],'Color', 'r', 'LineWidth', 2);
        BorderPointPlot(x) = plot(points(3), points(4),'-s','MarkerSize',10, ...
            'MarkerEdgeColor','red','MarkerFaceColor','r');

%         roi_BorderPoint = addlistener(rect,'ROIMoved',@(src, evt) place_border_roi(points(3),points(4)));
    else
        RadialLine(x) = line([C(1),points(1)],[C(2),points(2)],'Color', 'r', 'LineWidth', 2);
        BorderPointPlot(x) = plot(points(1), points(2),'-s','MarkerSize',10, ...
            'MarkerEdgeColor','red','MarkerFaceColor','r');
%         BorderPoint = addlistener(rect,'ROIMoved',@(src, evt) place_border_roi(points(1),points(2)));

    end

    %     make sure that vanishing point is on the top layer
    uistack(RadialLine(x),'down',2);
%     uistack(BorderPointPlot(x),'down',2);
    uistack(vp,'up',2);
    uistack(rect,'up',2);


end


end


function place_border_roi(pos1,pos2)

position = [pos1 pos2];

drawpoint("Position",position,"Color",'r',"LineWidth",5);

end

function pos = customWait(hROI)

% Listen for moved the ROI
l = addlistener(hROI,'ROIMoved',@roi_position);

% Block program execution


% Remove listener
delete(l);

% Return the current position
pos = roi_pos;

end

function roi_pos = roi_position(src, evt)
roi_pos = evt.CurrentPosition;

end




function aLine = TwoPointLine(C, ThroPoint)
% coefficients = polyfit([x1 x2], [y1 y2], 1);
coefficients = polyfit([C(1) ThroPoint(1)], [C(2) ThroPoint(2)], 1);
a = coefficients (1);
b = coefficients (2);
% Define a line with the equation, a * x + y + b = 0.
aLine = [a,-1,b];

end

function roi = roiChange(~,evt,roi)
    assignin('base',roi,evt.CurrentPosition);

end