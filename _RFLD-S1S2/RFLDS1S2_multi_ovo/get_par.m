function [par] = get_par(data,size,w,mean_vec,tag)

% ����������ͶӰ��ֵ�����ض�����
% data:��������һ��һ������ NxD
% size:������������� N
% mean_vec:���������Ӧ��ͶӰ��ֵ 1x1
% w:Ȩ��������1xD
% tag:��Ϊ0��ȡ�������ģ����Ϊ1��ȡ��ֵ

if tag == 0
    par = sum(abs(data*w - mean_vec))/sqrt(size-1);
elseif tag == 1
    par = sum(abs(data*w - mean_vec))/size;
else
    par = 0; % ��Ĭ��û��ƫ��
end%if

end%function