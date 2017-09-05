function [w,w0] = PILD_train(train_all,dp_index)

[row_train,col_train] = size(train_all);

train_pos = train_all(find(train_all(:,end)==1),:);%�ҳ�����ѵ���������������train_pos
train_neg = train_all(find(train_all(:,end)==0),:);%�ҳ�����ѵ���ĸ����������train_neg
dp = dp_Gernerate(dp_index,train_all(:,col_train));%����dp
X = [ones(row_train,1),[train_pos;train_neg]];%POS�����ǰ�棬NEG����ں��棬����ѵ����������

w_all = inv(X'*X)*X'*dp;%α�淨����Ȩ������w_all(������)

w = w_all(2:col_train,1);
w0 = w_all(1,1);%w_all�ĵ�һ��Ԫ���Ǧȣ�w0����֮����w

end