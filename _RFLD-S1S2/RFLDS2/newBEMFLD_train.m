function [model,flag] = newBEMFLD_train(train_all, dp_index, num_reg, k, c)

% ѵ��BEMFLD���㷨
% train_all�� ÿ��һ�����������һ�������ţ�0�Ƕ����࣬1��������
% dp_index:����ѡ�����ɵ�dp������label��ֵ������dp_Gernerate()
% num_reg: ����Ȩ�ز����������� reg=0�������Ŷ���regԽ���Ŷ�Խ��
% k������Slw��Ҫ���ڸ���
% c��Ȩֵ���ӣ�cSw+(1-c)Slw

% Ԥ����
[row_train, col_train] = size(train_all);
train_pos = train_all(find(train_all(:,end)==1),1:end-1);%�ҳ�����ѵ���������������train_pos,�ޱ��
train_neg = train_all(find(train_all(:,end)==0),1:end-1);%�ҳ�����ѵ���ĸ����������train_neg���ޱ��
dp = dp_Gernerate(dp_index,train_all(:,end));%����dp
X = [train_pos;train_neg];%POS�����ǰ�棬NEG����ں��棬����ѵ���������� NxD���ޱ��
I_reg = num_reg * eye(col_train-1); %���������Ŷ���


% ����Sw��Slw
% ����Sw��m1��m2���мල��
[S1,m1] = SCAM(train_pos);
[S2,m2] = SCAM(train_neg);
Sw = S1 + S2; % Sw��S1��S2����DxDά, ע��m1��m2��1xDά

%����Slw���мල��
options = [];
options.NeighborMode = 'Supervised';
options.gnd = train_all(:,end);%ȫ��ѵ�������������������
options.NeighborMode = 'KNN';
options.k = k;
options.WeightMode = 'HeatKernel';
options.t = 1;
W = constructW(X,options);%���������
D = diag(sum(W,2));
Slw = X'*(D-W)*X;%���d*d�İ�������

% ��ԭʼ��ƽ�����w��w0
w = inv(c*Sw + (1-c)*Slw + I_reg)*(m1 - m2)'; % Dx1
w0 = - sum(X*w - dp)/row_train; % 1x1

% BE-model:
% �ҳ���������ӽ���Ե�ĵ㣬ʹ�� predict = w'*x + w0
[num_min_pos,index_min_pos] = min(sum(repmat(w',size(train_pos,1),1).*train_pos,2) + w0*ones(size(train_pos,1),1));
[num_max_neg,index_max_neg] = max(sum(repmat(w',size(train_neg,1),1).*train_neg,2) + w0*ones(size(train_neg,1),1));

if num_min_pos > num_max_neg %������û���ཻ�����Է�������Էֿ����ߣ� �����߽���е�Ϊ�����ģ����õ�����
    flag = 1;
    mcenter = mean(train_pos(index_min_pos,:) + train_neg(index_max_neg,:)); %�߽�����ĵ�
    bcenter = -w'*mcenter; %���ĵ�ؾ�
    model.w = w;
    model.w0 = bcenter;
elseif num_min_pos == num_max_neg % �������ཻ�ĵط������Ǳ߽磬�Ա߽�Ϊ��������ֱ��
    flag = 1;
    bcenter = -w'*train_pos(index_min_pos,:)';
    model.w = w;
    model.w0 = bcenter;
else%�����ཻ����
    flag = 0;
    
    upos = mean(train_pos(:,:))';%������ѵ��������ֵ�㣬�Ǹ�dά������
    uneg = mean(train_neg(:,:))';%����ѵ��������ֵ��
    bpos = -w'*upos;%�ֱ�������������������ƽ�е���Ľؾ�
    bneg = -w'*uneg;
    
    pos_index = sum(repmat(w',row_train,1).*X,2) + bpos*ones(row_train,1);
    neg_index = sum(repmat(w',row_train,1).*X,2) + bneg*ones(row_train,1);

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

















