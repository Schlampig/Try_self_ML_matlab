function [train_sub] = get_undersample(train_all, ratio)

% ������ratio����²���train_all��ĸ���������������ѵ����train_sub
% train_all, train_sub: ��������һ��һ�����������һ����label
% ratio�� �²�������������0��1֮��

% �����ݼ�Ϊ������
value_label = unique(train_all(:,end));
train_label = train_all(:,end);
if length(value_label) ~= 2   
    disp('Not a binary problem for undersampling!');
else
    if sum(train_label == value_label(1)) >= sum(train_label == value_label(2))
        train_pos = train_all(find(train_label == value_label(2)),:);
        train_neg = train_all(find(train_label == value_label(1)),:);
    else
        train_pos = train_all(find(train_label == value_label(1)),:);
        train_neg = train_all(find(train_label == value_label(2)),:);
    end%if
end%if

% �����²�����Ŀ
n_pos = size(train_pos,1);
n_neg = size(train_neg,1);
new_n_neg = n_pos*(1 + ratio);
if new_n_neg > n_neg
    new_n_neg = n_neg;
end%if

% ����²���
index_neg = randperm(n_neg);
new_train_neg = train_neg(index_neg(1:new_n_neg),:);

% ������������
train_sub = [new_train_neg; train_pos];

end % function