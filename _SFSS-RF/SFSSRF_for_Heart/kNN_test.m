function [label_pre] = kNN_test(test_all, train_all, c, k, tag)


% kNN�Ĳ��Թ��̣���Ҫѵ�����ݲ���
% train_all��һ��һ�����������һ���������
% test_all��һ��һ�����������һ���������
% k�����ڸ���
% c: �������
% tag: ѡ���������
% label_pre: Ԥ�������

% Ԥ����
test_num = size(test_all,1); % ������������
label_train = train_all(:,end); % ѵ�����������

label_pre = [];
for i_test = 1:test_num
    if tag == 1 % ѡ������������
        vec_dist = pdist2(train_all(:,1:end-1),test_all(i_test,1:end-1),'jaccard');
    elseif tag == 0
        vec_dist = pdist2(train_all(:,1:end-1),test_all(i_test,1:end-1),'euclidean');
    end%if
    mat_dist = [vec_dist,label_train]; % ��һ���Ǻ�ѡ�����ľ��룬�ڶ����Ǻ�ѡ�����������
    pre_now = get_k_neighbor(mat_dist,c,k); % ����ѵ��ʱ�õ������ݺ������Ԥ�⵱ǰ���������������
    label_pre = [label_pre;pre_now];
end%for_i_test

end%function


