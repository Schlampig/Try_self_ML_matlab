function [AMat] = kNNAM(data,k)

% k-Nearest Neighbor Affinity Matrix������ѵ������������ѵ������֮������ƶȾ���W��������LPP���Ⱥ˻��׾۴صȷ�����
% data:��������������ά����������������
% k:������
% sigma:�Ⱥ˹�ʽ�ĺ˲�������ĸ������Ĭ����data������������ƽ������
% AMat:һ��n*n�Ĺ�ϵ����n��data�����������

%��data�����������
    n = size(data,1);

%��ŷ�Ͼ������
    X_0 = data';%��ǰ������������ά����������������   
    X_1 = diag(X_0'*X_0);
    X_2 = X_1*ones(1,n) + ones(n,1)*X_1' - 2.*(X_0'*X_0);
    X_2 = sqrt(X_2);%||xi-xj||2
    
%��sigma
    %sigma = mean(mean(X_2));
    sigma = 1;
    
%��Ȩ�أ�����Խ��Ȩ��Խ�󣬾���Ϊ0ʱȨ��Ϊ1  
    X_3 = exp(-X_2./(2*sigma^2));%exp(||xi-xj||2/sigma)
    
%��k���ڣ�ǰk+1�����Ȩ�����£�
    k = k + 1;%��ΪҪ�����Լ����Լ��ľ���
    [~,index_1] = sort(-X_3,2);%ÿ��һ���������������ţ�����(Ȩ�ش��������ǰ��
    [~,index_2] = sort(index_1,2);
    X_4 = reshape(X_3,1,n*n);
    index_2 = reshape(index_2,1,n*n);
    X_4(find(index_2> k)) = 0;%�ҳ����ǽ��ڵ���������ֵΪ0
      
%�����Ĺ�ϵ����
   AMat = reshape(X_4,n,n); 
    
end%function  