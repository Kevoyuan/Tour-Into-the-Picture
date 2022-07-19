function fg2D = find_rectangular(points)

fg2D = zeros(2,4);
fg = points;
xmin = min(fg(1,:));
xmax = max(fg(1,:));
ymin = min(fg(2,:));
ymax = max(fg(2,:));
fg2D=[xmin,xmax,xmax,xmin;ymax ymax ymin ymin];

end



