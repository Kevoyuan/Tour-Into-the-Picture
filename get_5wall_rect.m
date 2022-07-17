function [leftwall_rec,rearwall_rec,rightwall_rec,ceiling_rec,floor_rec] = get_5wall_rect(P,Img_pad,leftwall,rearwall,rightwall,ceiling,floor)
%P:new_TwelfPoints_vp
outH = size(Img_pad,1);
outW = size(Img_pad,2);

%figure('Name', 'after perspective transformation', 'Position', [0, 0, 700, 400]);
%subplot(3, 3, 4);
if sum(sum(sum(leftwall)))==0
    
else
    leftwall_rec = Perspective_transform(leftwall, P(:,11)', P(:,7)', P(:,5)', P(:,1)', outH, outW);
end

%subplot(3, 3, 5);
rearwall_rec = Perspective_transform(rearwall, P(:,7)', P(:,8)', P(:,1)', P(:,2)', outH, outW);

%subplot(3, 3, 6);
if sum(sum(sum(rightwall)))==0
    
else
    rightwall_rec = Perspective_transform(rightwall, P(:,8)', P(:,12)', P(:,2)', P(:,6)', outH, outW);
end

%subplot(3, 3, 2);
if sum(sum(sum(ceiling)))==0
    
else
    ceiling_rec = Perspective_transform(ceiling, P(:,9)', P(:,10)', P(:,7)', P(:,8)', outH, outW);
end

%subplot(3, 3, 8);
floor_rec = Perspective_transform(floor, P(:,1)', P(:,2)', P(:,3)', P(:,4)', outH, outW);

end