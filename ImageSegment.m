function [foreground,background] = ImageSegment(im1,n,patchsize,fillorder)
    background = im1;
    foreground = cell(1,n);
    figure;
    imshow(background);
    for i = 1:n
        % mannually draw a ROI based on edge detection
        ROI= drawrectangle;
        
        % double click the ROI when you are finished with editing
        wait(ROI);
    
        % separate the foreground mask and background picture
        foregroundmask =  createMask(ROI);
        foreground{i} = bsxfun(@times,im1, cast(foregroundmask, 'like', im1)); 
    
        background = inpaintExemplar(background,foregroundmask,"PatchSize",patchsize,"FillOrder",fillorder);
        %background = regionfill(background,foregroundmask(:,:,i));
        imshow(background);
    end
end