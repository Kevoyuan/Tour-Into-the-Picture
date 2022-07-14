function [subimage1, subimage2, subimage3, subimage4, subimage5] = image_matting(image_pad, Points)
    %The matrix Points save the screen coordinates of 12 vertices after
    %padding
    
    %left wall, vertices: P11, P7, P1, P5
    %generate mask left wall
    x1 = [Points(1,11) Points(1,7) Points(1,1) Points(1,5) Points(1,11)];
    y1 = [Points(2,11) Points(2,7) Points(2,1) Points(2,5) Points(2,11)];
    mask1 = poly2mask(x1,y1,size(image_pad,1),size(image_pad,2));
    imshow(mask1)
    hold on
    plot(x1,y1,'b','LineWidth',2)
    hold off
    %original image + mask ==> subimage matting
    img_size = size(image_pad)
    R = image_pad(:,:,1);
    G = image_pad(:,:,2);
    B = image_pad(:,:,3);
    subimage1(:,:,1) = R.*uint8(mask1);
    subimage1(:,:,2) = G.*uint8(mask1);
    subimage1(:,:,3) = B.*uint8(mask1);
    imwrite(subimage1, 'leftwall.png');
    figure;
    imshow(subimage1);

    %rear wall, vertices: P7, P8, P2, P1
    x2 = [Points(1,7) Points(1,8) Points(1,2) Points(1,1) Points(1,7)];
    y2 = [Points(2,7) Points(2,8) Points(2,2) Points(2,1) Points(2,7)];
    mask2 = poly2mask(x2,y2,size(image_pad,1),size(image_pad,2));
    imshow(mask2)
    hold on
    plot(x2,y2,'b','LineWidth',2)
    hold off
    %subimage matting
    R = image_pad(:,:,1);
    G = image_pad(:,:,2);
    B = image_pad(:,:,3);
    subimage2(:,:,1) = R.*uint8(mask2);
    subimage2(:,:,2) = G.*uint8(mask2);
    subimage2(:,:,3) = B.*uint8(mask2);
    imwrite(subimage2, 'rearwall.png');
    figure;
    imshow(subimage2);
    
    %right wall, vertices: P8, P12, P6, P2
    x3 = [Points(1,8) Points(1,12) Points(1,6) Points(1,2) Points(1,8)];
    y3 = [Points(2,8) Points(2,12) Points(2,6) Points(2,2) Points(2,8)];
    mask3 = poly2mask(x3,y3,size(image_pad,1),size(image_pad,2));
    imshow(mask3)
    hold on
    plot(x3,y3,'b','LineWidth',2)
    hold off
    %subimage matting
    R = image_pad(:,:,1);
    G = image_pad(:,:,2);
    B = image_pad(:,:,3);
    subimage3(:,:,1) = R.*uint8(mask3);
    subimage3(:,:,2) = G.*uint8(mask3);
    subimage3(:,:,3) = B.*uint8(mask3);
    imwrite(subimage3, 'rightwall.png');
    figure;
    imshow(subimage3);
    
    %ceiling, vertices: P9, P10, P8, P7
    x4 = [Points(1,9) Points(1,10) Points(1,8) Points(1,7) Points(1,9)];
    y4 = [Points(2,9) Points(2,10) Points(2,8) Points(2,7) Points(2,9)];
    mask4 = poly2mask(x4,y4,size(image_pad,1),size(image_pad,2));
    imshow(mask4)
    hold on
    plot(x4,y4,'b','LineWidth',2)
    hold off
    %subimage matting
    R = image_pad(:,:,1);
    G = image_pad(:,:,2);
    B = image_pad(:,:,3);
    subimage4(:,:,1) = R.*uint8(mask4);
    subimage4(:,:,2) = G.*uint8(mask4);
    subimage4(:,:,3) = B.*uint8(mask4);
    imwrite(subimage4, 'ceiling.png');
    figure;
    imshow(subimage4);
    
    %floor, vertices: P1, P2, P4, P3
    x5 = [Points(1,1) Points(1,2) Points(1,4) Points(1,3) Points(1,1)];
    y5 = [Points(2,1) Points(2,2) Points(2,4) Points(2,3) Points(2,1)];
    mask5 = poly2mask(x5,y5,size(image_pad,1),size(image_pad,2));
    imshow(mask5)
    hold on
    plot(x5,y5,'b','LineWidth',2)
    hold off
    %subimage matting   
    R = image_pad(:,:,1);
    G = image_pad(:,:,2);
    B = image_pad(:,:,3);
    subimage5(:,:,1) = R.*uint8(mask5);
    subimage5(:,:,2) = G.*uint8(mask5);
    subimage5(:,:,3) = B.*uint8(mask5);
    imwrite(subimage5, 'floor.png');
    figure;
    imshow(subimage5);

end