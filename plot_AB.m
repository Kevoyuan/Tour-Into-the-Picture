function plot_AB(A,B,vertex)
p = vertex';

plot([p(A,1),p(B,1)], [p(A,2),p(B,2)],'LineWidth',4)
end