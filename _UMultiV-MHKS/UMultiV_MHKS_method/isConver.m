function [tag] = isConver(Result,total_iter,train_binary_data,train_binary_label,universum_data,C,zet,gama,M,N,Nu,Row,Col,k)

%�ж��Ƿ񵽴����Ž�

%Result:������е�ǰ��u��v��v0��b����Ϣ
%k:��ǰ�ĵ�������
%total_iter:�ܵ�������

chi = 10^-4;

if k+1 == total_iter%����һ�ּ�����
    tag = 1;
else
    for k_view = 1:M
        L1 = J_objective_fun(Result,train_binary_data,train_binary_label,universum_data,C,zet,gama,M,N,Nu,Row,Col,k);
        L2 = J_objective_fun(Result,train_binary_data,train_binary_label,universum_data,C,zet,gama,M,N,Nu,Row,Col,k+1);   
    end%end_for_k_view  
    if norm(L2-L1,'fro')/norm(L1,'fro') <= chi
        tag = 1;
    else
        tag = 0;
    end%end_if
end%end_if






