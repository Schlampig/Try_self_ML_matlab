function [SumYv] = SumYv(Result,train_binary_data,train_binary_label,M,N,Row,Col,k_v_p,k)

%����q�ӽǣ������ӽ�p���µ�Yv֮��
%train_binary_data:��ǰ����ѵ������
%train_binary_label:��ǰ����ѵ������������
%M:�ӽ�����
%N:��������
%Row:���󻯺������е������
%Col:���󻯺������е������
%k_v_p:��ǰѭ������k_v_p���ӽ�
%k:��k�ε���

r_view = 0;
for k_multiviews = 1:M
    if k_multiviews == k_v_p
        continue;
    else
        r_view = r_view + 1;
        MVL(r_view).Y = zeros(1,Col(k_multiviews)+1);
        for k_sample = 1:N
            A = reshape(train_binary_data(k_sample,:),Row(k_multiviews),Col(k_multiviews));
            y = train_binary_label(k_sample)*[Result(k_multiviews).U(:,k)'*A,1]';
            MVL(r_view).Y = [MVL(r_view).Y;y'];
        end%end_for_k_sample
        MVL(r_view).Y = MVL(r_view).Y*Result(k_multiviews).V(:,k);
        MVL(r_view).Yf = MVL(r_view).Y(2:N+1,:);
    end%end_if
end%end_for_k_multiviews

SumYv = zeros(N,1);
for k_view =1:M-1
    SumYv = SumYv + MVL(k_view).Yf;
end%end_for_k_view