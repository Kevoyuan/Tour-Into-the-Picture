function p = get_3D_Coords(image_pad,new_Pixel_Vertex,P)
    %Pixel_Vertex is a 2x13 matrix which saves 2D coordinates of 13 points
    %P: 2D coordinate of a point P = [x y]
    %p: 3D coordinate of the point p = [x y z]
    
    p = zeros(1,3);
    d = 0;
    f = 100; %assume the focal length of camera is 100
    Height = size(image_pad,1);
    Width = size(image_pad,2);
    
    %distance of P8 and P13/P13 and P2 in y-axis direction
    AB = new_Pixel_Vertex(2,2)-new_Pixel_Vertex(2,8);
    BV = new_Pixel_Vertex(2,13)-new_Pixel_Vertex(2,8);
    VA = new_Pixel_Vertex(2,2)-new_Pixel_Vertex(2,13);
    
    %distance of p8 and p13/p13 and p2 in y-axis direction(3D-system)
    ab = Height;
    bv = (BV/AB)*ab;
    va = (VA/AB)*ab;
    
    %distance of P2 and P13/P13 and P1 in x-axis direction
    AD = new_Pixel_Vertex(1,2)-new_Pixel_Vertex(1,1);
    AV = new_Pixel_Vertex(1,2)-new_Pixel_Vertex(1,13);
    VD = new_Pixel_Vertex(1,13)-new_Pixel_Vertex(1,1);
    
    %distance of p2 and p13/p13 and p1 in x-axis direction(3D-system)
    ad = Width;
    av = (AV/AD)*ad;
    vd = (VD/AD)*ad;
   
    %3D y coordinate
    if P(2)<new_Pixel_Vertex(2,13)
        p(2) = bv;
    elseif P(2)>new_Pixel_Vertex(2,13)
        p(2) = -va;
    else
        p(2) = 0;
    end
    
    %3D z coordinate
    if (P(1)==new_Pixel_Vertex(1,13) && P(2)==new_Pixel_Vertex(2,13))
        p(3) = -(f*bv/BV-f);
    else
        d = (f*abs(p(2)))/(abs(P(2)-new_Pixel_Vertex(2,13)))-f;
        p(3) = -d;
    end
       
    %3D x coordinate
    if P(1)<new_Pixel_Vertex(1,13)
        p(1) = -vd;
    elseif P(1)>new_Pixel_Vertex(1,13)
        p(1) = av;
    else
        p(1) = 0;
    end

end