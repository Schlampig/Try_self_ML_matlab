function [data_cell] = sample_partition(data_mat, ratio, n_cell)

% ��һ�����ݼ�����ת��Ϊ���ж��cell�����ݼ����壬ÿ��cell��������������������ƽ��
% data_mat:���ݼ�����һ��һ�����������һ����label��ֻ���Ƕ����࣬label={1,2}
% ratio: ����������*��1+ratio��= ɸѡ���ĸ���������
% n_cell:���ɵİ������
% data_cell:һ��1*n_cell�İ��壬ÿ��cell���sub���ݼ�(����)

data_pos = data_mat(find(data_mat(:,end)==2),:);% �������
data_neg = data_mat(find(data_mat(:,end)==1),:);% �������
n_pos = size(data_pos,1);
n_neg = size(data_neg,1);

if n_pos > n_neg %����ȸ���࣬��������
    data_temp = data_pos;
    data_pos = data_neg;
    data_neg = data_temp;
end

if n_pos* (1+ratio) > n_neg % ��ƽ���ʵͣ�����ratio
    ratio = n_neg/n_pos - 1;
end

n_neg_new = floor(n_pos*(1+ratio));

r = 1; %��¼�������
for i_cell = 1:n_cell
    neg_index = randperm(n_neg);
    new_neg_index = neg_index(1:n_neg_new);
    data_cell{r} = [data_neg(new_neg_index,:); data_pos];
    r = r + 1;
end%for_i_cell

end % function