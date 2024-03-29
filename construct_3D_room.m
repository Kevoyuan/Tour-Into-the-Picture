function [f,ax] = construct_3D_room(varargin)
    %wall: rectangle image
    %threeDcoords:a 3x13 matrix:[x1 x2...x13;y1 y2...y13;z1 z2...z13]
    %fg3D: 3D coordinates of foreground objects
    %n: number of foreground objects
    %fg_image : texture matrix of foreground objects
    threeDcoords = varargin{1};
    fg3D = varargin{2};
    n = varargin{3};
    fg_polygon_function = varargin{4};
    fg_image= varargin{5};
    
    disp("Number of input arguments: " + nargin);
    
    %get 3D coordinates of each point    
    p1 = threeDcoords(:,1)';
    p2 = threeDcoords(:,2)';
    p3 = threeDcoords(:,3)';
    p4 = threeDcoords(:,4)';
    p5 = threeDcoords(:,5)';
    p6 = threeDcoords(:,6)';
    p7 = threeDcoords(:,7)';
    p8 = threeDcoords(:,8)';
    p9 = threeDcoords(:,9)';
    p10 = threeDcoords(:,10)';
    p11 = threeDcoords(:,11)';
    p12 = threeDcoords(:,12)';
    
    %two situations: there are 5 walls or two walls
    if nargin==7
        wall2 = varargin{6};
        wall5 = varargin{7};
        
        cdata2 = flipdim(wall2,1);
        cdata5 = flipdim(wall5,1);
        
        surface([p2(1) p1(1);p8(1) p7(1)], [p2(2) p1(2);p8(2) p7(2)], [p2(3) p1(3);p8(3) p7(3)],'FaceColor', 'texturemap', 'CData', cdata2);
        surface([p4(1) p3(1);p2(1) p1(1)], [p4(2) p3(2);p2(2) p1(2)], [p4(3) p3(3);p2(3) p1(3)],'FaceColor', 'texturemap', 'CData', cdata5);       
        xlabel('X');
        ylabel('Y');
        zlabel('Z');
        view(3);
        hold on  
    else
        wall1 = varargin{6};
        wall2 = varargin{7};
        wall3 = varargin{8};
        wall4 = varargin{9};
        wall5 = varargin{10};
            %texture mapping
        cdata1_1 = flipdim(wall1,1);
        cdata1 = flipdim(cdata1_1,2);      

        cdata2 = flipdim(wall2,1);

        cdata3_1 = flipdim(wall3,1);
        cdata3 = flipdim(cdata3_1,2);

        cdata4 = flipdim(wall4,1);

        cdata5 = flipdim(wall5,1);


        %draw cuboid
        %leftwall
        surface([p6(1) p2(1);p12(1) p8(1)], [p1(2) p5(2);p7(2) p11(2)], [p1(3) p5(3);p7(3) p11(3)],'FaceColor', 'texturemap', 'CData', cdata1);

        %rearwall     
        surface([p2(1) p1(1);p8(1) p7(1)], [p2(2) p1(2);p8(2) p7(2)], [p2(3) p1(3);p8(3) p7(3)],'FaceColor', 'texturemap', 'CData', cdata2);

        %rightwall
        surface([p1(1) p5(1);p7(1) p11(1)], [p6(2) p2(2);p12(2) p8(2)], [p6(3) p2(3);p12(3) p8(3)],'FaceColor', 'texturemap', 'CData', cdata3);

        %ceiling
        surface([p8(1) p7(1);p10(1) p9(1)], [p8(2) p7(2);p10(2) p9(2)], [p8(3) p7(3);p10(3) p9(3)],'FaceColor', 'texturemap', 'CData', cdata4);

        %floor  
        surface([p4(1) p3(1);p2(1) p1(1)], [p4(2) p3(2);p2(2) p1(2)], [p4(3) p3(3);p2(3) p1(3)],'FaceColor', 'texturemap', 'CData', cdata5);        

        xlabel('X');
        ylabel('Y');
        zlabel('Z');
        view(3);
        hold on
    
    end
           
    %draw foreground object
    for i =1 :n
        plot_polygon(fg3D(:,4*i-3:4*i),fg_polygon_function(i),fg_image{i});
        hold on
    end
    axis off
    ax = gca;
    f = gcf;
end