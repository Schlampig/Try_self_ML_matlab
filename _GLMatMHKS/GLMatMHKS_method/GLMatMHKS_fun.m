function [GLMatStruct] = GLMatMHKS_fun(train_binary_data,train_binary_label,InputPar,M_row,M_col,L)

%����GLMatMHKS�ĺ��ĺ�����ע����R2013a�����У������汾���ܻ���С����
%train_binary_data��ѵ�����ݼ���ÿһ��һ������
%train_binary_label��ѵ�����ݼ���Ӧ������
%InputPar������������k��C��lam��
%M_row����ǰ���󻯵�����
%M_col����ǰ���󻯵�����
%L��ARLE������ȫ�־ֲ���������

[~,tempt_location] = unique(train_binary_label);%[a,b]=unique(A),a��������A�в��ظ���Ԫ�أ�ÿ��һ����b���ص�һ����ͬԪ�ص�λ��
n1 = tempt_location(2) - tempt_location(1);%n1��n2�ֱ��ǵ�һ��͵ڶ����������
n2 = size(L,1) - n1;%L�Ǹ�n*n�ķ���
train_binary_label(1:n1) = 1;%ת����Ϊ1��-1
train_binary_label(n1+1:n1+n2) = -1;

%��ʼ������
total_iter = 100;
u = zeros(M_row + 1,total_iter);
v = zeros(M_col + 1,total_iter);
b = zeros(n1+n2,total_iter);
e = zeros(n1+n2,total_iter);
u(:,1) = [InputPar.u * ones(M_row,1);1];%u�����һ��Ϊ1
b(:,1) = InputPar.b * ones(n1+n2,1);
I = ones(n1+n2,1);%��ʽ���õ���ȫ1����
S_1 = M_row*eye(M_row);
S_2 = M_col*eye(M_col);
S1 = [S_1 zeros(size(S_1,1),1);zeros(1,size(S_1,2)) 1];
S2 = [S_2 zeros(size(S_2,1),1);zeros(1,size(S_2,2)) 1];
rho = 0.99;%p
eta = 10^(-4);%�ж���ֹ������
k_iter = 1;


%��ʼ����ѵ��
while (k_iter < total_iter)
          
    v(:,k_iter) = gl_get_v(train_binary_data,train_binary_label,InputPar,M_row,M_col,S2,I,u(:,k_iter),b(:,k_iter),L);
    e(:,k_iter) = gl_get_e(train_binary_data,train_binary_label,M_row,M_col,I,u(:,k_iter),v(:,k_iter),b(:,k_iter));
    b(:,k_iter+1) = b(:,k_iter) + rho*(e(:,k_iter) + abs(e(:,k_iter)));
    stop_tag = norm(b(:,k_iter+1) - b(:,k_iter),2);
    
    if stop_tag < eta
        break;
    else
        u(:,k_iter+1) = gl_get_u(train_binary_data,train_binary_label,InputPar,M_row,M_col,S1,I,v(:,k_iter),b(:,k_iter),L);
    end%end_if    
    k_iter = k_iter + 1;
    
end%while

if k_iter == total_iter
    GLMatStruct.u = u(:,k_iter);
    GLMatStruct.v = v(:,k_iter-1);
else
    GLMatStruct.u = u(:,k_iter);
    GLMatStruct.v = v(:,k_iter);    
end%end_if

%clear all;


