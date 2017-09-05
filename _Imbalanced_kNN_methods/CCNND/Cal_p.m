function [p_res] = Cal_p(train,k)

%����һ�����ݼ������������룬���������ĸ���p��
%p = �ȵ�һ��������������������/����һ���������������������

    X = train';%��ǰ������ÿ��һ������
    n = size(X,2);%��������
    A=diag(X'*X);
    B=A';
    C =A*ones(1,n) + ones(n,1)*B - 2.*(X'*X);
    C = sqrt(C);
    mat_res = max(max(C))*eye(size(X,2)) + C;%���Լ����Լ�����ľ�������Ϊ��󣬲�������㡣
    
    I_temp = zeros(n,k);%���ÿ������������������������ǰk�����ڵĲ�ֵ�ľ��󣬲�ֵ��С�������У���һ���ǲ���������ǰk����ֵ
    for i_d = 1:n
        [~,index1] =  sort(mat_res(i_d,:));
        [~,index2] = sort(index1);
        vec_temp = mat_res(i_d,find(index2<(k+1)));
        I_temp(i_d,:) = sort(vec_temp);
        clear vec_temp;
    end%for_i_d
    
    I_temp2 = repmat(I_temp(1,:),n-1,1) - I_temp(2:n,:);
    I_temp2(find(I_temp2>=0)) = 0;
    I_temp2(find(I_temp2<0)) = -1;
    I_temp3 = sum(I_temp2,2);
    S = length(I_temp3(find(I_temp3==-1*size(I_temp3,2))));%���������������ѵ��������
    
    S_all = n-1;%ͬһ��ѵ����������
    p_res = S/S_all;
    
end