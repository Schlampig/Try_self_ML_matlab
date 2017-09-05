function [model,flag] = BEPILD_train(train_all, dp_index, num_reg)

% ѵ��BEPILD���㷨
% train_all�� ÿ��һ�����������һ�������ţ�0�Ƕ����࣬1��������
% dp_index:����ѡ�����ɵ�dp������label��ֵ������dp_Gernerate()

% Ԥ����
[row_train,col_train] = size(train_all);
train_pos = train_all(find(train_all(:,end)==1),1:end-1);%�ҳ�����ѵ���������������train_pos,�ޱ��
train_neg = train_all(find(train_all(:,end)==0),1:end-1);%�ҳ�����ѵ���ĸ����������train_neg���ޱ��
dp = dp_Gernerate(dp_index,train_all(:,end));%����dp
X = [ones(row_train,1),[train_pos;train_neg]];%POS�����ǰ�棬NEG����ں��棬����ѵ����������
I_reg = num_reg * eye(col_train); %���������Ŷ���

% ʹ��PILD��������ĳ�ƽ��
w_all = inv(X'*X + I_reg)*X'*dp;%α�淨����Ȩ������w_all(������)
w = w_all(2:end,1);
w0 = w_all(1,1);%w_all�ĵ�һ��Ԫ���Ǧȣ�w0����֮����w

% �ҳ���������ӽ���Ե�ĵ㣬ʹ�� predict = w'*x + w0
[num_min_pos,index_min_pos] = min(sum(repmat(w',size(train_pos,1),1).*train_pos,2) + w0*ones(size(train_pos,1),1));
[num_max_neg,index_max_neg] = max(sum(repmat(w',size(train_neg,1),1).*train_neg,2) + w0*ones(size(train_neg,1),1));

if num_min_pos > num_max_neg %������û���ཻ�����Է�������Էֿ����ߣ� �����߽���е�Ϊ�����ģ����õ�����
    flag = 1;
    mcenter = mean(train_pos(index_min_pos,:)+train_neg(index_max_neg,:)); %�߽�����ĵ�
    bcenter = -w'*mcenter; %���ĵ�ؾ�
    model.w = w;
    model.w0 = bcenter;
elseif num_min_pos == num_max_neg % �������ཻ�ĵط������Ǳ߽磬�Ա߽�Ϊ��������ֱ��
    flag = 1;
    bcenter = -w'*train_pos(index_min_pos,:);train_pos(index_min_pos,:);
    model.w = w;
    model.w0 = bcenter;
else%�����ཻ����
    flag = 0;
    
    upos = mean(train_pos(:,:))';%������ѵ��������ֵ�㣬�Ǹ�dά������
    uneg = mean(train_neg(:,:))';%����ѵ��������ֵ��
    bpos = -w'*upos;%�ֱ�������������������ƽ�е���Ľؾ�
    bneg = -w'*uneg;

    X_temp = X(:,2:end);

    pos_index = sum(repmat(w',row_train,1).*X_temp,2) + bpos*ones(row_train,1);
    neg_index = sum(repmat(w',row_train,1).*X_temp,2) + bneg*ones(row_train,1);

    train_new = train_all(intersect(find(pos_index<0),find(neg_index>0)),:);%ѡ�����ڹ�������ƽ���ڷ������ƽ������������Ϊ�µ�ѵ�������㣬�����
    train_new_pos = train_new(find(train_new(:,end)==1),:);%�ҳ���ѵ���������������train_new_pos
    train_new_neg = train_new(find(train_new(:,end)==0),:);%�ҳ���ѵ���������������train_new_neg

    [train_new_pos_r,~] = size(train_new_pos);
    [train_new_neg_r,~] = size(train_new_neg);
    candi_dis_pos = abs(sum(repmat(w',train_new_pos_r,1) .* train_new_pos(:,1:end-1),2) + bpos*ones(train_new_pos_r,1));%�������ѵ��pos�㵽���ĵľ���
    candi_dis_neg = abs(sum(repmat(w',train_new_neg_r,1) .* train_new_neg(:,1:end-1),2) + bneg*ones(train_new_neg_r,1));%�������ѵ��neg�㵽���ĵľ���

    model.w = w;
    model.w0 = w0;
    model.bpos = bpos;
    model.bneg = bneg;
    model.candi_dis_pos = candi_dis_pos;
    model.candi_dis_neg = candi_dis_neg;
end%if



end%function

















