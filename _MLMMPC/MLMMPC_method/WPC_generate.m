function [D] = WPC_generate(train_binary_data,n1,n2,wpc)

%���ɼ�Ȩwij��ϵ����D���㷨

%����ȫ����������ŷ�Ͼ��루Ҳ���Ը���������ľ������������
    X0 = train_binary_data';
    n = size(X0,2);%��������
    A=diag(X0'*X0);
    B=A';
    X1=A*ones(1,n) + ones(n,1)*B - 2.*(X0'*X0);
    X1=sqrt(X1);
    clear A;clear B;   
  
    D = wpc*(ones(n1+n2) - X1);
 








