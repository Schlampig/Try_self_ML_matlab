function [sum_uAv] = SumuAv(Result,train_binary_data,M,N,Row,Col,k_v_p,k)

%����q�ӽǣ������ӽ�p���µ�Yv֮��
%train_binary_data:��ǰ����ѵ������
%M:�ӽ�����
%N:��������
%Row:���󻯺������е������
%Col:���󻯺������е������
%k_v_p:��ǰѭ������k_v_p���ӽ�
%k:��k�ε���

sum_uAv = 0;
for k_multiviews = 1:M
    if k_multiviews == k_v_p
        continue;
    else
        sumuAv_tempt = 0;
        for k_sample = 1:N
            A = reshape(train_binary_data(k_sample,:),Row(k_multiviews),Col(k_multiviews));
            sumuAv_tempt = sumuAv_tempt + ( Result(k_multiviews).U(:,k)'*A*Result(k_multiviews).V(1:Col(k_multiviews),k) + Result(k_multiviews).V(Col(k_multiviews)+1,k) );
        end%end_for_k_sample
        sum_uAv = sum_uAv + sumuAv_tempt;
    end%end_if
end%end_for_k_multiviews
