function [sum_AvvA] = SumAvvA(tempt_data,total_num,v,M_row,M_col)

%����p�ӽ��µ�YvvY��YuvvuY֮��
%tempt_data:��Ҫ�����������train_binary_data��universum_data��
%total_num:��Ҫ�����������������N��Nu��
%v:��ǰ�����Ȩ������v
%M_row:��ǰ���󻯵�����
%M_col:��ǰ���󻯵�����

%���󻯲����
sum_AvvA = 0;
for k_sum = 1:total_num
    A = reshape(tempt_data(k_sum,:),M_row,M_col);
    sum_AvvA = sum_AvvA + A*v*v'*A';
end%end_for_k_sum
