function [model] = BERL_trainplot(train_all)

% ѵ�����BEPILD���ڻ�ͼ���㷨
% train_all�� ÿ��һ�����������һ�������ţ�0�Ƕ����࣬1��������

% Ԥ����
[row_train,col_train] = size(train_all);
train_pos = train_all(find(train_all(:,end)==1),1:end-1);%�ҳ�����ѵ���������������train_pos,�ޱ��
train_neg = train_all(find(train_all(:,end)==0),1:end-1);%�ҳ�����ѵ���ĸ����������train_neg���ޱ��
X = [ones(row_train,1),[train_pos;train_neg]];%POS�����ǰ�棬NEG����ں��棬����ѵ����������

% ʹ����������õ�����ĳ�ƽ��
% rng(42);%�̶�α���
a = -1;
b = 1;
w = a + (b-a).*rand(col_train-1,1); 
w = w/norm(w,'fro');% ��һ��

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
model.bpos = bpos;
model.bneg = bneg;
model.candi_dis_pos = candi_dis_pos;
model.candi_dis_neg = candi_dis_neg;

end%function

















