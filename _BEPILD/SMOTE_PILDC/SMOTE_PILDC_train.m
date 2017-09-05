function [w,w0,bpos,bneg,candi_dis_pos,candi_dis_neg] = SMOTE_PILDC_train(train_all,dp_index)

[row_train,~] = size(train_all);

train_pos = train_all(find(train_all(:,end)==1),1:end-1);%�ҳ�����ѵ���������������train_pos
train_neg = train_all(find(train_all(:,end)==0),1:end-1);%�ҳ�����ѵ���ĸ����������train_neg
dp = dp_Gernerate(dp_index,train_all(:,end));%����dp
X = [ones(row_train,1),[train_pos;train_neg]];%POS�����ǰ�棬NEG����ں��棬����ѵ����������

w_all = inv(X'*X)*X'*dp;%α�淨����Ȩ������w_all(������)

w = w_all(2:end,1);
w0 = w_all(1,1);%w_all�ĵ�һ��Ԫ���Ǧȣ�w0����֮����w



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

end