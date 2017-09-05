function [model,flag] = BESVML_train(train_all, C)

% ѵ��BESVML���㷨
%train_all�� ÿ��һ�����������һ�������ţ�0�Ƕ����࣬1��������

%Ԥ����
train_pos = train_all(find(train_all(:,end)==1),1:end-1);%�ҳ�����ѵ���������������train_pos,�ޱ��
train_neg = train_all(find(train_all(:,end)==0),1:end-1);%�ҳ�����ѵ���ĸ����������train_neg���ޱ��

%ѵ����ʼ������
option=svmsmoset('MaxIter',3000000);%��������������
SVMmodel = svmtrain(train_all(:,1:end-1),train_all(:,end),'kernel_function','linear','method','SMO','boxconstraint',C,'SMO_OPTS',option);
mat_sv = SVMmodel.SupportVectors;%֧����������һ��һ������������ά��
vec_alpha = SVMmodel.Alpha; %֧������Ȩ�ئ���һ��������
b = SVMmodel.Bias; %�ؾ�b��һ������

% ����prediction�ҳ���������ӽ���Ե�ĵ�
[num_min_pos,~] = min(svmlpre(train_pos,mat_sv,vec_alpha,b));
[num_max_neg,~] = min(svmlpre(train_neg,mat_sv,vec_alpha,b));

if num_min_pos >= num_max_neg %������û���ཻ�����Է�������Էֿ�����  
    flag = 1;
    model = SVMmodel;

else%�����ཻ����
    flag = 0;
    
    upos = mean(train_pos);%������ѵ��������ֵ�㣬�Ǹ�dά������
    uneg = mean(train_neg);%����ѵ��������ֵ��
    bpos = svmlb(upos, mat_sv, vec_alpha);%�ֱ�������������������ƽ�е���Ľؾ�
    bneg = svmlb(uneg, mat_sv, vec_alpha);  
    
    pos_index = svmlpre(train_pos,mat_sv,vec_alpha,bpos);  
    neg_index = svmlpre(train_neg,mat_sv,vec_alpha,bneg);

    train_new = train_all(intersect(find(pos_index<0),find(neg_index>0)),:);%ѡ�����ڹ�������ƽ���ڷ������ƽ������������Ϊ�µ�ѵ�������㣬�����
    train_new_pos = train_new(find(train_new(:,end)==1),1:end-1);%�ҳ���ѵ���������������train_new_pos
    train_new_neg = train_new(find(train_new(:,end)==0),1:end-1);%�ҳ���ѵ���������������train_new_neg

    [train_new_pos_r,~] = size(train_new_pos);
    [train_new_neg_r,~] = size(train_new_neg);
    candi_dis_pos = abs(svmlpre(train_new_pos,mat_sv,vec_alpha,bpos));%�������ѵ��pos�㵽���ĵľ���
    candi_dis_neg = abs(svmlpre(train_new_neg,mat_sv,vec_alpha,bneg));%�������ѵ��neg�㵽���ĵľ���

    model.mat_sv = mat_sv;
    model.vec_alpha = vec_alpha;
    model.b = b;
    model.bpos = bpos;
    model.bneg = bneg;
    model.candi_dis_pos = candi_dis_pos;
    model.candi_dis_neg = candi_dis_neg;
end%if



end%function

















