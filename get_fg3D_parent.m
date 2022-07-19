function [fg3D  poly_f]= get_fg3D_parent(TwelfPoints_2D,TwelfPoints_3D,fg2D,atteched_bg)
% alle 2D coordinate value is the value in the expanded image
syms x y z poly_f fv
P1_2D = TwelfPoints_2D(:,1);
P2_2D = TwelfPoints_2D(:,2);
P3_2D = TwelfPoints_2D(:,3);
P4_2D = TwelfPoints_2D(:,4);
P5_2D = TwelfPoints_2D(:,5);
P6_2D = TwelfPoints_2D(:,6);
P7_2D = TwelfPoints_2D(:,7);
P8_2D = TwelfPoints_2D(:,8);
P9_2D = TwelfPoints_2D(:,9);
P10_2D = TwelfPoints_2D(:,10);
P11_2D = TwelfPoints_2D(:,11);
P12_2D = TwelfPoints_2D(:,12);
P1_3D = TwelfPoints_3D(:,1);
P4_3D = TwelfPoints_3D(:,4);
P8_3D = TwelfPoints_3D(:,8);
P9_3D = TwelfPoints_3D(:,9);
P11_3D = TwelfPoints_3D(:,11);
P6_3D = TwelfPoints_3D(:,6);

% 4 situations
if strcmp(atteched_bg,'floor')
    % P1 P2
    fg3D(:,1) = transfor_floor2Dto3D(fg2D(:,1),P1_2D,P2_2D,P3_2D,P4_2D,P4_3D,P1_3D);
    fg3D(:,2) = transfor_floor2Dto3D(fg2D(:,2),P1_2D,P2_2D,P3_2D,P4_2D,P4_3D,P1_3D);
    % P4 
    fg3D(1,4) = -(fg3D(3,1)/P1_3D(3)) * (fg2D(1,4)-fg2D(1,1))+fg3D(1,1);
    fg3D(2,4) = (fg3D(3,1)/P1_3D(3)) * (fg2D(2,4)-fg2D(2,1))+fg3D(2,1);
    fg3D(3,4) = fg3D(3,1);
    % P3
    fg3D(1,3) = -(fg3D(3,2)/P1_3D(3)) * (fg2D(1,3)-fg2D(1,2))+fg3D(1,2);
    fg3D(2,3) = (fg3D(3,2)/P1_3D(3)) * (fg2D(2,3)-fg2D(2,2))+fg3D(2,2);
    fg3D(3,3) = fg3D(3,2);
    % function of attached background
    fv = 0*x + 1*y +0*z -P1_3D(2);
    % foreground object plane function
    poly_f= get_polygon_function(fg3D(:,1),fg3D(:,2),fv);
elseif strcmp(atteched_bg,'ceiling')
    % P3 P4
    fg3D(:,4) = transfor_ceiling2Dto3D(fg2D(:,4),P9_2D,P10_2D,P7_2D,P8_2D,P8_3D,P9_3D);
    fg3D(:,3) = transfor_ceiling2Dto3D(fg2D(:,3),P9_2D,P10_2D,P7_2D,P8_2D,P8_3D,P9_3D);
    % P1 
    fg3D(1,1) = -(fg3D(3,4)/P1_3D(3)) * (fg2D(1,1)-fg2D(1,4))+fg3D(1,4);
    fg3D(2,1) = (fg3D(3,4)/P1_3D(3)) * (fg2D(2,1)-fg2D(2,4))+fg3D(2,4);
    fg3D(3,1) = fg3D(3,4);
    % P2 
    fg3D(1,2) = -(fg3D(3,3)/P1_3D(3)) * (fg2D(1,2)-fg2D(1,3))+fg3D(1,3);
    fg3D(2,2) = (fg3D(3,3)/P1_3D(3)) * (fg2D(2,2)-fg2D(2,3))+fg3D(2,3);
    fg3D(3,2) = fg3D(3,3);
    % function of attached background
    fv = 0*x + 1*y + 0*z -P8_3D(2);
    poly_f= get_polygon_function(fg3D(:,3),fg3D(:,4),fv);
elseif strcmp(atteched_bg,'leftwall')
    % P1 P4
    fg3D(:,1) = transfor_left2Dto3D(fg2D(:,1),P11_2D,P7_2D,P5_2D,P1_2D,P1_3D,P11_3D);
    fg3D(:,4) = transfor_left2Dto3D(fg2D(:,4),P11_2D,P7_2D,P5_2D,P1_2D,P1_3D,P11_3D);
    % P2
    fg3D(1,2) =-(fg3D(3,1)/P1_3D(3))* (fg2D(1,2)-fg2D(1,1))+fg3D(1,1);
    fg3D(2,2) =(fg3D(3,1)/P1_3D(3))* (fg2D(2,2)-fg2D(2,1))+fg3D(2,1);
    fg3D(3,2) = fg3D(3,1);
    % P3 
    fg3D(1,3) =-(fg3D(3,4)/P1_3D(3))* (fg2D(1,3)-fg2D(1,4))+fg3D(1,4);
    fg3D(2,3) =(fg3D(3,4)/P1_3D(3))* (fg2D(2,3)-fg2D(2,4))+fg3D(2,4);
    fg3D(3,3) = fg3D(3,4);
    
    fv = 1 *x + 0*y +0*z -P1_3D(1);
    poly_f= get_polygon_function(fg3D(:,1),fg3D(:,4),fv );
elseif strcmp(atteched_bg,'rightwall')
    % P2 P3
    fg3D(:,2) = transfor_right2Dto3D(fg2D(:,2),P8_2D,P12_2D,P2_2D,P6_2D,P8_3D,P6_3D);
    fg3D(:,3) = transfor_right2Dto3D(fg2D(:,3),P8_2D,P12_2D,P2_2D,P6_2D,P8_3D,P6_3D);
    % P1
    fg3D(1,1) =-(fg3D(3,1)/P1_3D(3))* (fg2D(1,1)-fg2D(1,2))+fg3D(1,2);
    fg3D(2,1) =(fg3D(3,1)/P1_3D(3))* (fg2D(2,1)-fg2D(2,2))+fg3D(2,2);
    fg3D(3,1) = fg3D(3,2);
    % P4
    fg3D(1,4) =-(fg3D(3,3)/P1_3D(3))* (fg2D(1,4)-fg2D(1,3))+fg3D(1,3);
    fg3D(2,4) =(fg3D(3,3)/P1_3D(3))* (fg2D(2,4)-fg2D(2,3))+fg3D(2,3);
    fg3D(3,4) = fg3D(3,3);
    
    fv = 1 *x + 0*y +0*z -P8_3D(1);
    poly_f= get_polygon_function(fg3D(:,1),fg3D(:,4),fv );
end

end


%% floor
function fg3D = transfor_floor2Dto3D(fg2D,pLT,pRT,pLB,pRB,P4,P1)
% fg2D:the pixel coordinate value of one point,which belongs to the floor region
% pLT: pixel coordinate value of left top point of the floor region
% pRT: pixel coordinate value of right top point of the floor region
% pLB: pixel coordinate value of left bottom point of the floor region
% pRB pixel coordinate value of left bottom point of the floor region
% P4 : 3D coordinate value of point 4
% P1: 3D coordinate value of point 1
% fg3D : the 3D coordinate value of the point fg2D
    vector_Or01 = pRT - pLT; 
    vector_Or10 = pLB - pLT; 
    vector_Or11 = pRB - pLT;
    
    A = [vector_Or10 , vector_Or01];
    B = vector_Or11;
    a_solution = A\B;
    a0 = a_solution(1);
    a1 = a_solution(2);
  
    vector_Or = fg2D - pLT;
    
    C = vector_Or;
    y_solution = A\C;
    y0 = y_solution(1);
    y1 = y_solution(2);
    
    Denominator = a0*a1+a1*(a1-1)*y0+a0*(a0-1)*y1;            
    x0 = a1*(a0+a1-1)*y0/Denominator;
    x1 = a0*(a0+a1-1)*y1/Denominator;

    width = -(P4(1)-P1(1));
    tief = P1(3) - P4(3);
    
    Z= - round(tief*x0)+P1(3)
    Y=P1(2);
    X = -round(x1*width)+P1(1);
    fg3D = [X;Y;Z];
end

%% ceiling
function fg3D = transfor_ceiling2Dto3D(fg2D,pLT,pRT,pLB,pRB,P8,P9)
    vector_Or01 = pRT - pLT; 
    vector_Or10 = pLB - pLT; 
    vector_Or11 = pRB - pLT;
    
    A = [vector_Or10 , vector_Or01];
    B = vector_Or11;
    a_solution = A\B;
    a0 = a_solution(1);
    a1 = a_solution(2);
  
    vector_Or = fg2D - pLT;
    
    C = vector_Or;
    y_solution = A\C;
    y0 = y_solution(1);
    y1 = y_solution(2);
    
    Denominator = a0*a1+a1*(a1-1)*y0+a0*(a0-1)*y1;            
    x0 = a1*(a0+a1-1)*y0/Denominator;
    x1 = a0*(a0+a1-1)*y1/Denominator;

    width =-( P8(1)-P9(1));
    tief = P8(3) - P9(3);
    Z=  round(tief*x0)+P9(3)
    Y=P8(2);
    X = - round(x1*width)+P9(1);
    fg3D = [X;Y;Z];
end

%% leftwall
function fg3D = transfor_left2Dto3D(fg2D,pLT,pRT,pLB,pRB,P1,P11)

    
    vector_Or01 = pRT - pLT; 
    vector_Or10 = pLB - pLT; 
    vector_Or11 = pRB - pLT;
    
    A = [vector_Or10 , vector_Or01];
    B = vector_Or11;
    a_solution = A\B;
    a0 = a_solution(1);
    a1 = a_solution(2);
  
    vector_Or = fg2D - pLT;
    
    C = vector_Or;
    y_solution = A\C;
    y0 = y_solution(1);
    y1 = y_solution(2);
    
    Denominator = a0*a1+a1*(a1-1)*y0+a0*(a0-1)*y1;            
    x0 = a1*(a0+a1-1)*y0/Denominator;
    x1 = a0*(a0+a1-1)*y1/Denominator;

    height = P1(2)-P11(2);
    tief = P1(3) - P11(3);
    Y=  round(height*x0)+P11(2)
    X=P1(1);
    Z = round(x1*tief)+P11(3);
    fg3D = [X;Y;Z];
end

%% Rightwall
function fg3D = transfor_right2Dto3D(fg2D,pLT,pRT,pLB,pRB,P8,P6)

    
    vector_Or01 = pRT - pLT; 
    vector_Or10 = pLB - pLT; 
    vector_Or11 = pRB - pLT;
    
    A = [vector_Or10 , vector_Or01];
    B = vector_Or11;
    a_solution = A\B;
    a0 = a_solution(1);
    a1 = a_solution(2);
  
    vector_Or = fg2D - pLT;
    
    C = vector_Or;
    y_solution = A\C;
    y0 = y_solution(1);
    y1 = y_solution(2);
    
    Denominator = a0*a1+a1*(a1-1)*y0+a0*(a0-1)*y1;            
    x0 = a1*(a0+a1-1)*y0/Denominator;
    x1 = a0*(a0+a1-1)*y1/Denominator;

    height = P6(2)-P8(2);
    tief = P8(3) - P6(3);
    Y=  round(height*x0)+P8(2)
    X=P8(1);
    Z = -round(x1*tief)+P8(3);
    fg3D = [X;Y;Z];
end