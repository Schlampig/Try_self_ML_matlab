function [e] = To_get_e(Result,train_binary_data,train_binary_label,Row,Col,N,k_v_p,k)

%����ÿ���ӽ�ÿһ�εõ�e�Ĺ���
%train_binary_data:��ǰ����ѵ������
%train_binary_label:��ǰ����ѵ������������
%Row:���󻯺������е������
%Col:���󻯺������е������
%N:��������
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
Y = Y*Result(k_v_p).V(:,k);


e = Y - ones(N,1) - Result(k_v_p).B(:,k);