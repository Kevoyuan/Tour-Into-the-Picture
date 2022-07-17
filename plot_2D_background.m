function plot_2D_background(new_12Points,InnerRectangle,ax)
plot(ax,new_12Points(1,:),new_12Points(2,:),'r*')

names = {'P1';'P2';'P3';'P4';'P5';'P6';'P7';'P8';'P9';'P10';'P11';'P12';"VP"};

% twelfPoint_cell = mat2cell(new_TwelfPoints',[12, 1]);


plot_AB(1,3,new_12Points,ax)
plot_AB(1,5,new_12Points,ax)
plot_AB(7,9,new_12Points,ax)
plot_AB(7,11,new_12Points,ax)
plot_AB(8,10,new_12Points,ax)
plot_AB(8,12,new_12Points,ax)
plot_AB(2,4,new_12Points,ax)
plot_AB(2,6,new_12Points,ax)

plot_AB(9,10,new_12Points,ax)
plot_AB(3,4,new_12Points,ax)
plot_AB(5,11,new_12Points,ax)
plot_AB(6,12,new_12Points,ax)

rect_pos = [new_12Points(1,7) new_12Points(2,7) InnerRectangle(3) InnerRectangle(4)];



rectangle(ax,'Position', rect_pos, 'EdgeColor', 'r', 'LineWidth', 4);

text(ax,new_12Points(1,:),new_12Points(2,:),names,'color','red','HorizontalAlignment','right','FontWeight','bold')