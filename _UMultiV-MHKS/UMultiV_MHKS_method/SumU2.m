function [u2] = SumU2(Result,train_binary_data,train_binary_label,M,N,universum_data,Nu,Row,Col,zet,gama,r_q,k_v_p,k)

%u=pinv(u1)*u2,���Ǽ���u2�ĺ���
%train_binary_data:��ǰ����ѵ������
%train_binary_label:��ǰ����ѵ������������
%universum_data����ǰ����ѵ����������������universum����
%N:��������
%M:�ӽ�����
%Nu:Universum������
%Row:���󻯺������е������
%Col:���󻯺������е������
%k_v_p:��ǰѭ������k_v_p���ӽ�
%k:��k�ε���

u2 = zeros(Row(k_v_p),1);
for k_u2 =1:N
    A = reshape(train_binary_data(k_u2,:),Row(k_v_p),Col(k_v_p));
    u2 = u2 + A*Result(k_v_p).V(1:Col(k_v_p),k+1)*( train_binary_label(k_u2)*(1+Result(k_v_p).B(k_u2,k+1))...
        - Result(k_v_p).V(Col(k_v_p)+1,k+1)*(1+gama*(1-r_q)^2) + gama*(r_q*(1-r_q))*SumuAv(Result,train_binary_data,M,N,Row,Col,k_v_p,k) )...
        -zet*SumAv(universum_data,Nu,Result(k_v_p).V(1:Col(k_v_p),k+1),Result(k_v_p).V(Col(k_v_p)+1,k+1),Row(k_v_p),Col(k_v_p));
end%end_for_k_u2