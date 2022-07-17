function fg2D = find_rectangular(points,n)

fg2D = zeros(2,n*4)
for i =1 :n
    fg = points{i};
    xmin = min(fg(1,:));
    xmax = max(fg(1,:));
    ymin = min(fg(2,:));
    ymax = max(fg(2,:));
    fg2D(:,4*i-3:4*i)=[xmin,xmax,xmax,xmin;ymax ymax ymin ymin];
end
end


