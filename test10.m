% Plot a line and points
figure

clc


Image2 = imread('shopping-mall.png');

imshow(Image2);
hold on
P = Updated_BorderPoint;
global m
global n
global P
[m, n] = size(Image2);





plot(P(:, 1), P(:, 2),'s', 'MarkerSize', 10,'MarkerEdgeColor', 'red', 'MarkerFaceColor', 'r', ...
    'buttondownfcn',{@Mouse_Callback,'down'});

% Callback function for each point
function Mouse_Callback(hObj,~,action)
persistent curobj xdata ydata ind
pos = get(gca,'CurrentPoint');
global m
global n
global P


switch action
  case 'down'
      curobj = hObj;
      xdata = get(hObj,'xdata');
      ydata = get(hObj,'ydata');
      [~,ind] = min(sum((xdata-pos(1)).^2+(ydata-pos(3)).^2,1));
      set(gcf,...
          'WindowButtonMotionFcn',  {@Mouse_Callback,'move'},...
          'WindowButtonUpFcn',      {@Mouse_Callback,'up'});
  case 'move'

      if (xdata(ind) == 0.5) || (xdata(ind) == m)
          % vertical move
          ydata(ind) = pos(3);
          set(curobj,'ydata',ydata)
      elseif (ydata(ind) == 0.5) || (ydata(ind) == n)
          % vertical move
          xdata(ind) = pos(1);
          set(curobj,'xdata',xdata)
      end

%       % vertical move
%       xdata(ind) = pos(1);
%       set(curobj,'xdata',xdata)
  case 'up'
      set(gcf,...
          'WindowButtonMotionFcn',  '',...
          'WindowButtonUpFcn',      '');

    disp(P);
end
end