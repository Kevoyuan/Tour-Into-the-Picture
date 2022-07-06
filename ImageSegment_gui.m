function [foreground,background] = ImageSegment(im1,n,patchsize,fillorder,f) 
    h = figure('Name','foreground and background separation','Position',[0,0,700,400]);
    imshow(im1)
    background = im1;
    foreground = zeros(size(background));
    ROI = cell(n,1);
    for i = 1:n
        % mannually draw a ROI based on edge detection
        ROI{i}= drawassisted;
        
        % double click the ROI when you are finished with editing
        wait(ROI{i});
    end
    d = uiprogressdlg(f,'Title','image rendering','Indeterminate','on','Cancelable','on');
    for i = 1:n
        % separate the foreground mask and background picture
        foregroundmask(:,:,i) =  createMask(ROI{i});
        foreground = foreground + foregroundmask(:,:,i);
    
        background = inpaintExemplar(background,foregroundmask(:,:,i),"PatchSize",patchsize,"FillOrder",fillorder);
        %background = regionfill(background,foregroundmask(:,:,i));
    end
    close(d)
    close(h)
end