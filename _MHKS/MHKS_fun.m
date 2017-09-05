function [MHKSStruct] = MHKS_fun(train_binary_data,train_binary_label,InputPar)

%����MHKS�ĺ��ĺ�����ע����R2013a�����У������汾���ܻ���С��
%train_binary_data��ѵ�����ݼ���ÿһ��һ������
%train_binary_label��ѵ�����ݼ���Ӧ������
%InputPar������������C��b��


[~,tempt_location] = unique(train_binary_label);%[a,b]=unique(A),a��������A�в��ظ���Ԫ�أ�ÿ��һ����b���ص�һ����ͬԪ�ص�λ��
n1 = tempt_location(2) - tempt_location(1);%n1��n2�ֱ��ǵ�һ��͵ڶ����������
n2 = size(train_binary_label,1) - n1;%L�Ǹ�n*n�ķ���
train_binary_label(1:n1) = 1;%ת����Ϊ1��-1
train_binary_label(n1+1:n1+n2) = -1;

%��ʼ������
total_iter = 100;
w = zeros(size(train_binary_data,2),total_iter);
b = zeros(n1+n2,total_iter);
e = zeros(n1+n2,total_iter);
b(:,1) = InputPar.b * ones(n1+n2,1);
I = ones(n1+n2,1);%��ʽ���õ���ȫ1����
I_new = eye(size(train_binary_data,2));%���ں�C��˵ĵ�λ����
rho = 0.99;%p
eta = 10^(-4);%�ж���ֹ������
k_iter = 1;


%��ʼ����ѵ��
while (k_iter < total_iter)
          
    w(:,k_iter) = mat_get_w(train_binary_data,train_binary_label,InputPar,I,I_new,b(:,k_iter));
    e(:,k_iter) = mat_get_e(train_binary_data,train_binary_label,I,I_new,w(:,k_iter),b(:,k_iter));
    b(:,k_iter+1) = b(:,k_iter) + rho*(e(:,k_iter) + abs(e(:,k_iter)));
    stop_tag = norm(b(:,k_iter+1) - b(:,k_iter),2);
    
    if stop_tag < eta
        break;
    else
    k_iter = k_iter + 1;
    end%end_if    
    
end%while

if k_iter == total_iter
    MHKSStruct.w = w(:,k_iter-1);
    MHKSStruct.b = b(:,k_iter-1);
else
    MHKSStruct.w = w(:,k_iter); 
    MHKSStruct.b = b(:,k_iter);
end%end_if





