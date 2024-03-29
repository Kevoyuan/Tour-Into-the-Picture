% input image
im1 = imread("Die Oude Kerk in Amsterdam.jpg");
figure;
imshow(im1);
hold on;
xrange = xlim;
yrange = ylim;

% draw vanishing point
ROI_1 = drawpoint();
vanishingpoint = ROI_1.Position;

% draw inner rectangular
ROI_2 = drawrectangle();

% calculate the 11 points
% rear wall
P7 =  [ROI_2.Position(1),ROI_2.Position(2)];
P8 =  [ROI_2.Position(1) + ROI_2.Position(3),ROI_2.Position(2)];
P1 =  [ROI_2.Position(1),ROI_2.Position(2) + ROI_2.Position(4)];
P2 =  [ROI_2.Position(1) + ROI_2.Position(3),ROI_2.Position(2) + ROI_2.Position(4)];
plot(P7(1),P7(2),'*','Color','r');
hold on;
plot(P8(1),P8(2),'*','Color','r');
hold on;
plot(P1(1),P1(2),'*','Color','r');
hold on;
plot(P2(1),P2(2),'*','Color','r');
hold on;

% ceiling
[k_v7,b_v7] = lineequation(vanishingpoint,P7);
P9 = [-b_v7/k_v7,yrange(1)];
plot(P9(1),P9(2),'*','Color','r');
hold on;
plot([vanishingpoint(1),P9(1)],[vanishingpoint(2),P9(2)],'r');

[k_v8,b_v8] = lineequation(vanishingpoint,P8);
P10 = [-b_v8/k_v8,yrange(1)];
plot(P10(1),P10(2),'*','Color','r');
hold on;
plot([vanishingpoint(1),P10(1)],[vanishingpoint(2),P10(2)],'r');

% floor
[k_v1,b_v1] = lineequation(vanishingpoint,P1);
P3 = [(yrange(2) - b_v1)/k_v1,yrange(2)];
plot(P3(1),P3(2),'*','Color','r');
hold on;
plot([vanishingpoint(1),P3(1)],[vanishingpoint(2),P3(2)],'r');

[k_v2,b_v2] = lineequation(vanishingpoint,P2);
P4 = [(yrange(2) - b_v2)/k_v2,yrange(2)];
plot(P4(1),P4(2),'*','Color','r');
hold on;
plot([vanishingpoint(1),P4(1)],[vanishingpoint(2),P4(2)],'r');

% left wall
P11 = [xrange(1),b_v7];
plot(P11(1),P11(2),'*','Color','r');
hold on;

P5 = [xrange(1),b_v1];
plot(P5(1),P5(2),'*','Color','r');
hold on;

% right wall
P12 = [xrange(2),k_v8*xrange(2)+b_v8];
plot(P12(1),P12(2),'*','Color','r');
hold on;

P6= [xrange(2),k_v2*xrange(2)+b_v2];
plot(P6(1),P6(2),'*','Color','r');
hold on;

function [k,b] = lineequation(P1,P2)
    if P2(1) == P1(1)
        k = 0;
    else
        k = (P2(2) - P1(2))/(P2(1) - P1(1));
    end
    b = P2(2) - P2(1) * k;
end