function [u1] = SumU1(Result,train_binary_data,N,universum_data,Nu,Row,Col,C,zet,gama,r_q,k_v_p,k)

%u=pinv(u1)*u2,���Ǽ���u1�ĺ���
%train_binary_data:��ǰ����ѵ������
%universum_data����ǰ����ѵ����������������universum����
%N:��������
%Nu:Universum������
%Row:���󻯺������е������
%Col:���󻯺������е������
%k_v_p:��ǰѭ������k_v_p���ӽ�
%k:��k�ε���

u1 = (1+gama*(1-r_q)^2)*SumAvvA(train_binary_data,N,Result(k_v_p).V(1:Col(k_v_p),k+1),Row(k_v_p),Col(k_v_p)) + C*Result(k_v_p).S1 + zet*SumAvvA(universum_data,Nu,Result(k_v_p).V(1:Col(k_v_p),k+1),Row(k_v_p),Col(k_v_p));