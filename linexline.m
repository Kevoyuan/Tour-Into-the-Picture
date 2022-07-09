function [xi,yi] = linexline(L1x, L1y, L2x, L2y, showIntersectionPlot)
%%***********************************************************************%
%*                    Line to line interection point                    *%
%*            Finds the interection of the two line segments.           *%
%*                                                                      *%
%*                                                                      *%
%* Author: Preetham Manjunatha                                          *%
%* Github link: https://github.com/preethamam                           *%
%* Date: 02/08/2022                                                     *%
%************************************************************************%
%
%************************************************************************%
%
% Usage: [xi,yi] = linexline(L1x, L1y, L2x, L2y)
%
% Inputs:
%
%           L1x                     - Line 1 x1 and x2 coordinates [x1, x2]
%           L1y                     - Line 1 y1 and y2 coordinates [y1, y2]
%           L2x                     - Line 2 x3 and x4 coordinates [x3, x4]
%           L2y                     - Line 2 y3 and y4 coordinates [y3, y4]
%           showIntersectionPlot    - show intersection plot (0 or 1)
% 
% Outputs: 
%
%           xi          - Interection point, x coordinate (NaN if no
%                         interesction)
%           yi          - Interection point, y coordinate (NaN if no
%                         interesction)
%--------------------------------------------------------------------------

%------------------------------------------------------------------------------------------------------------------------
% nargin check
if nargin < 4
    error('Not enough input arguments.');
elseif nargin > 5
    error('Too many input arguments.');
end

if nargin == 4
    %-----------------------
    % Show intersection plot
    showIntersectionPlot = 1;
end

%------------------------------------------------------------------------------------------------------------------------
% Data
x1 = L1x(1);
y1 = L1y(1);
x2 = L1x(2);
y2 = L1y(2);
x3 = L2x(1);
y3 = L2y(1);
x4 = L2x(2);
y4 = L2y(2);

%------------------------------------------------------------------------------------------------------------------------
% Line segments intersect parameters
u = ((x1-x3)*(y1-y2) - (y1-y3)*(x1-x2)) / ((x1-x2)*(y3-y4)-(y1-y2)*(x3-x4));
t = ((x1-x3)*(y3-y4) - (y1-y3)*(x3-x4)) / ((x1-x2)*(y3-y4)-(y1-y2)*(x3-x4));

%------------------------------------------------------------------------------------------------------------------------
% Check if intersection exists, if so then store the value
if (u >= 0 && u <= 1.0) && (t >= 0 && t <= 1.0)
    xi = ((x3 + u * (x4-x3)) + (x1 + t * (x2-x1))) / 2; 
    yi = ((y3 + u * (y4-y3)) + (y1 + t * (y2-y1))) / 2;
else
    xi = NaN;
    yi = NaN;
end

%------------------------------------------------------------------------------------------------------------------------
if showIntersectionPlot
    % Plot the lines
    plot([x1 x2], [y1 y2], 'LineWidth', 3)
    hold on
    plot([x3 x4], [y3 y4], 'LineWidth', 3)
    
    % Plot intersection points
    plot(x3 + u * (x4-x3), y3 + u * (y4-y3), 'ro', 'MarkerSize', 15)
    plot(x1 + t * (x2-x1), y1 + t * (y2-y1), 'bo', 'MarkerSize', 15)
    hold off
    xlabel('X'); ylabel('Y') 
    grid on

    ax = gca;
    exportgraphics(ax,'LineXPlot.png')
end
end