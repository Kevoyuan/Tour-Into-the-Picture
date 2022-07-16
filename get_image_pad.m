function [image_pad,origin_image_pad,new_Pixel_Vertex,new_fg2D] = get_image_pad(background,Img,Pixel_Vertex,fg2D)
    % Img: original input image
    % background: image of background after image segmentation
    % Pixel_Vertex: positions of Point1~Point13, size = 2 * 13
    % Pixel_Vertex= [x1,x2,...x13; y1, y2,...y13]
    % fg2D: 2*4 matrix that saves positions of foreground objects

    max_pad = 0;
    %iterate the 2D coordinates of 13 points, in order to find max absolute
    %x/y-coordinate
    for i = 1:2
        for j = 1:13
            if(Pixel_Vertex(i,j)<0 && -Pixel_Vertex(i,j)>max_pad)
                max_pad = -Pixel_Vertex(i,j);
            end
        end
    end

    max_pad = ceil(max_pad+0.1*size(background,1));

    %extend border for background image
    Zeros_border = zeros(size(background,1)+2*max_pad, size(background,2)+2*max_pad,3);
    Zero_border = gray2ind(Zeros_border);
    Zero_border((max_pad+1):(end-max_pad), (max_pad+1):(end-max_pad), :) = background;
    image_pad = Zero_border;
    imwrite(image_pad,'input_image_pad.png');
    
    %extend border for original input image
    Zeros_border = zeros(size(Img,1)+2*max_pad, size(Img,2)+2*max_pad,3);
    Zero_border = gray2ind(Zeros_border);
    Zero_border((max_pad+1):(end-max_pad), (max_pad+1):(end-max_pad), :) = Img;
    origin_image_pad = Zero_border;

    %get the 2D coordinates of 13 points in new image after padding
    new_Pixel_Vertex = zeros(2,13);
    for r = 1:2
        for t = 1:13
            new_Pixel_Vertex(r,t) = Pixel_Vertex(r,t)+max_pad;
        end
    end
    
    %get the 2D coordinates of foreground object in new image after padding
    n = size(fg2D,2);
    new_fg2D = zeros(2,n);
    for r = 1:2
        for t = 1:n
            new_fg2D(r,t) = fg2D(r,t)+max_pad;
        end
    end
    
end
