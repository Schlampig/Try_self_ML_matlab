function [aspect] = randwithoutre(X)

%Ŀ�꣺����ͬһ��������������Լ��������10�ݣ�10��cell��������һ��cell�ﷵ��
%X��ÿ��һ�������������ţ�������ά��
%���һ������Ϊaspect��cell,�������10����cell��ÿ��cell��ÿһ����һ��ѵ������

sample_num = size(X,1);%��ʼ��
select_index = randperm(sample_num);%��������
r = 1;

while sample_num > 9
    aspect{1,1}(r,:) = X(select_index(1),:);
    aspect{1,2}(r,:) = X(select_index(2),:);
    aspect{1,3}(r,:) = X(select_index(3),:);
    aspect{1,4}(r,:) = X(select_index(4),:);
    aspect{1,5}(r,:) = X(select_index(5),:);
    aspect{1,6}(r,:) = X(select_index(6),:);
    aspect{1,7}(r,:) = X(select_index(7),:);
    aspect{1,8}(r,:) = X(select_index(8),:);
    aspect{1,9}(r,:) = X(select_index(9),:);
    aspect{1,10}(r,:) = X(select_index(10),:);
    select_index = select_index(11:end);%����ѡ����index
    if isempty(select_index) == 1
        sample_num = 0;
    else
        sample_num = length(select_index);
    end
    r = r + 1;
end

if sample_num >= 1 %ʣ�µ�����
    for i = 1: sample_num
        aspect{1,i}(r,:) = X(select_index(i),:);
    end
end
    

end

















