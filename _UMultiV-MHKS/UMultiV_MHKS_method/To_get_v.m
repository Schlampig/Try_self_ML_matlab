function [v] = To_get_v(Result,train_binary_data,train_binary_label,universum_data,r_q,C,zet,gama,M,N,Nu,Row,Col,k_v_p,k)

%����ÿ���ӽ�ÿһ�εõ�v�Ĺ���
%train_binary_data:��ǰ����ѵ������
%train_binary_label:��ǰ����ѵ������������
%universum_data����ǰ����ѵ����������������universum����
%r_q������1/M
%M:�ӽ�����
%N:��������
%Nu:Universum������
%Row:���󻯺������е������
%Col:���󻯺������е������
%k_v_p:��ǰѭ������k_v_p���ӽ�
%k:��k�ε���

%����
Y = zeros(1,Col(k_v_p)+1);
for k_sample = 1:N
    A = reshape(train_binary_data(k_sample,:),Row(k_v_p),Col(k_v_p));
    y = train_binary_label(k_sample)*[Result(k_v_p).U(:,k)'*A,1]';
    Y = [Y;y'];
end%end_for_k_sample
Y = Y(2:N+1,:);

Yu = zeros(1,Col(k_v_p)+1);
for k_usample = 1:Nu
    Au = reshape(universum_data(k_usample,:),Row(k_v_p),Col(k_v_p));
    yu = [Result(k_v_p).U(:,k)'*Au,1]';
    Yu = [Yu;yu'];
end%end_for_k_usample
Yu = Yu(2:Nu+1,:);


v = pinv((1+gama*(1-r_q)^2)*(Y')*Y + C*Result(k_v_p).S2 + zet*(Yu')*Yu)*(Y')*(ones(N,1) + Result(k_v_p).B(:,k) + gama*(r_q*(1-r_q))*SumYv(Result,train_binary_data,train_binary_label,M,N,Row,Col,k_v_p,k));

