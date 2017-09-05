function [TMat] = get_eigen(A,B,Rdim)


% ��ȡ��ά����Ϣ�ĺ�������������ֵ�ֽⲽ�裬�� Aw = lamda*Bw
% TMat:Transform Matrix������Rdim�����������ı任����

%�ж�B�Ƿ�Ϊ��λ����
    r = size(B,1);
    C = eye(r);

%����ֵ�ֽ�
    if isequal(B,C) == 0 %B���ǵ�λ��˵���Ǻ����������㷨
        [eigvector, lamda] = eig(A,B);        
    elseif isequal(B,C) == 1 %B�ǵ�λ��˵����MMC����㷨
        [eigvector, lamda] = eig(A);
    end%if

%����ֵ����
    lamda_tempor = diag(lamda);%������ֵ�����Ϊ����
    [~, index] = sort(-lamda_tempor);%���������ֵ����ǰ��
    eigvector = eigvector(:,index);%(����һ��)����index��eigvector������ֵ�ǱߴӴ�С�������µ�����ǰ��
    TMat = eigvector(:,1:Rdim);%�õ����յı任������d*Rdimά��
    
end%function