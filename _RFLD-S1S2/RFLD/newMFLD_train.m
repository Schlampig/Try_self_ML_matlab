function [w,w0] = newMFLD_train(train_all, dp_index, num_reg, k, c)

% ѵ��MFLD���㷨
% train_all�� ÿ��һ�����������һ�������ţ�0�Ƕ����࣬1��������
% dp_index:����ѡ�����ɵ�dp������label��ֵ������dp_Gernerate()
% num_reg: ����Ȩ�ز����������� reg=0�������Ŷ���regԽ���Ŷ�Խ��
% k������Slw��Ҫ���ڸ���
% c���ͷ����ӣ�cSw+(1-c)Slw

% Ԥ����
[row_train, col_train] = size(train_all);
train_pos = train_all(find(train_all(:,end)==1),1:end-1);%�ҳ�����ѵ���������������train_pos,�ޱ��
train_neg = train_all(find(train_all(:,end)==0),1:end-1);%�ҳ�����ѵ���ĸ����������train_neg���ޱ��
dp = dp_Gernerate(dp_index,train_all(:,end));%����dp
X = [train_pos;train_neg];%POS�����ǰ�棬NEG����ں��棬����ѵ���������� NxD
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
w = inv( c*Sw + (1-c)*Slw + I_reg)*(m1 - m2)'; % Dx1
w0 = - sum(X*w - dp)/row_train; % 1x1


end