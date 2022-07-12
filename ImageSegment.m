function [foreground,background] = ImageSegment(im1,n,patchsize,fillorder)
    background = im1;
    foreground = zeros(size(background));
    for i = 1:n
        % mannually draw a ROI based on edge detection
        ROI= drawassisted;
        
        % double click the ROI when you are finished with editing
        wait(ROI);
    
        % separate the foreground mask and background picture
        foregroundmask(:,:,i) =  createMask(ROI);
        foreground = foreground + foregroundmask(:,:,i);
    
        background = inpaintExemplar(background,foregroundmask(:,:,i),"PatchSize",patchsize,"FillOrder",fillorder);
        %background = regionfill(background,foregroundmask(:,:,i));
        imshow(background);
    end
end