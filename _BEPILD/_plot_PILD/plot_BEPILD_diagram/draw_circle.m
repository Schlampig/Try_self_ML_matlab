function draw_circle

num = 400;
r = 30;
center = 0;
test_point = [30,30]; %�����ĵ㣨Ӱ�����ĺͱ߽磩
x = [-35,35];
data = - r + (2*r).*rand([num,2]);%������(-r,r)������������
points = cal_circle(data(:,1),data(:,2),r,center);%����ѵ����
centroid = mean(points);%ѵ����������
centroid_new = mean([points;test_point]);%�����������������
[points_margin] = cal_margin_points(points,r);%ѵ�����ı߽�
[points_margin_new] = cal_margin_points([points;test_point],r);%������������ѵ�����ı߽�

figure;
plot(points(:,1),points(:,2),'bo',...
    test_point(1),test_point(2),'bs',...
    centroid(1),centroid(2),'k*',...
    centroid_new(1),centroid(2),'rx',...
    points_margin(:,1),points_margin(:,2),'k-',...
    points_margin_new(:,1),points_margin_new(:,2),'r-.',...
    'LineWidth',2.5,'MarkerSize',10);
title('iii) Relatively large training set','fontsize',24,'fontname','Times New Roman','fontweight','bold');
legend('Training data','New sample','Old centroid','New centroid','Old boundary','New boundary','fontsize',18,'fontname','Times New Roman','location','NorthEastOutside');
axis([min(x),max(x),min(x),max(x)]); 
grid on;


end%function_draw_circle


function [points] = cal_circle(x,y,r,c)
    n = size(x,1);
    vec_one = ones(n,1);
    r_diff = (x - c*vec_one).^2 + (y - c*vec_one).^2; % r^2 = x^2 + y^2
    index = find(r_diff <= r^2);
    x_new = x(index);
    y_new = y(index);
    points = [x_new,y_new];
end%function_cal_circle


function [points_margin] = cal_margin_points(points,radius)
    theta = [];
    r = [];
    n = size(points,1);
    for i = 1:n
        theta = [theta;atan2(points(i,2),points(i,1))]; % theta = atan(y/x)
        r = [r;sqrt(points(i,1)^2 + points(i,2)^2)];
    end%for_i
    points = [points,theta,r];
    [~,j] = sortrows(points,3);%�������㰴�Ƕȴӵڶ�����˳ʱ������
    points_margin = points(j,:);
    points_margin = [points_margin;points_margin(1,:)];%��β����γɱպ���
    index = [];%��¼������͹���ĵ㣨�Ǳ߽�㣩
    for k = 1:(n+1)
        if (radius - points_margin(k,4)) > 0.1*radius
            index = [index;k];
        else
            continue;
        end%if
    end
    points_margin(index,:) = [];
end%function_cal_margin_points









