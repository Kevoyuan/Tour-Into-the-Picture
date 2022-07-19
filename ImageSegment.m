function [fg2D,foreground,background] = ImageSegment(im1,n,patchsize,fillorder)
    % initial settings
    background = im1;
    foreground = cell(1,n);
    fg2D = cell(1,n);
    h = figure('Position',[600,100,600,600]);
    imshow(background);
    ROI = cell(n,1);
    
    for i = 1:n
%         % mannually draw a rectangle shaped ROI 
%         ROI= drawrectangle;
%         
%         % double click the ROI when you are finished with editing
%         wait(ROI);
%         UpperleftPoint = [ROI.Position(1);ROI.Position(2)];
%         UpperrightPoint = [ROI.Position(1)+ROI.Position(3);ROI.Position(2)];
%         LowerleftPoint = [ROI.Position(1);ROI.Position(2)+ROI.Position(4)];
%         LowerrightPoint = [ROI.Position(1)+ROI.Position(3);ROI.Position(2)+ROI.Position(4)];
%         fg2D{i} = [UpperleftPoint,UpperrightPoint,LowerleftPoint,LowerrightPoint];

        % mannually draw a polygon shaped ROI 
        ROI{i} = drawpolygon;
        X = ROI{i}.Position;
        X = X';
        
        Mfg = zeros(size(X));
        [~,I] = sort(X(1,:));
        if X(2,I(1)) > X(2,I(2))
            Mfg(:,1) = X(:,I(1));
            Mfg(:,4) = X(:,I(2));
        else 
            Mfg(:,1) = X(:,I(2));
            Mfg(:,4) = X(:,I(1));
        end
        
        if X(2,I(3)) > X(2,I(4))
            Mfg(:,2) = X(:,I(3));
            Mfg(:,3) = X(:,I(4));
        else 
            Mfg(:,2) = X(:,I(4));
            Mfg(:,3) = X(:,I(3));
        end
        fg2D{i} = Mfg;
        
%         % mannually draw a ROI based on edge detection
%         ROI = drawassisted;
%         X = ROI.Position;
%         X = X';
%         fg2D{i} = X;

        wait(ROI{i});
    end
    d = waitbar(0.2,'image rendering');
    for i = 1:n
        % separate the foreground mask and background picture
        foregroundmask =  createMask(ROI{i});
        foreground{i} = bsxfun(@times,im1, cast(foregroundmask, 'like', im1)); 
    
        background = inpaintExemplar(background,foregroundmask,"PatchSize",patchsize,"FillOrder",fillorder);
        %background = regionfill(background,foregroundmask(:,:,i));
        waitbar(i/n,d,'image rendering');
        delete(ROI{i});
    end
    close(d)
    close(h)
end