function [K] =  kernel_fun(Y, ker_type, ker_par)

% ���ɺ˾���
% Y���������� ÿ��һ��������(D+1)*N
% ker_type��ѡ��˺���
% ker_par��ѡ��˺�����Ӧ�Ĳ���

if strcmp(ker_type,'lin')
    K = Y'*Y;
elseif strcmp(ker_type,'poly')
    K = (Y'*Y + 1).^ker_par;
elseif strcmp(ker_type,'rbf')
    %��data�����������
    n = size(Y,2);
    %��ŷ�Ͼ������  
    X_1 = diag(Y'*Y);
    X_2 = X_1*ones(1,n) + ones(n,1)*X_1' - 2.*(Y'*Y);
    X_2 = sqrt(X_2);%||xi-xj||2
    %��Ȩ�أ�����Խ��Ȩ��Խ�󣬾���Ϊ0ʱȨ��Ϊ1  
    K = exp(-X_2/(2*ker_par^2));%exp(||xi-xj||2/2*sigma^2)
end%if

end %function