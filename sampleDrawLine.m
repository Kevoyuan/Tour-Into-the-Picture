hIm = imshow(imread('metro-station.png'));
hIm.ButtonDownFcn = @(~,~) buttonPressedCallback(hIm.Parent);
 
function buttonPressedCallback(hAx)
    cp = hAx.CurrentPoint;
    cp = [cp(1,1) cp(1,2)];
    obj = images.roi.Line('Parent',hAx,'Color',rand([1,3]));
    beginDrawingFromPoint(obj,cp);
end