function [vec_res] = kNN_test(test_all, train_all, k)


% kNN�Ĳ��Թ��̣���Ҫѵ�����ݲ���
% train_all��һ��һ�����������һ���������
% test_all��һ��һ�����������һ���������
% k�����ڸ���


% Ԥ����
train_num = size(train_all,1); % ѵ����������
test_num = size(test_all,1); % ������������
c = max(train_all(:,end)); % �������
label_train = train_all(:,end); % ѵ����������� 
label_test = test_all(:,end); % �������������
label_pre = [];

for i_test = 1:test_num
    vec_dist = pdist2(train_all(:,1:end-1),test_all(i_test,1:end-1),'euclidean');
    mat_dist = [vec_dist,label_train]; % ��һ���Ǻ�ѡ�����ľ��룬�ڶ����Ǻ�ѡ�����������
    pre_now = get_k_neighbor(mat_dist,c,k); % ����ѵ��ʱ�õ������ݺ������Ԥ�⵱ǰ���������������
    label_pre = [label_pre;pre_now];
end%for_i_test

% ͳ��һ�ֵĽ��
vec_res = get_binary_evaluate(label_pre, label_test);

end%function


