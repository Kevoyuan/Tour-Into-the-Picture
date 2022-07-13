function [foreground,background] = ImageSegment(im1,n,patchsize,fillorder)
    background = im1;
    % preallocate space for output cell
    foreground = cell(1,n);
    figure;
    imshow(im1);
    for i = 1:n
        % mannually draw a ROI
        ROI= drawrectangle;
        
        % double click the ROI when you are finished with editing
        wait(ROI);
    
        % separate the foreground mask and background picture
        foregroundmask =  createMask(ROI);

        % cut out the foreground object and save it in the foreground cell
        maskedrgbimage = bsxfun(@times,im1, cast(foregroundmask, 'like', im1));
        foreground{i} = maskedrgbimage;
        
        % all the corners of the ROI is needed for further processing of
        % the foreground objects
        

        % merge the backgound
        background = inpaintExemplar(background,foregroundmask,"PatchSize",patchsize,"FillOrder",fillorder);
        % refresh the background picture
        imshow(background);
    end
end