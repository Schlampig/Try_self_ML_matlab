function [res] = ABRS_fun(train_all, test_all, par)


% ABRS_svm������ܣ�Ŀǰֻ�����ڶ��������⣬������Ϊ2������Ϊ1
% train_all/test_all�� ѵ��/���Ծ���һ��һ�����������һ����lable��min(label)=1
% par����¼����Ĳ���������par.model����ѡ���������

% Ԥ����
IR = length(find(train_all(:,end)==2))/length(find(train_all(:,end)==1));%���㷴��ƽ����
neg_all = train_all(find(train_all(:,end)==1),:);% �������ݼ�����
pos_all = train_all(find(train_all(:,end)==2),:);% �������ݼ�����
[num_r, num_c] = size(neg_all);
[r_slice_mat, c_slice_mat] = get_slice(par.Ts, par.Tf, num_r, num_c-1, IR, par.Rc);

% ѵ��
k = 1;
for i = 1:par.Ts
    for j = 1:par.Tf
        train_now = [pos_all(:,[c_slice_mat(k,:),num_c]); neg_all(r_slice_mat(k,:),[c_slice_mat(k,:),num_c])]; % train_now�������ݼ���һ��һ�����������һ����label
        option=svmsmoset('MaxIter',par.maxtime);
        model(k).svm = svmtrain(train_now(:,1:end-1),train_now(:,end),'kernel_function','rbf','rbf_sigma',par.sigma,'method','SMO','boxconstraint',par.C,'SMO_OPTS',option);
        k = k + 1;
        clear train_now;
    end%for_j
end%for_i

% ����
vote_mat = [];%�����ǲ������������������ǻ���������������c���ǵ�c�����������Ե�ǰ���в���������Ԥ��
for c = 1:k-1
    vote_now = svmclassify(model(c).svm,test_all(:,c_slice_mat(c,:)));
    vote_mat = [vote_mat,vote_now];
end%for_c
label_pre = get_aggregate(vote_mat);%Ԥ�������
label_test = test_all(:,end);%��ʵ�����

% ����
% ͳ��һ�ֵĽ��
res = get_binary_evaluate(label_pre,label_test);

end%function