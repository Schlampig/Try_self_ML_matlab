function [pre_label] = McRFLD_fun(train_all, test_all, par)

% �����ѵ�������Ժ���
% train_all, test_all:���ݾ���һ��һ�����������һ����label
% par:�ṹ�壬����ֲ��������÷�ʽΪpar.X
% new_par: ���ص��²����ṹ��
% pre_label���Ե�ǰ���Լ���������ǵ�Ԥ�⣬һ��������

% ѡ��ģ��
modelname = par.modelname;

% ѵ��
train_label = train_all(:,end);
c_num = length(unique(train_label));
r = 1;
for i = 1:(c_num-1)
    for j = (i+1):c_num
        n_i = length(find(train_label == i));
        n_j = length(find(train_label == j));
        if n_i > n_j
            poslabel = j;
            neglabel = i;
        else
            poslabel = i;
            neglabel = j;
        end % if
        fea_pos = train_all(find(train_label == poslabel),:);
        fea_neg = train_all(find(train_label == neglabel),:);
        fea_pos(:,end) = 1;
        fea_neg(:,end) = 0;
        fea_train = [fea_pos;fea_neg];
        [clf] = eval([modelname,'_train(fea_train, par)']); %���õ�i���j������ѵ����ǰ������
        clf.poslabel = poslabel;
        clf.neglabel = neglabel;
        learner{r} = clf;
        r = r+1;
        clear poslabel;clear neglabel;
        clear fea_pos;clear fea_neg; 
        clear fea_train;
    end % for_j
end% for_i

% ����
vote_mat = [];
for i_test = 1:r-1
    clf = learner{i_test};
    vote_vec = eval([modelname,'_test(test_all, clf)']); %��ǰ�����������в��Լ�������Ԥ�⣬���ص���һ��������
    vote_vec(find(vote_vec == 1)) = clf.poslabel;
    vote_vec(find(vote_vec == 0)) = clf.neglabel;
    vote_mat = [vote_mat, vote_vec];
    clear clf;
end % for_i_test
pre_label = get_aggregate(vote_mat);   
        
end % function