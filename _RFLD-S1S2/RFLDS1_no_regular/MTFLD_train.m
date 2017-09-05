function [w,w0] = MTFLD_train(train_all, dp_index, num_reg, theta)


% ��ʼ��
dp = dp_Gernerate(dp_index,train_all(:,end));%����dp
I_reg = num_reg * eye(size(train_all,2)-1); %���������Ŷ���

X_pos = train_all(find(train_all(:,end)==1),1:end-1);% ����ѵ����������,�ޱ��
X_neg = train_all(find(train_all(:,end)==0),1:end-1);% ����ѵ�����������ޱ��
N_pos = size(X_pos,1);% ѵ�������������
N_neg = size(X_neg,1);% ѵ�������������
X_all = [X_pos;X_neg];% ��ѵ���������� NxD

% ����������ɢ�Ⱦ���Sw�;�ֵm_pos��m_neg 
[S_pos,m_pos] = SCAM(X_pos);
[S_neg,m_neg] = SCAM(X_neg);
Sw = S_pos + S_neg; % Sw��S_pos��S_neg����DxDά, ע��m_pos��m_neg��1xDά

% ����Ȩֵ����w
w = inv(Sw + I_reg)*(m_pos - m_neg)'; % Dx1

% ����ͶӰ��ֵ����u_pos��u_neg��ͶӰ����������o_pos��o_neg
u_pos = mean(X_pos*w); % �����ĸ�ֵ���� 1x1
u_neg = mean(X_neg*w);
o_pos = std(X_pos*w);
o_neg = std(X_neg*w);

% �����������ļ�����������Xb_pos��Xb_neg���������Nb_pos��Nb_neg
[Xb_pos,Nb_pos] = get_between(X_pos,w,u_pos,u_neg);
[Xb_neg,Nb_neg] = get_between(X_neg,w,u_pos,u_neg);

% �����ĸ�����par1��par2��par3��par4
par1_pos = get_par(X_pos,N_pos,w,u_pos,0); %����1x1
par1_neg = get_par(X_neg,N_neg,w,u_neg,0);
par2_pos = get_par(Xb_pos,Nb_pos,w,u_pos,0);
par2_neg = get_par(Xb_neg,Nb_neg,w,u_neg,0);
par3_pos = get_par(X_pos,N_pos,w,u_pos,1);
par3_neg = get_par(X_neg,N_neg,w,u_neg,1);
par4_pos = get_par(Xb_pos,Nb_pos,w,u_pos,1);
par4_neg = get_par(Xb_neg,Nb_neg,w,u_neg,1);

% ����thetaȡֵ����w0
if theta ~= 11
    switch theta
        case 1 % ����ͳFLD��ͨ����Ϊ�Ա�
            w0 = - sum(X_all*w - dp)/(N_pos + N_neg); % 1x1
        case 2
            w0 = - (u_pos + u_neg)/2;
        case 3
            w0 = - (N_neg*u_pos + N_pos*u_neg)/(N_pos + N_neg);
        case 4
            w0 = - (o_neg*u_pos + o_pos*u_neg)/(o_pos + o_neg);
        case 5
            w0 = - ((N_neg*u_pos + N_pos*u_neg)/(N_pos + N_neg) + (o_neg*u_pos + o_pos*u_neg)/(o_pos + o_neg))/2 ; % �� ��w0_3 + w0_4��/2
        case 6
            w0 = - (par1_neg*u_pos + par1_pos*u_neg)/(par1_pos + par1_neg);
        case 7
            a = 1/o_pos^2 - 1/o_neg^2;
            b = -2*(u_pos/o_pos - u_neg/o_neg);
            c = 2*(log(o_pos)-log(o_neg)) + ((u_pos/o_pos)^2 - (u_neg/o_neg)^2);
            w0 = - 1/(2*a) * (- b - sqrt(b^2-4*a*c));
        case 8
            w0 = - (par2_neg*u_pos + par2_pos*u_neg)/(par2_pos + par2_neg);
        case 9
            w0 = - (par3_neg*u_pos + par3_pos*u_neg)/(par3_pos + par3_neg);
        case 10
            w0 = - (par4_neg*u_pos + par4_pos*u_neg)/(par4_pos + par4_neg);
    end%switch
else
    w2 = - (u_pos + u_neg)/2;
    w3 = - (N_neg*u_pos + N_pos*u_neg)/(N_pos + N_neg);
    w4 = - (o_neg*u_pos + o_pos*u_neg)/(o_pos + o_neg);
    w5 = - ((N_neg*u_pos + N_pos*u_neg)/(N_pos + N_neg) + (o_neg*u_pos + o_pos*u_neg)/(o_pos + o_neg))/2 ; % �� ��w0_3 + w0_4��/2
    w6 = - (par1_neg*u_pos + par1_pos*u_neg)/(par1_pos + par1_neg);
    a = 1/o_pos^2 - 1/o_neg^2;
    b = -2*(u_pos/o_pos - u_neg/o_neg);
    c = 2*(log(o_pos)-log(o_neg)) + ((u_pos/o_pos)^2 - (u_neg/o_neg)^2);
    w7 = - 1/(2*a) * (-b-sqrt(b^2-4*a*c));
    w8 = - (par2_neg*u_pos + par2_pos*u_neg)/(par2_pos + par2_neg);
    w9 = - (par3_neg*u_pos + par3_pos*u_neg)/(par3_pos + par3_neg);
    w10 = - (par4_neg*u_pos + par4_pos*u_neg)/(par4_pos + par4_neg);
    w0 = (w2 + w3 + w4 + w5 + w6 + w7 + w8 + w9 + w10)/9; % w0��ǰ�����w0��ϵľ�ֵ����ͳFLD���⣩
end%if

end