function [train_sub] = get_CRUS(train_all, par)

% ������ratio����²���train_all��ĸ���������������ѵ����train_sub
% train_all, train_sub: ��������һ��һ�����������һ����label
% ratio���²�������������0��1֮��

% ��ֵ
k = par.k;
ratio = par.ratio;

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

% ����IR
n_pos = size(train_pos,1);
n_neg = size(train_neg,1);
if n_pos == 0
    IR = 1;
else
    IR = n_neg/n_pos - ratio;
    if IR < 1
        IR = 1;
    end%if
end%if

% ����
[neg_index, ~] = kmeans(train_neg(:,1:end-1),k);

% ÿ����������������²���������ѵ����
% p = n/IR = (n1+n2+...+nk)/IR = n1/IR + n2/IR + ... + nk/IR = c1 + c2 + ...+ ck
train_neg_new = [];
for i=1:k
   cluster_i = train_neg(find(neg_index == i),:); % ��ǰ����ɵ����ݼ�
   n_i = size(cluster_i,1); % ��ǰ������������
   c_i = round(n_i/IR); % ��ǰ�ز�����������
   index_i = randperm(n_i); % ���ҵ�ǰ���������
   train_neg_new = [train_neg_new;cluster_i(index_i(1:c_i),:)];
   clear cluster_i; clear n_i; clear c_i; clear index_i
end
train_sub = [train_pos;train_neg_new]; % �����ĸ�����ԭ��������ϲ����µ�ѵ����


end % function