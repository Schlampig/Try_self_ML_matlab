function [forest] = CRUSRF_train(train_all, T, k)

% ѵ��k��ֵ��������²��������ɭ���㷨��������
% train_all: ���ݼ�����һ��һ�����������һ��������ǣ�min(label) = 1
% T�� ���ɭ�����ĸ���
% k�� k��ֵ�������
% forest: ���ɭ��ģ�ͣ��ṹ��

% Ԥ����
label_all = train_all(:,end);
n1 = sum(label_all == min(label_all)); % label��ֵ��С�������ĸ���
n2 = length(label_all) - n1;
if n1 <= n2 % ���n2������
    pos_all = train_all(find(label_all == min(label_all)),:);
    neg_all = train_all(find(label_all ~= min(label_all)),:);
else
    pos_all = train_all(find(label_all ~= min(label_all)),:);
    neg_all = train_all(find(label_all == min(label_all)),:);
end%if
if size(pos_all,1) ~=0 % ���������࣬��ƽ����IR = n/p
    IR = size(neg_all,1)/size(pos_all,1);
else
    IR = 1;
end%if

% ����
[neg_index, neg_center]=kmeans(neg_all(:,1:end-1),k);

% ÿ����������������²���������ѵ����
% p = n/IR = (n1+n2+...+nk)/IR = n1/IR + n2/IR + ... + nk/IR = c1 + c2 + ...+ ck
neg_new = [];
for i=1:k
   cluster_i = neg_all(find(neg_index == i),:); % ��ǰ����ɵ����ݼ�
   n_i = size(cluster_i,1); % ��ǰ������������
   c_i = round(n_i/IR); % ��ǰ�ز�����������
   index_i = randperm(n_i); % ���ҵ�ǰ���������
   neg_new = [neg_new;cluster_i(index_i(1:c_i),:)];
   clear cluster_i; clear n_i; clear c_i; clear index_i
end
train_new = [pos_all;neg_new]; % �����ĸ�����ԭ��������ϲ����µ�ѵ����

% ѵ��
forest = TreeBagger(T,train_new(:,1:end-1),train_new(:,end), 'Method', 'classification');%����ѵ��

end % function