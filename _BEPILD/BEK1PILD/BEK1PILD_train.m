function [model,flag] = BEK1PILD_train(train_all, par)

% ѵ��BEK1PILD���㷨
% train_all�� ÿ��һ�����������һ�������ţ�0�Ƕ����࣬1��������
% dp_index:����ѡ�����ɵ�dp������label��ֵ������dp_Gernerate()
% par�������˲���������

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
Y = X'; % Y in (D+1)*N

%����˾���K
K =  kernel_fun(Y, ker_type, ker_par); % K in N*N

%ʹ��KPILD��������ĳ�ƽ��
v = inv(K'*K + num_reg*K)*K'*dp; % v in N*1
wk_all = Y*v; % w in (D+1)*1
wk = wk_all(2:end,1);
w0k = wk_all(1,1);%w_all�ĵ�һ��Ԫ���Ǧȣ�w0����֮����w

% �ҳ���������ӽ���Ե�ĵ㣬ʹ�� predict = w'*x + w0
[num_min_pos,index_min_pos] = min(sum(repmat(wk',size(train_pos,1),1).*train_pos,2) + w0k*ones(size(train_pos,1),1));
[num_max_neg,index_max_neg] = max(sum(repmat(wk',size(train_neg,1),1).*train_neg,2) + w0k*ones(size(train_neg,1),1));

if num_min_pos > num_max_neg %������û���ཻ�����Է�������Էֿ����ߣ� �����߽���е�Ϊ�����ģ����õ�����
    flag = 1;
    mcenter = mean(train_pos(index_min_pos,:)+train_neg(index_max_neg,:)); %�߽�����ĵ�
    bcenter = -wk'*mcenter; %���ĵ�ؾ�
    model.w = wk;
    model.w0 = bcenter;
elseif num_min_pos == num_max_neg % �������ཻ�ĵط������Ǳ߽磬�Ա߽�Ϊ��������ֱ��
    flag = 1;
    bcenter = -wk'*train_pos(index_min_pos,:);train_pos(index_min_pos,:)
    model.w = wk;
    model.w0 = bcenter;
else%�����ཻ����
    flag = 0;
    
    % ʹ��PILD�������ߵĳ�ƽ��
    I_reg = num_reg * eye(col_train); %���������Ŷ���
    w_all = inv(X'*X + I_reg)*X'*dp;%α�淨����Ȩ������w_all(������)
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

    model.w = w;
    model.w0 = w0;
    model.bpos = bpos;
    model.bneg = bneg;
    model.candi_dis_pos = candi_dis_pos;
    model.candi_dis_neg = candi_dis_neg;
end%if



end%function

















