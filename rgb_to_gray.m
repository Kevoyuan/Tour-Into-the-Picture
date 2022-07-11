function gray_image = rgb_to_gray(input_image)
    % This function is supposed to convert a RGB-image to a grayscale image.
    % If the image is already a grayscale image directly return it.
      
      img = input_image;
      if size(img, 3)==3
%             double R;double G; double B;
            R=double(img(:, :, 1));
            G=double(img(:, :, 2));
            B=double(img(:, :, 3));

            [M, N]=size(B);

            
            % creating a new 2-d matrix 'gray_img' of size M*N of 'uint8' data type with all 
            % elements  as zero 
            gray_image=zeros(M, N, 'uint8');
            
            % calculating grayscale values by forming a weighted sum of the R, G, and B components
            % for each pixel
            for i=1:M
                for j=1:N
                   gray_image(i, j)=(R(i, j)*0.299)+(G(i, j)*0.587)+(B(i, j)*0.114);
                end
            end
            gray_image=uint8(gray_image);
      else 
          gray_image = input_image;
    
end