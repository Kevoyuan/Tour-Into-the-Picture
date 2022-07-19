function plot_AB(A,B,vertex,ax)
% plot line between Point A and Point B
% vertex: 12 vertexes matrix


p = vertex';

plot(ax,[p(A,1),p(B,1)], [p(A,2),p(B,2)],'LineWidth',4)
end