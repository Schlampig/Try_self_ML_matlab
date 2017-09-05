function [wk,w0k] = K1PILD_train(train_all, par)


%��ȡ����
dp_index = par.dp;
num_reg = par.reg;
ker_type = par.ktype;
ker_par = par.kpara;

% Ԥ����
[row_train,col_train] = size(train_all);
train_pos = train_all(find(train_all(:,end)==1),1:end-1);%�ҳ�����ѵ���������������train_pos,�ޱ��
train_neg = train_all(find(train_all(:,end)==0),1:end-1);%�ҳ�����ѵ���ĸ����������train_neg���ޱ��
dp = dp_Gernerate(dp_index,train_all(:,end));%����dp
X = [ones(row_train,1),[train_pos;train_neg]];%POS�����ǰ�棬NEG����ں��棬����ѵ���������� X in N*(D+1)
% Y = X'; % Y in (D+1)*N

%����˾���K
K =  kernel_fun(X, X, ker_type, ker_par); % K in N*N

%ʹ��KPILD��������ĳ�ƽ��
v = inv(K'*K + num_reg*K)*K'*dp; % v in N*1
wk_all = X'*v; % w_all in (D+1)*1
wk = wk_all(2:end,1);
w0k = wk_all(1,1);%w_all�ĵ�һ��Ԫ���Ǧȣ�w0����֮����w

end