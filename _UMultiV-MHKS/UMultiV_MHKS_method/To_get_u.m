function [u] = To_get_u(Result,train_binary_data,train_binary_label,universum_data,M,N,Nu,Row,Col,C,zet,gama,r_q,k_v_p,k)

%����ÿ���ӽ�ÿһ�εõ�u�Ĺ���

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

u = pinv(SumU1(Result,train_binary_data,N,universum_data,Nu,Row,Col,C,zet,gama,r_q,k_v_p,k))*(SumU2(Result,train_binary_data,train_binary_label,M,N,universum_data,Nu,Row,Col,zet,gama,r_q,k_v_p,k));




%Result(k_v_p).V(1:M_col(k_view),k+1)=v
%Result(k_v_p).V(M_col(k_view)+1,k+1)=v0
%Result(k_v_p).B(:,k+1)=b
%Result(k_view).S1
%M_row(k_v_p)
%M_col(k_v_p)