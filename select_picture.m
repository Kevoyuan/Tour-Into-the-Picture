rgbImage = imread('peppers.png');
ROI = roipoly(rgbImage); % Select a closed polygon
subplot(3, 1, 1);
imshow(rgbImage);
axis('on', 'image');
title('Original Image');

% Mask the image using bsxfun() function to multiply the mask by each channel individually.
maskedRgbImage = bsxfun(@times, rgbImage, cast(ROI, 'like', rgbImage));
whos maskedRgbImage

% Display the masked image.
subplot(3, 1, 2);
imshow(maskedRgbImage);
axis('on', 'image');
title('Masked Image');

% Save the masked image to disk.
imwrite(maskedRgbImage, 'newImage.png');
I2 = imread('newImage.png');
whos I2
% Display the image read in from disk.
subplot(3, 1, 3);
imshow(I2);
axis('on', 'image');
title('Image read In From Disk');