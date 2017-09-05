function [C_final] = Lglocal_fun(train_binary_data,train_binary_label,k)

%����L^Glocal����ĺ���

%�������ŷֳ�L1_glocal��L2_glocal
[~,tempt_location] = unique(train_binary_label);%[a,b]=unique(A),a��������A�в��ظ���Ԫ�أ�ÿ��һ����b���ص�һ����ͬԪ�ص�λ��
n1 = tempt_location(2) - tempt_location(1);%n1��n2�ֱ��ǵ�һ��͵ڶ����������
n2 = size(train_binary_label,1) - n1;
train_sample(1).class = train_binary_data(1:n1,:);%������������
train_sample(2).class = train_binary_data(n1+1:n1+n2,:);

for i_Lglocal = 1:2
    X = train_sample(i_Lglocal).class';%��ǰ����
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
    C_2 = -C_2;
    
    d = sum(d_i);
    w_global = d_i/d;
    C_3 = diag(w_global,0);%diag����һ���ԽǾ���diag(A,K)��KΪ�������Խ����ϵ�K��������������
    
    L(i_Lglocal).matrix = C_2*C_3*C_2';
    clear C_0; clear C_1; clear C_2; clear C_3;
end%end_for_i_Lglocal
 
C_final = [L(1).matrix zeros(size(L(1).matrix,1),size(L(2).matrix,2));zeros(size(L(2).matrix,1),size(L(1).matrix,2)) L(2).matrix];












