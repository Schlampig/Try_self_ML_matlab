function [I_mat] = PPIget(Q,K,wneg,wpos)

%����PPI��������㷨
%Q-��������
%K-����������
%wneg/wpos-����Ȩ��������������

[r_num,~] = size(K);
Z = [];
P_vec_temp = zeros(r_num,1);
P_vec = zeros(r_num,1);

for i_k = 1:r_num
    K_Q = K(i_k,:);%�˴�K_Q��������
    K_store = K;
    K(i_k,:) = [];
    K_rest = K;
    Q_label = K_Q(end);%��ȡ��ǰѵ�������ı��
    if Q_label == 1
        wp = wneg;
        K_nei = K_rest(find(K_rest(end)==1),:); 
    else
        wp = wpos;
        K_nei = K_rest(find(K_rest(end)==2),:);
    end
    r_nei = size(K_nei,1);
    xi = size(K_nei,1)/r_num;%�η�
    Pr_nei_all = 1;
    
    for i_k_rest = 1:r_nei-1
        Pr_temp = exp(-sum(wp.*((K_Q(:,1:end-1) - K_rest(i_k_rest,1:end-1)).*(K_Q(:,1:end-1) - K_rest(i_k_rest,1:end-1)))')); 
        Pr_nei_all = Pr_nei_all * (1 - Pr_temp);
    end%for_i_k_rest
     
    Z_temp = exp(-sum(wp.*((Q(:,1:end-1) - K_Q(:,1:end-1)).*(Q(:,1:end-1) - K_Q(:,1:end-1)))')); 
    Z = Z + Z_temp;
    P_vec_temp(i_k) = power(Z_temp,xi)*power(Pr_nei_all);%��i_k�����ںͲ���������p��ϵ��δ����Z֮ǰ��
    clear K_Q;clear K_rest;
    K = K_store;
end%for_i_k


P_vec = P_vec_temp./Z;

for i_I = 1:r_num
    I_vec(i_I) = -log(1-P_vec(i_I,:))*P_vec(i_I,:);
end%for_i_I


I_mat = [I_vec,K(:,end)];
I_mat = sortrows(I_mat,-1);%���յ�һ�����򣬽���I�����ŵ�һ��


















end