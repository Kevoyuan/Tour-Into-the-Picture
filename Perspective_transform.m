function rectangle = Perspective_transform(input_image, pLT, pRT, pLB, pRB, outH, outW)
    %the input_image here, we use the individual image of 5 regions
    %pLT/pLB:point at left top/bottom;pRT/pRB:point at right top/bottom
    %outH, outW: the Height and Width of the output image
    [imgInHeight,imgInWidth,imgInDimension] = size(input_image);
    %To get central projection transformation, the 4 vertices need to be
    %converted into three vectors
    
    vector1 = pLB - pLT;
    vector2 = pRT - pLT;
    vector3 = pRB - pLT;
    
    %vector3 as a linear combination of vector1 and vector2, so that the
    %three vectors can be coplanar
    A = [vector1', vector2'];
    B = vector3';
    S = A\B;
    a0 = S(1);
    a1 = S(2);
    
    %generate the rectangle
    rectangle = uint8(zeros(outH,outW,imgInDimension));
    
    %use Loop operation to assign values to each pixel
    for i = 1:outH
        for j = 1:outW
            x0 = i/outH;
            x1 = j/outW;
            %denom: denominator
            denom = a0+a1-1+(1-a1)*x0+(1-a0)*x1;  
            y0 = a0*x0/denom;
            y1 = a1*x1/denom;
            
            %find the coordinates in the corresponding source image
            %according to the obtained parameters, and assign a value
            OriCoord = y0*vector1 + y1*vector2 + pLT;
            heightC = round(OriCoord(2));
            widthC = round(OriCoord(1));
            
%             if (heightC>imgInHeight || heightC<=0 || widthC>imgInWidth || widthC<=0)
%                 disp(['Perspective_transform out of range' num2str(heightC) num2str(widthC)]);               
%                 pause();
%                 return;
%             end   

            if heightC>imgInHeight
                heightC = imgInHeight;
            elseif heightC<=0
                heightC = 1;
            end
            
            if widthC>imgInWidth
                widthC = imgInWidth;
            elseif heightC<=0
                widthC = 1;
            end
                                              
            for k = 1:imgInDimension
                rectangle(i,j,k) = input_image(heightC,widthC,k);
            end            
        end
    end
    
%     figure;
%     imshow(rectangle);
%     title('after perspective transformation');
    
end
