function [L] = Lglocal_fun_wrong(train_binary_data,k)

%����L^Glocal����ĺ���


X = train_binary_data';
n = size(X,2);%��������
A=diag(X'*X);
B=A';
C_0=A*ones(1,n) + ones(n,1)*B - 2.*(X'*X);
C_0=sqrt(C_0);
sig = (std2(C_0))^2;%std2(A)=std(A(:))��������һ����������Ԫ�صľ�����
C_1 = exp(-C_0./(sig^2));%�õ�s_ij
 

%��k���ڣ�
C_1 = C_1 + diag(max(C_1(:)),0);
[~,index_1] = sort(C_1,2);%ÿ��һ����������������
[~,index_2] = sort(index_1,2);
C_tempt = reshape(C_1,1,n*n);
C_tempt(1,find(index_2>k)) = 0;%�ҳ����ǽ��ڵ���������ֵΪ0
C_2 = reshape(C_tempt,n,n);

%��local��global��glocal��
d_i = sum(C_2,2);%һ��һ������
d_i_multi = repmat(d_i,1,n);
C_2 = C_2 ./ d_i_multi;%��w_local

d = sum(d_i);
w_global = d_i/d;
L = C_2 + diag(w_global,0);%diag����һ���ԽǾ���diag(A,K)��KΪ�������Խ����ϵ�K��������������

