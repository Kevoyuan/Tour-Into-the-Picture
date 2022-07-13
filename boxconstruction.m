function [twelfPoints_3D,Vanishing_point] = boxconstruction(twelfPoints,k)
    P1 = twelfPoints(:,1);
    P2 = twelfPoints(:,2);
    P3 = twelfPoints(:,3);
    P4 = twelfPoints(:,4);
    P5 = twelfPoints(:,5);
    P6 = twelfPoints(:,6);
    P7 = twelfPoints(:,7);
    P8 = twelfPoints(:,8);
    P9 = twelfPoints(:,9);
    P10 = twelfPoints(:,10);
    P11 = twelfPoints(:,11);
    P12 = twelfPoints(:,12);
    vanishingpoint = twelfPoints(:,13);

    u_v = vanishingpoint(1);
    v_v = vanishingpoint(2);
    
    
    Vanishing_point = twoD2threeD(u_v,v_v,vanishingpoint(1),vanishingpoint(2));
    % rear wall z = 1
    
    p1 = twoD2threeD(u_v,v_v,P1(1), P1(2));
    p2 = twoD2threeD(u_v,v_v,P2(1), P2(2));
    % floor y = y(p1) = y(p2);
    floor = p1(2);
    
    p7 = twoD2threeD(u_v,v_v,P7(1), P7(2));
    % left wall x = x(p7)
    % ceiling y = y(p7)
    lw = p7(1);
    ceiling = p7(2);
    
    p8 = twoD2threeD(u_v,v_v,P8(1), P8(2));
    % right wall x = x(p8)
    rw = p8(1);
    
    % determine the points on the walls by normalizing
    % p3 on the floor and left wall
    p3 = twoD2threeD(u_v,v_v,P3(1), P3(2));
    p3 = p3/p3(2) * floor;
    
    % p4 on the floor and right wall
    p4 = twoD2threeD(u_v,v_v,P4(1), P4(2));
    p4 = p4/p4(2) * floor;
    
    % p5 on the floor and left wall
    p5 = twoD2threeD(u_v,v_v,P5(1), P5(2));
    p5 = p5/p5(2) * floor;
    
    % p6 on the floor and right wall
    p6 = twoD2threeD(u_v,v_v,P6(1), P6(2));
    p6 = p6/p6(2) * floor;
    
    % p9 on the ceiling and left wall
    p9 = twoD2threeD(u_v,v_v,P9(1), P9(2));
    p9 = p9/p9(2) * ceiling;
    
    % p10 on the ceiling and right wall
    p10 = twoD2threeD(u_v,v_v,P10(1), P10(2));
    p10 = p10/p10(2) * ceiling;
    
    % p11 on the ceiling and left wall
    p11 = twoD2threeD(u_v,v_v,P11(1), P11(2));
    p11 = p11/p11(2) * ceiling;
    
    % p12 on the ceiling and right wall
    p12 = twoD2threeD(u_v,v_v,P12(1), P12(2));
    p12 = p12/p12(2) * ceiling;
    
    Vanishing_point(3) = Vanishing_point(3) * k;
    p1(3) = p1(3) * k;
    p2(3) = p2(3) * k;
    p3(3) = p3(3) * k;
    p4(3) = p4(3) * k;
    p5(3) = p5(3) * k;
    p6(3) = p6(3) * k;
    p7(3) = p7(3) * k;
    p8(3) = p8(3) * k;
    p9(3) = p9(3) * k;
    p10(3) = p10(3) * k;
    p11(3) = p11(3) * k;
    p12(3) = p12(3) * k;
    % % p_test on the ceiling
    % p_test = twoD2threeD(u_v,v_v,6,2);
    % p_test = p_test / p_test(2) * ceiling;
    
    twelfPoints_3D = [p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12]; 
    figure;
    scatter3(Vanishing_point(1),Vanishing_point(2),Vanishing_point(3),'*');
    hold on;
    scatter3(p1(1),p1(2),p1(3));
    hold on;
    scatter3(p2(1),p2(2),p2(3));
    hold on;
    scatter3(p3(1),p3(2),p3(3));
    hold on;
    scatter3(p4(1),p4(2),p4(3));
    hold on;
    scatter3(p5(1),p5(2),p5(3));
    hold on;
    scatter3(p6(1),p6(2),p6(3));
    hold on;
    scatter3(p7(1),p7(2),p7(3));
    hold on;
    scatter3(p8(1),p8(2),p8(3));
    hold on;
    scatter3(p9(1),p9(2),p9(3));
    hold on;
    scatter3(p10(1),p10(2),p10(3));
    hold on;
    scatter3(p11(1),p11(2),p11(3));
    hold on;
    scatter3(p12(1),p12(2),p12(3));
    hold on;
    
    plot3([p1(1),p2(1)],[p1(2),p2(2)],[p1(3),p2(3)],'Color','r');
    hold on;
    plot3([p1(1),p7(1)],[p1(2),p7(2)],[p1(3),p7(3)],'Color','r');
    hold on;
    plot3([p8(1),p2(1)],[p8(2),p2(2)],[p8(3),p2(3)],'Color','r');
    hold on;
    plot3([p8(1),p7(1)],[p8(2),p7(2)],[p8(3),p7(3)],'Color','r');
    hold on;
    
    plot3([p1(1),p3(1)],[p1(2),p3(2)],[p1(3),p3(3)],'Color','g');
    hold on;
    plot3([p4(1),p2(1)],[p4(2),p2(2)],[p4(3),p2(3)],'Color','g');
    hold on;
    plot3([p4(1),p3(1)],[p4(2),p3(2)],[p4(3),p3(3)],'Color','g');
    hold on;
    
    plot3([p7(1),p9(1)],[p7(2),p9(2)],[p7(3),p9(3)],'Color','b');
    hold on;
    plot3([p8(1),p10(1)],[p8(2),p10(2)],[p8(3),p10(3)],'Color','b');
    hold on;
    plot3([p9(1),p10(1)],[p9(2),p10(2)],[p9(3),p10(3)],'Color','b');
    hold on;
    
    plot3([p5(1),p11(1)],[p5(2),p11(2)],[p5(3),p11(3)],'Color','k');
    hold on;
    plot3([p7(1),p11(1)],[p7(2),p11(2)],[p7(3),p11(3)],'Color','k');
    hold on;
    plot3([p5(1),p1(1)],[p5(2),p1(2)],[p5(3),p1(3)],'Color','k');
    hold on;
    
    plot3([p6(1),p12(1)],[p6(2),p12(2)],[p6(3),p12(3)],'Color','y');
    hold on;
    plot3([p6(1),p2(1)],[p6(2),p2(2)],[p6(3),p2(3)],'Color','y');
    hold on;
    plot3([p8(1),p12(1)],[p8(2),p12(2)],[p8(3),p12(3)],'Color','y');
    hold on;
    
    plot3([0,0],[0,50],[0,0]);
    plot3([0,50],[0,0],[0,0]);
    plot3([0,0],[0,0],[0,50]);
    % scatter3(p_test(1),p_test(2),p_test(3));
    % grid off;
    axis equal;
    
    xlabel('X');
    ylabel('Y');
    zlabel('Z');

end