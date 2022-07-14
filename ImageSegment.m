function [fg2D,foreground,background] = ImageSegment(im1,n,patchsize,fillorder)
    background = im1;
    foreground = cell(1,n);
    fg2D = cell(1,n);
    figure;
    imshow(background);
    for i = 1:n
        % mannually draw a ROI based on edge detection
        ROI= drawrectangle;
        
        % double click the ROI when you are finished with editing
        wait(ROI);
        UpperleftPoint = [ROI.Position(1);ROI.Position(2)];
        UpperrightPoint = [ROI.Position(1)+ROI.Position(3);ROI.Position(2)];
        LowerleftPoint = [ROI.Position(1);ROI.Position(2)+ROI.Position(4)];
        LowerrightPoint = [ROI.Position(1)+ROI.Position(3);ROI.Position(2)+ROI.Position(4)];
        fg2D{i} = [UpperleftPoint,UpperrightPoint,LowerleftPoint,LowerrightPoint];
        % separate the foreground mask and background picture
        foregroundmask =  createMask(ROI);
        foreground{i} = bsxfun(@times,im1, cast(foregroundmask, 'like', im1)); 
    
        background = inpaintExemplar(background,foregroundmask,"PatchSize",patchsize,"FillOrder",fillorder);
        %background = regionfill(background,foregroundmask(:,:,i));
        imshow(background);
    end
end