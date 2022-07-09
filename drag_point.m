clc


Image2 = imread('shopping-mall.png');
figure;
imshow(Image2);
hold on

MouseControl(gca,Updated_BorderPoint,Image2);


function MouseControl(~,BorderPoint,img)


P = BorderPoint;

% image size

[m, n] = size(img);

% 1: cast; 0: release

mouseSign = 0;

% initialze

Pscatter_fig = plot(P(:, 1), P(:, 2), 's', 'MarkerSize', 10, ...
    'MarkerEdgeColor', 'red', 'MarkerFaceColor', 'r');

hold on

%     Pplot_fig = plot(P(:, 1), P(:, 2), 'g');

%     hold on

% axis([0 m 0 n])

% callback

set(gcf, 'WindowButtonMotionFcn', @ButtonMotionFcn, ...
    'WindowButtonDownFcn', @ButttonDownFcn, 'WindowButtonUpFcn', @ButttonUpFcn);

% mouse move

    function ButtonMotionFcn(~, ~)

        % drag point sensitive
        sen = max(m,n)/30;





        if mouseSign == 1

            % call back current position

            mousePoint = get(gca, 'CurrentPoint');



            mousePonit_x = mousePoint(1, 1);

            mousePonit_y = mousePoint(1, 2);


%             % x = 0
%             if -sen < mousePoint(1, 1) && mousePoint(1, 1) < sen
% 
% %                 mousePonit_x = 0.5;
%                 
%                 mousePonit_y = mousePoint(1, 2);
% 
% 
%             % y = 0
%             elseif -sen <mousePoint(1, 2) && mousePoint(1, 2) < sen
% 
% %                 mousePonit_x = mousePoint(1, 1);
%                 %
%                 mousePonit_y = 0.5;
% 
% 
%             % x = max
%             elseif (n-sen) < mousePoint(1, 1) && mousePoint(1, 1) < (n+sen)
% 
% %                 mousePonit_x = n+0.5;
% %                 disp(mousePonit_x)
%                 %
%                 mousePonit_y = mousePoint(1, 2);
%                 
% 
% 
%             % y = max
%             elseif (m - sen)<mousePoint(1, 2) && mousePoint(1, 2) <(m+sen)
% 
%                 mousePonit_x = mousePoint(1, 1);
%                 %
% %                 mousePonit_y = m+0.5;
%                 %             else
%                 %                 nothing = mousePoint(1, 1);
%                 %
%                 %                 nothing = mousePoint(1, 2);
%             end


            % distance from mouse position to target

            dis = zeros;

            for i = 1:size(P, 1)

                dis(i, 1) = sqrt((P(i, 1) - mousePonit_x)^2 + (P(i, 2) - mousePonit_y)^2);

            end

            [val, row] = min(dis);

            % determin the drag range

            if val <= max(m,n)/90

                P(row, 1) = mousePonit_x;

                P(row, 2) = mousePonit_y;

                % delete old fig

                delete(Pscatter_fig)

                %             delete(Pplot_fig)

                %         clf (gcf)

                % update fig

                Pscatter_fig = plot(P(:, 1), P(:, 2), 's', 'MarkerSize', 10, ...
                    'MarkerEdgeColor', 'red', 'MarkerFaceColor', 'r');

                hold on

                %             Pplot_fig = plot(P(:, 1), P(:, 2), 'g');

                %             hold on
                %             [xmin xmax ymin ymax]
                %                 axis([0 m 0 n])
                disp(P)

            end

        end

    end

% drag

    function ButttonDownFcn(~, ~)

        switch(get(gcf, 'SelectionType'))

            case 'normal'

                mouseSign = 1;

                str = 'left click';

            case 'alt'

                str = 'right click/ctrl+left';

            case 'open'

                str = 'double click';

            otherwise

                str = 'other';

        end

        disp(str);

    end

% release

    function ButttonUpFcn(~, ~)

        mouseSign = 0;

        disp('release')

    end

end

