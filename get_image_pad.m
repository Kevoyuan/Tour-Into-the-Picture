function [image_pad, new_Pixel_Vertex] = get_image_pad(input_image, Pixel_Vertex)    
    max_pad = 0;
    %iterate the 2D coordinates of 12 points, in order to find max absolute
    %x/y-coordinate
    for i = 1:2
        for j = 1:12
            if(Pixel_Vertex(i,j)<0 && -Pixel_Vertex(i,j)>max_pad)
                max_pad = -Pixel_Vertex(i,j);
            end
        end
    end
            
    Zeros_border = zeros(size(input_image,1)+2*max_pad, size(input_image,2)+2*max_pad,3);
    Zero_border = gray2ind(Zeros_border);
    Zero_border((max_pad+1):(end-max_pad), (max_pad+1):(end-max_pad), :) = input_image;
    image_pad = Zero_border;
    imwrite(image_pad,'oil-painting_pad.png');
    
    %get the 2D coordinates of 12 points in new image after padding
    new_Pixel_Vertex = zeros(2,12);
    for r = 1:2
        for t = 1:12
            new_Pixel_Vertex(r,t) = Pixel_Vertex(r,t)+max_pad;
        end
    end
                       
end
