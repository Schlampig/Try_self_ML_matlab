function [y] = friedman_sort(x)

% ����Friedman�����е�����ʽ�����������x�����������
% ����ͬ����rankֵ��ͬ��Ϊ��Щ����ռ�õ�ԭʼ��λֵ�ľ�ֵ������3-5λ��ͬ����ôrank��Ϊmean([3,4,5])=4������Խ������ֵԽС��
% x��������������
% y������������Ӧxÿ��Ԫ�ص�rankֵ

[x_sort,I_tempor] = sort(x);
[~,I] = sort(I_tempor);
x_sort = [x_sort,max(x_sort)+1]; %���һλΪԤ��λ�����������
i=1;
j=1;
x_rank = [];
while (i<length(x_sort))
    if x_sort(i) == x_sort(i+1)
        i = i + 1;
    else
        x_rank = [x_rank,((i+j)/2)*ones(1,i-j+1)];
        i = i + 1;
        j = i;
    end%if
end%while

y = x_rank(I);

end%function